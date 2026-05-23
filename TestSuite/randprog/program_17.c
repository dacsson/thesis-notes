/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 955297701623234560
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
unsigned long g_82790190 = 0xC197EB61;
short g_70986830 = 0xB03C;


/* --- FORWARD DECLARATIONS --- */
int func_67318838(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_67318838(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
g_82790190 = func_67318838(  );
DEPTH--;
return g_70986830;
DEPTH--;
}
else
return 0x83F027F1;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_67318838(  );
DumbHash( g_82790190, 4 );
DumbHash( g_70986830, 2 );
printf( "%d\n", context );
return 0;
}


