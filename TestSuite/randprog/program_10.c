/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 3821190806492938240
*/

#include <stdio.h>

#define MAX_DEPTH (5)
unsigned long context = 0;
long DEPTH = 0;
void DumbHash( unsigned long value, unsigned int len )
{
   context += value;
   context ^= 0xA50F5AF0;
}
/* --- GLOBAL VARIABLES --- */
short g_41763489 = 0x1BD9;


/* --- FORWARD DECLARATIONS --- */
int func_46266394(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_46266394(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned short l_45774920 = 0x1515;
for ( l_45774920 = 0; l_45774920 < 100; ++l_45774920 )
{
unsigned long l_57676213 = 0x83E0BAC9;
l_45774920 = l_57676213;
}
DEPTH--;
return g_41763489;
DEPTH--;
return l_45774920;
DEPTH--;
}
else
return 0x26C28E65;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_46266394(  );
DumbHash( g_41763489, 2 );
printf( "%d\n", context );
return 0;
}


