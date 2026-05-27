/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 955297701086363648
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
short g_17029599 = 0x61B0;


/* --- FORWARD DECLARATIONS --- */
int func_08306222(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_08306222(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
char l_96001823 = 0x3C;
g_17029599 = l_96001823;
DEPTH--;
return l_96001823;
DEPTH--;
}
else
return 0x83F027F1;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_08306222(  );
DumbHash( g_17029599, 2 );
printf( "%d\n", context );
return 0;
}


