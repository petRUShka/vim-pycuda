# SYNOPSIS:
Vim highlighting for [PyCuda] (http://mathema.tician.de/software/pycuda/)
-----------------------------
Originally forked from vim-pyopencl.

# Installation

I recommend to use [Vim-Plug] (https://github.com/junegunn/vim-plug) to organize Vim plugins. In this case you should add following line:

    Plug 'petRUShka/vim-pycuda'

Then do

    :set filetype=pycuda

and use

    """//CUDA// ...code..."""

for OpenCL code included in your Python file.

For example

    mod = SourceModule("""
    __global__ void multiply_them(float *dest, float *a, float *b)
    {
      const int i = threadIdx.x;
      dest[i] = a[i] * b[i];
    }
    """)

will not be highlighted. But

    mod = SourceModule("""//CUDA//
    __global__ void multiply_them(float *dest, float *a, float *b)
    {
      const int i = threadIdx.x;
      dest[i] = a[i] * b[i];
    }
    """)

will be highlighted.


You may also include a line

    # vim: filetype=pycuda.python

at the end of your file to set the file type automatically or change its extension to `.pycuda`
