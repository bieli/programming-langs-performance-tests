from setuptools import setup
from Cython.Build import cythonize

setup(
    ext_modules=cythonize("linear_search_perf.pyx", compiler_directives={"language_level": "3"})
)

