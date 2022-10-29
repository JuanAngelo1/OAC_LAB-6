#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void initVector(float *v, int N);
float dot_product(float *v1, float *v2,int N);
extern float dot_product_asm(float *v1, float *v2,int N);
extern float dot_simd(float *v1,float *v2,int N);

int main(){
	struct timespec ti, tf;
    double elapsed1,elapsed2,elapsed3;

    float *v1,*v2;
    int N=2048;
    srand(time(NULL));
    v1 = malloc(N * sizeof(float));
    v2 = malloc(N * sizeof(float));

    initVector(v1,N);
    initVector(v2,N);

// C
    clock_gettime(CLOCK_REALTIME, &ti);

    float result=dot_product(v1,v2,N);

    clock_gettime(CLOCK_REALTIME, &tf);
    elapsed1 =  (tf.tv_nsec - ti.tv_nsec);

// ASM
    clock_gettime(CLOCK_REALTIME, &ti);
    float result_2=dot_product_asm(v1,v2,N);
    clock_gettime(CLOCK_REALTIME, &tf);
    elapsed2 =  (tf.tv_nsec - ti.tv_nsec);

// ASM SIMD
    clock_gettime(CLOCK_REALTIME, &ti);
    float result_3=dot_simd(v1,v2,N);
    clock_gettime(CLOCK_REALTIME, &tf);
    elapsed3 =  (tf.tv_nsec - ti.tv_nsec);


    //for(int i=0;i<N;i++){
    //    printf("%.2lf   %.2lf \n", v1[i],v2[i]);
   // }
    printf("%.2lf  %.15f \n",result,elapsed1*1e-9);    
    printf("%.2lf  %.15f \n",result_2,elapsed2*1e-9);
    printf("%.2lf  %.15f \n",result_3,elapsed3*1e-9);


    return 0;
}


void initVector(float *v, int N)
{
    for (int i = 0; i < N; i++)
    {
        float e = rand() % 10;
        v[i] = (sinf(e) + cosf(e));
    }
}

//function to calculate dot product of two vectors
float dot_product(float *v1, float *v2,int N) {
   float product = 0;
   for (int i = 0; i < N; i++)
   product = product + v1[i] * v2[i];
   return product;
}