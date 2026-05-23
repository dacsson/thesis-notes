/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 14576686112768
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
long g_80416230 = 0x9CCA1428;


/* --- FORWARD DECLARATIONS --- */
int func_97091928(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_97091928(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
DEPTH--;
return g_80416230;
func_97091928(  );
DEPTH--;
return g_80416230;
DEPTH--;
}
else
return 0xAFAE3790;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_97091928(  );
DumbHash( g_80416230, 4 );
printf( "%d\n", context );
return 0;
}


