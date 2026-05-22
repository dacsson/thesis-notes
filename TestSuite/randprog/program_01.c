/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 3558761258
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
int func_01930654(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_01930654(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned short l_37875689 = 0xB4EC;
l_37875689 = func_01930654(  );
DEPTH--;
return l_37875689;
DEPTH--;
}
else
return 0x9C856814;
}




/* ---------------------------------------- */
int main( int argc, char *argv[] )
{
   /* Call the first function */
   func_01930654(  );
printf( "%d\n", context );
return 0;
}


