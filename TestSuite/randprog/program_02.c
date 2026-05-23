/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 1822085764096
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
long g_55950399 = 0x2A4F02FA;


/* --- FORWARD DECLARATIONS --- */
int func_28720446(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_28720446(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
long l_27625065 = 0x35DC12BF;
func_28720446(  );
if ( g_55950399 )
{
DEPTH--;
return l_27625065;
}
else
l_27625065 = l_27625065;
DEPTH--;
return g_55950399;
DEPTH--;
}
else
return 0x537FB40D;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_28720446(  );
DumbHash( g_55950399, 4 );
printf( "%d\n", context );
return 0;
}


