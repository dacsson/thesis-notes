/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 7463263293931520
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
int func_17019726(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_17019726(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned short l_51858112 = 0x0DD2;
if ( 0x04 )
{
short l_13825395 = 0xCCF8;
l_13825395 = l_13825395;
func_17019726(  );
}
else
for ( l_51858112 = 0; l_51858112 < 100; ++l_51858112 )
{
unsigned short l_15111595 = 0x8F07;
for ( l_51858112 = 0; l_51858112 < 100; ++l_51858112 )
{
short l_69501201 = 0x9BF4;
l_69501201 = l_15111595;
for ( l_51858112 = 0; l_51858112 < 100; ++l_51858112 )
{
l_69501201 = 0x06ED;
l_69501201 = 0x642DD1DA;
}
}
}
DEPTH--;
return l_51858112;
DEPTH--;
}
else
return 0x5768E195;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_17019726(  );
printf( "%d\n", context );
return 0;
}


