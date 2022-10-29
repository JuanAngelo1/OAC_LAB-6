import numpy as np
import ctypes
import time

def inner_prod(u,v,N):
    dp = 0
    for i in range(N):
        dp +=u[i]*v[i]
    return dp
if __name__ == '__main__':
    
    N = 2048*2048*8
    u = np.arange(N, dtype=np.float32)
    v = np.arange(N, dtype=np.float32)
    # print(u)
    # print(v)
    lib = ctypes.CDLL('./simd_producto.so')
    
    lib.dot_product.argtypes = [np.ctypeslib.ndpointer(dtype=np.float32),np.ctypeslib.ndpointer(dtype=np.float32), ctypes.c_int]
    lib.dot_product_asm.argtypes = [np.ctypeslib.ndpointer(dtype=np.float32),np.ctypeslib.ndpointer(dtype=np.float32), ctypes.c_int]
    lib.dot_simd.argtypes = [np.ctypeslib.ndpointer(dtype=np.float32),np.ctypeslib.ndpointer(dtype=np.float32), ctypes.c_int]
    
    lib.dot_product.restype = ctypes.c_float
    lib.dot_product_asm.restype = ctypes.c_float
    lib.dot_simd.restype = ctypes.c_float
    

    tic0 = time.time()
    i = inner_prod(u,v,N)
    toc0 = time.time()

    # tic1 = time.time()
    # i = np.inner(u,v)
    # toc1 = time.time()

    # tic2 = time.time()
    # f = lib.cinnerprod(u,v,N)
    # toc2 = time.time()

    tic3 = time.time()
    f1 = lib.dot_product_asm(u,v,N)
    toc3 = time.time()

    tic4 = time.time()
    f2 = (lib.dot_simd(u,v,N))
    toc4 = time.time()

    print(toc0-tic0)
    # print(toc1-tic1)
    # print(toc2-tic2)
    print(toc3-tic3)
    print(toc4-tic4)