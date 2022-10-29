#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

void arg_min_max(float *v1,int *arr,int N);
extern void arg_min_max_asm(float *v1,int *arr,int N);
void initVector(float *v, int N);

int main(){

    float *v1;
    int N=8;
    srand(time(NULL));
    v1 = malloc(N * sizeof(float));
    initVector(v1,N);
    int *arr;
    int *arr_2;

    arr=malloc(2 *sizeof(int));
    arr_2=malloc(2 *sizeof(int));

    //for(int i=0;i<2;i++){
    //    printf("%d   ", arr[i]);
    // }
    //printf("\n");

    arg_min_max_asm(v1,arr_2,N);

    printf("Con ASM \n");
    printf("El valor minimo del arreglo es : %d \n",arr_2[0]);
    printf("El valor max del arreglo es    : %d \n",arr_2[1]);
    
    arg_min_max(v1,arr,N);

    printf("Con C \n");
    printf("El valor minimo del arreglo es : %d \n",arr[0]);
    printf("El valor max del arreglo es    : %d \n",arr[1]);


    return 0;
}

void arg_min_max(float *v1,int *arr,int N){

    float maximo=0;
    float minimo=100;
    int posi_min;
    int posi_max;
    for (int i = 0; i < N; i++)
    {
        if(v1[i]>maximo){
            maximo=v1[i];
            posi_max=i;
        }
        if(v1[i]<minimo){
            minimo=v1[i];
            posi_min=i;
        }
    }
    arr[0]=posi_min;
    arr[1]=posi_max;

}

void initVector(float *v, int N)
{
    for (int i = 0; i < N; i++)
    {
        float e = rand() % 10;
        v[i] = (sinf(e) + cosf(e));
    }
}