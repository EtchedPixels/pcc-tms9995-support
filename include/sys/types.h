#ifndef _SYS_TYPES_H
#define _SYS_TYPES_H

#include <stddef.h>
#include <stdint.h>

/* USER! basic data types */
/* ! uchar & uint is counterparts and must be declared simultaneously */

#ifndef uchar_is_defined
#define uchar_is_defined
typedef unsigned char uchar;
typedef unsigned int uint;
#endif

#if !defined(__SIZE_T_DEFINED) && !defined(_SIZE_T_DEFINED)
#define __SIZE_T_DEFINED
typedef uint16_t size_t;
#endif

#if !defined(__SSIZE_T_DEFINED) && !defined(_SSIZE_T_DEFINED)
#define __SSIZE_T_DEFINED
typedef int16_t ssize_t;
#endif

typedef char * caddr_t;
typedef long daddr_t;
typedef long key_t;

#endif
