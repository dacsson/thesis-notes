/*
// --- RANDOMLY GENERATED PROGRAM ---
// Program Generator by Bryan Turner (bryan.turner@pobox.com)
//
// Seed: 7288343060480
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
long g_77532096 = 0x9314158E;


/* --- FORWARD DECLARATIONS --- */
int func_84504871(  );


/* --- FUNCTIONS --- */
/* ------------------------------------------ */
int func_84504871(  )
{
if (DEPTH < MAX_DEPTH) 
{
DEPTH++;
unsigned short l_44186894 = 0x09C1;
DEPTH--;
return g_77532096;
DEPTH--;
return l_44186894;
DEPTH--;
}
else
return 0x6C74BF0C;
}




/* ---------------------------------------- */
int main( int argc, void *argv[] )
{
   /* Call the first function */
   func_84504871(  );
DumbHash( g_77532096, 4 );
printf( "%d\n", context );
return 0;
}


