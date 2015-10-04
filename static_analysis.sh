#!/bin/bash -e

CURR_DIR="${PWD}"
BUILD_DIR="analyze-build"
cd "$(dirname "$(realpath "$0")")";

set +e
rm -rf "${BUILD_DIR}"
set -e
mkdir "${BUILD_DIR}"
cd "${BUILD_DIR}"

scan-build cmake .. -DCMAKE_PREFIX_PATH=/opt/Qt/5.5/gcc_64/ -DCMAKE_BUILD_TYPE=Debug
scan-build -maxloop 8 -enable-checker alpha.core.BoolAssignment -enable-checker alpha.core.CallAndMessageUnInitRefArg -enable-checker alpha.core.CastSize -enable-checker alpha.core.CastToStruct -enable-checker alpha.core.FixedAddr -enable-checker alpha.core.IdenticalExpr -enable-checker alpha.core.PointerArithm -enable-checker alpha.core.PointerSub -enable-checker alpha.core.SizeofPtr -enable-checker alpha.core.TestAfterDivZero -enable-checker alpha.cplusplus.VirtualCall -enable-checker alpha.deadcode.UnreachableCode -enable-checker alpha.osx.cocoa.DirectIvarAssignment -enable-checker alpha.security.ArrayBoundV2 -enable-checker alpha.security.MallocOverflow -enable-checker alpha.security.ReturnPtrRange -enable-checker alpha.security.taint.TaintPropagation -enable-checker alpha.unix.Chroot -enable-checker alpha.unix.MallocWithAnnotations -enable-checker alpha.unix.PthreadLock -enable-checker alpha.unix.SimpleStream -enable-checker alpha.unix.Stream -enable-checker alpha.unix.cstring.BufferOverlap -enable-checker alpha.unix.cstring.NotNullTerminated -enable-checker alpha.unix.cstring.OutOfBounds -enable-checker llvm.Conventions -enable-checker security.FloatLoopCounter -enable-checker security.insecureAPI.rand -enable-checker security.insecureAPI.strcpy -o output make -j8
scan-view ./output/*

cd "${CURR_DIR}" 
