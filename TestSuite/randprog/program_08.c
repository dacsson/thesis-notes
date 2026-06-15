/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 7288343056384
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
long g_60609648 = 0xFA1B9C9D;


/* --- FORWARD DECLARATIONS --- */
int func_40160419(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_40160419(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
DEPTH--;
return 0x5153AE3E;
DEPTH--;
return g_60609648;
DEPTH--;
}
else
return 0x04A36BC6;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_40160419(  );
DumbHash( g_60609648, 4 );
printf( "%d\n", context );
return 0;
}


