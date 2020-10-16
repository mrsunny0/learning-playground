#ifndef __UTIL_H__
#define __UTIL_H__

#define OP_STR_LEN		7
#define ARG_STR_LEN		15

unsigned long div(unsigned long dividend, unsigned long divisor);
int modulus(int dividend, int divisor);
void _int2asciihex(unsigned int num, unsigned char ascii_val[]);
void _char2asciihex(unsigned char num, unsigned char ascii_val[]);

#endif /* __UTIL_H__ */
