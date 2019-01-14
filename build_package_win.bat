set CMAKE_PATH="C:\Program Files\CMake\bin\cmake.exe"
set COMPILER_PATH=C:\Qt\Tools\mingw530_32\bin

set PATH=%COMPILER_PATH%;%PATH%
%CMAKE_PATH% --build . --target package 