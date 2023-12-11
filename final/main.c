#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"



/*************************************************************
 *  <<Julia set相關資料>>
 *  https://en.wikipedia.org/wiki/Julia_set
 *
 *  cX 為 Julia set數學式中複數 "c" 的實部
 *  cY 為 Julia set數學式中複數 "c" 的虛部
 *  調整cX(值域:-1.0~1.0)與cY(值域:0.0~1.0)可得到不同的圖形
 *

*************************************************************/


int main()
{
	//RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;

    char* team ;
    char* name1 ;
    char* name2 ;
    char* name3 ;

	printf( "Function1: Name\n" );
	NAME(&team, &name1, &name2, &name3);
    printf( "%s", name1);

    int id1,id2,id3,total;
	printf( "Function2: ID\n" );
	ID(&id1,&id2,&id3,&total);


	//Dummy printout. Please refer to the specification of Project 1.
	printf( "Main Function:\n" );
	printf( "*****Print All*****\n" );
    printf( "%d %s", id1, name1);
    printf( "%d %s", id2, name2 );
    printf( "%d %s", id3, name3 );
    printf( "ID Summation = %d", total);
	printf( "\n*****End Print*****\n" );

	printf( "\n***** Please enter p to draw Julia Set animation *****\n" );

	while(getchar()!='p') ;


    system( "clear" );


	fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

	if( fd<0 )
	{	printf( "Frame Buffer Device Open Error!!\n" );}
	else
	{
		for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {
			drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );
			write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );
			lseek( fd, 0, SEEK_SET );
		}


		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
		printf( "%s\n", team);
		printf( "%d %s", id1, name1);
        printf( "%d %s", id2, name2 );
        printf( "%d %s", id3, name3 );


		close( fd );
	}

	while(getchar()!='p') ;

	return 0;
}
