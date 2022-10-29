import ctypes
import statistics
import time
import numpy as np
import matplotlib.pyplot as plt

if __name__ == '__main__':
    
    lib = ctypes.CDLL('./lib.so')
    lib.arg_min_max.argtypes = [ np.ctypeslib.ndpointer(dtype = np.float32),np.ctypeslib.ndpointer(dtype = np.int8), ctypes.c_int]
    lib.arg_min_max_asm.argtypes = [ np.ctypeslib.ndpointer(dtype = np.float32),np.ctypeslib.ndpointer(dtype = np.int8), ctypes.c_int]
    lista_num = [256,512,1024,2048,4096]
    iteraciones = 12
    
    lista_1 = []
    lista_2 = []
    
    for n in lista_num:
        input_array = np.random.uniform(0, 10, n).astype(np.float32)
        output_array = np.zeros((2,1),dtype=np.int8)
        
        lista_C = []
        lista_ASM = []
        for it in range(iteraciones):
            tic1 = time.time()
            lib.arg_min_max(input_array,output_array,n)
            toc1 = time.time()
            lista_C.append(1e6*(toc1-tic1))

            tic2 = time.time()
            lib.arg_min_max_asm(input_array,output_array,n)
            toc2 = time.time()
            lista_ASM.append(1e6*(toc2-tic2))

        lista_1.append(statistics.median(lista_C))
        lista_2.append(statistics.median(lista_ASM))    
    
plt.plot(lista_num,lista_1,'r-')
plt.plot(lista_num,lista_2,'b-')
plt.xlabel("Size")
plt.ylabel ("Tiempo [us]")
plt.grid
plt.savefig("suma.png",dpi = 300)
plt.close()

