/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 3558761260
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
unsigned short g_96451209 = 0xB30D;


/* --- FORWARD DECLARATIONS --- */
int func_60580835(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_60580835(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned long l_96892077 = 0xD2CC5225;
unsigned long l_82292977 = 0xAD315E46;
l_96892077 = l_82292977;
for ( l_82292977 = 0; l_82292977 < 100; ++l_82292977 )
{
long l_06503636 = 0x79691571;
if ( ( g_96451209 && g_96451209 ) )
{
g_96451209 = l_96892077;
}
else
for ( l_82292977 = 0; l_82292977 < 100; ++l_82292977 )
{
long l_24091852 = 0xDDB959BA;
l_24091852 = l_82292977;
}
l_06503636 = l_06503636;
}
DEPTH--;
return 0xF34FDD68;
DEPTH--;
}
else
return 0x5ED727C1;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_60580835(  );
DumbHash( g_96451209, 2 );
printf( "%d\n", context );
return 0;
}


