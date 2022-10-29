#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

void initVector(int *v, int N);
void alg_C(int *v,int N,int i_min,int i_max,float im_max);
extern void alg_asm(int *v,int N,int i_min,int i_max,float im_max);
extern void alg_simd(float *v,int N,int i_min,int i_max,float im_max);

int main(){

    int *v,*v2;
    float *v3;
    int N=16;
    int i_min=4;
    int i_max=10;
    float im_max=15;
    
    srand(time(NULL));

    v=malloc(N*sizeof(int));
    v2=malloc(N*sizeof(int));
    v3=malloc(N*sizeof(float));
    initVector(v,N);

    for(int i=0;i<16;i++){
        v2[i]=v[i];
        v3[i]=(float)v[i];
    }
    
    /*printf("Matriz de Entrada \n");

    for(int i=0;i<16;i++){
        if(i%4==0 && i!=0)
            printf("\n");

        printf("%2lf ",v3[i]);
    }
    printf("\n\n");
    */

    alg_C(v,N,i_min,i_max,im_max);

    printf("Matriz de Salida C\n");

    for(int i=0;i<16;i++){
        if(i%4==0 && i!=0)
            printf("\n");

        printf("%2d ",v[i]);
    }
    printf("\n\n");
    
    alg_asm(v2,N,i_min,i_max,im_max);

    printf("Matriz de Salida ASM\n");

    for(int i=0;i<16;i++){
        if(i%4==0 && i!=0)
            printf("\n");

        printf("%2d ",v2[i]);
    }
    printf("\n\n");

    alg_simd(v3,N,i_min,i_max,im_max);

    printf("Matriz de Salida SIMD \n");

    for(int i=0;i<16;i++){
        if(i%4==0 && i!=0)
            printf("\n");

        int a=(int)v2[i];
        printf("%2d ",a);
    }
    printf("\n\n");
    
    return 0;
}

void alg_C(int *v,int N,int i_min,int i_max,float im_max){

    for(int i=0;i<N;i++){
        v[i]=round(v[i]* (i_max-i_min)/im_max) + i_min;
    }
}

void initVector(int *v, int N)
{
    for (int i = 0; i < N; i++)
    {
        int e = rand() % 16;
        v[i] = e;
    }
}