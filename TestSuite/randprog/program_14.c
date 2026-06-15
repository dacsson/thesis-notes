/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 116613488967680
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
int g_86582546 = 0x7224FA6C;


/* --- FORWARD DECLARATIONS --- */
int func_11011768(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_11011768(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
g_86582546 = g_86582546;
DEPTH--;
return g_86582546;
DEPTH--;
}
else
return 0xEBEA7A4D;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_11011768(  );
DumbHash( g_86582546, 4 );
printf( "%d\n", context );
return 0;
}


