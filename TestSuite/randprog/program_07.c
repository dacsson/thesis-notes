/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 7642381608690909184
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
short g_72873263 = 0x1BD9;


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
int l_74874103 = 0x83E0BAC9;
for ( l_45774920 = 0; l_45774920 < 100; ++l_45774920 )
{
l_45774920 = func_46266394(  );
DEPTH--;
return g_72873263;
}
DEPTH--;
return l_74874103;
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
DumbHash( g_72873263, 2 );
printf( "%d\n", context );
return 0;
}


