/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 56940180160
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
unsigned int g_96793091 = 0xFD65FC92;
unsigned int g_43062028 = 0xF2270568;


/* --- FORWARD DECLARATIONS --- */
int func_34043943(  );
int func_07488648( unsigned short p_66311272, unsigned int p_19010343 );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_34043943(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
long l_26520187 = 0xEE7D5265;
if ( 0xA37A7D48 )
{
unsigned int l_05389877 = 0xC9AF020B;
g_96793091 = l_05389877;
func_34043943(  );
}
else
for ( l_26520187 = 0; l_26520187 < 100; ++l_26520187 )
{
int l_33875906 = 0xA03B85E7;
func_07488648( func_07488648( l_33875906, l_26520187 ), 0xFF70078F );
}
DEPTH--;
return 0xB9;
DEPTH--;
}
else
return 0x12646163;
}


/* ------------------------------------------ */
int func_07488648( unsigned short p_66311272, unsigned int p_19010343 )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
DEPTH--;
return g_43062028;
DEPTH--;
return p_66311272;
DEPTH--;
}
else
return 0x94252320;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_34043943(  );
DumbHash( g_96793091, 4 );
DumbHash( g_43062028, 4 );
printf( "%d\n", context );
return 0;
}


