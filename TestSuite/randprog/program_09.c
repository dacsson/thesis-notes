/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 12122782361054085120
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
short g_45717017 = 0x1BD9;


/* --- FORWARD DECLARATIONS --- */
int func_46266334(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_46266334(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
short l_71541961 = 0x1515;
for ( g_45717017 = 0; g_45717017 < 100; ++g_45717017 )
{
unsigned char l_00588191 = 0x83;
for ( l_00588191 = 0; l_00588191 < 100; ++l_00588191 )
{
for ( g_45717017 = 0; g_45717017 < 100; ++g_45717017 )
{
g_45717017 = l_71541961;
}
}
}
DEPTH--;
return l_71541961;
DEPTH--;
}
else
return 0xE0BAC926;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_46266334(  );
DumbHash( g_45717017, 2 );
printf( "%d\n", context );
return 0;
}


