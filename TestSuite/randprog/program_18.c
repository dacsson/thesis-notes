/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 28470090080
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


/* --- FORWARD DECLARATIONS --- */
int func_28348071(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_28348071(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
int l_35811603 = 0xFB13637A;
l_35811603 = func_28348071(  );
DEPTH--;
return l_35811603;
DEPTH--;
}
else
return 0xD3AF25F4;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_28348071(  );
printf( "%d\n", context );
return 0;
}


