/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 59705650548047872
*/

#include <stdio.h>

#define MAX_DEPTH (5)
unsigned long context = 0;
long DEPTH = 0;
__attribute__((always_inline)) void DumbHash( unsigned long value, unsigned int len )
{
   context += value;
   context ^= 0xA50F5AF0;
}
/* --- GLOBAL VARIABLES --- */


/* --- FORWARD DECLARATIONS --- */
__attribute__((always_inline)) int func_33691508(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
__attribute__((always_inline)) int func_33691508(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
short l_62934754 = 0x7F1A;
unsigned short l_81221924 = 0x57AF;
l_62934754 = 0xB9AFF927;
l_62934754 = l_62934754;
DEPTH--;
return l_81221924;
DEPTH--;
}
else
return 0x6010DE51;
}




/* ---------------------------------------- */
int main( int argc, char **argv )
{
   /* Call the first function */
   func_33691508(  );
printf( "%d\n", context );
return 0;
}

