/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 15284763217381818368
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
short g_45717017 = 0x7499;


/* --- FORWARD DECLARATIONS --- */
int func_46266334(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_46266334(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned long l_41631993 = 0x688BCCB4;
for ( g_45717017 = 0; g_45717017 < 100; ++g_45717017 )
{
unsigned char l_00588157 = 0x3D;
for ( l_00588157 = 0; l_00588157 < 100; ++l_00588157 )
{
if ( 0x1B03 )
{
int l_27488424 = 0xFB0DFE06;
DEPTH--;
return 0xF027F1A5;
l_41631993 = g_45717017;
DEPTH--;
return l_27488424;
}
else
DEPTH--;
return l_00588157;
g_45717017 = l_00588157;
func_46266334(  );
}
}
DEPTH--;
return l_41631993;
DEPTH--;
}
else
return 0x91B3599F;
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


