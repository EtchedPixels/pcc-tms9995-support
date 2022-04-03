/*
 *	This is an ANSI C version of the classic K & R memory allocator. The only
 *	real difference here is that we handle large allocations and signs correctly
 *	which the original didn't do portably. Specifically we
 *	- correctly handle signed sbrk when the largest allocation allowed is
 *	  unsigned
 *	- catch the case of a malloc close to the full size_t overflowing in the
 *	  nblock computation.
 */

#define _MALLOC_PRIVATE
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include "malloc.h"

struct memh __mroot = { &__mroot, 0 };

struct memh *__mfreeptr = &__mroot;

static struct memh *brkmore(size_t nb)
{
	struct memh *p;

	if (nb < BRKSIZE)
		nb = BRKSIZE;

	/* Here be dragons: sbrk takes a signed value. We can however in C malloc
	   a size_t: We also assume nobody else misaligns the brk boundary, we won't
	   fix it if so - maybe we should ? */

	/* Current end of memory */
	p = sbrk(0);
	if (p == (struct memh *) -1)
		return NULL;
	/* Overflow catch */
	if ((uintptr_t)p + sizeof(struct memh) * nb < (uintptr_t)p)
		return NULL;
	/* Move our break point. Using brk this way avoids the sign problems */
	if (brk(p + nb))
		return NULL;
	/* Fake it as a used block and free it into the free list */
	p->size = nb;
	free(p + 1);
	return __mfreeptr;
}

void *malloc(size_t size)
{
	struct memh *p, *prev;
	size_t nblocks;

	nblocks = size + sizeof(struct memh) + sizeof(struct memh) - 1;
	/* Cheap way to catch overflow */
	if (nblocks < size)
		return NULL;
	nblocks /= sizeof(struct memh);

	prev = __mfreeptr;

	for (p = prev->next;; prev = p, p = p->next) {
		if (p->size >= nblocks) {
			if (p->size == nblocks)
				/* We found a hole the right size so unlink it */
				prev->next = p->next;
			else {
				/* Split a hole */
				p->size -= nblocks;
				/* Move down the block and hand the end of it to the user, to avoid
				   having to move the links. Our realloc depends upon this */
				p += p->size;
				p->size = nblocks;
			}
			/* Ensure its a valid start point and optimal for malloc(x)/free(x) */
			__mfreeptr = prev;
			return (void *) (p + 1);
		}
		/* We've done one orbit.. */
		if (p == __mfreeptr) {
			if ((p = brkmore(nblocks)) == NULL)
				return NULL;
		}
	}
}
