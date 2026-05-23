/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 28470090064
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
int func_86100837(  );
int func_78116309( short p_61188052 );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_86100837(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned int l_72914734 = 0x098BFDF0;
if ( l_72914734 )
{
int l_89776331 = 0x72853432;
DEPTH--;
return l_89776331;
}
else
func_78116309( l_72914734 );
l_72914734 = func_78116309( 0x2F49 );
if ( func_78116309( func_86100837(  ) ) )
{
short l_32103310 = 0x31CB;
l_32103310 = ( l_72914734 || 0x04F1 );
}
else
for ( l_72914734 = 0; l_72914734 < 100; ++l_72914734 )
{
func_78116309( l_72914734 );
}
if ( l_72914734 )
{
int l_49260080 = 0x1C65045A;
l_49260080 = l_72914734;
}
else
func_86100837(  );
DEPTH--;
return l_72914734;
DEPTH--;
}
else
return 0xFF9DF790;
}


/* ------------------------------------------ */
int func_78116309( short p_61188052 )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
int l_03443903 = 0x8BE9743B;
int l_96145109 = 0xA47A47B5;
func_78116309( l_03443903 );
DEPTH--;
return l_96145109;
DEPTH--;
}
else
return 0x690B0B14;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_86100837(  );
printf( "%d\n", context );
return 0;
}


