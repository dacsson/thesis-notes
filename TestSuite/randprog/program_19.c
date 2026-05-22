/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 227760720640
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
long g_53698936 = 0x792DF27E;


/* --- FORWARD DECLARATIONS --- */
int func_74021349(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_74021349(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
long l_90652019 = 0x823ED8C6;
unsigned long l_60814311 = 0x04C837A1;
l_90652019 = l_60814311;
for ( g_53698936 = 0; g_53698936 < 100; ++g_53698936 )
{
func_74021349(  );
}
DEPTH--;
return l_60814311;
DEPTH--;
}
else
return 0xC29350B1;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_74021349(  );
DumbHash( g_53698936, 4 );
printf( "%d\n", context );
return 0;
}


