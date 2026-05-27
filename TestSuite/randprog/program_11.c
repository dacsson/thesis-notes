/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 14235045040
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
int func_93655295(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_93655295(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
int l_59769113 = 0xDFA2C78A;
unsigned char l_55456020 = 0x72;
l_59769113 = l_59769113;
DEPTH--;
return l_55456020;
DEPTH--;
}
else
return 0xBD67A9D9;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_93655295(  );
printf( "%d\n", context );
return 0;
}


