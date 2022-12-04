[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-BLAS/workflows/test/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-BLAS/actions)

[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS)

NAME
====

Math::Libgsl::BLAS - An interface to libgsl, the Gnu Scientific Library - BLAS (Basic Linear Algebra Subprograms).

SYNOPSIS
========

```raku
use Math::Libgsl::Raw::BLAS :ALL;

use Math::Libgsl::BLAS;
use Math::Libgsl::BLAS::Num32;
use Math::Libgsl::BLAS::Complex32;
use Math::Libgsl::BLAS::Complex64;
```

DESCRIPTION
===========

Math::Libgsl::BLAS is an interface to the BLAS functions of the libgsl, the Gnu Scientific Library

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

Throughout this package I used a naming convention corresponding to that of the C library, stripping the initial `gsl_blas_`.

The functions are divided in three levels:

  * Level 1: vector operations

  * Level 2: matrix-vector operations

  * Level 3: matrix-matrix operations

The names of the functions specify the kind of operation, the matrix type, and the underlying data type. For more information please read the [C Library Documentation](C Library Documentation).

Since the original C library provided functions for four data types, so does this module. The Math::Libgsl::BLAS module provides functions that work on the default data type: num64. The functions working on num32 vector and matrices are in the Math::Libgsl::BLAS::Num32 module; those working on complex64 and complex32 are respectively in the Math::Libgsl::BLAS::Complex64 and Math::Libgsl::BLAS::Complex32 modules.

So for example this code will be executed using num32 data type variables:

```raku
use Math::Libgsl::Vector::Num32;
use Math::Libgsl::BLAS::Num32;

my $x = Math::Libgsl::Vector::Num32.new: 10;
$x.setall(.1);
my $y = Math::Libgsl::Vector::Num32.new: 10;
$y.setall(.2);
say sdsdot(.3, $x, $y); # output: 0.5
```

Here I'm following the order the functions are listed in the C Library Manual.

Level 1
-------

### sdsdot(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)

This function computes the sum α + T(x)y, where T(x) is the transpose of x.

### sdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)

### dsdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)

### ddot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Num)

### cdotu(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex)

### zdotu(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex)

These functions compute the scalar product T(x)y.

### cdotc(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex)

### zdotc(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex)

These functions compute the complex conjugate scalar product H(x)y.

### snrm2(Math::Libgsl::Vector::Num32 $x --> Num)

### dnrm2(Math::Libgsl::Vector $x --> Num)

### scnrm2(Math::Libgsl::Vector::Complex32 $x --> Num)

### dznrm2(Math::Libgsl::Vector::Complex64 $x --> Num)

These functions compute the Euclidean norm ||x||₂.

### sasum(Math::Libgsl::Vector::Num32 $x --> Num)

### dasum(Math::Libgsl::Vector $x --> Num)

### scasum(Math::Libgsl::Vector::Complex32 $x --> Num)

### dzasum(Math::Libgsl::Vector::Complex64 $x --> Num)

These functions compute the absolute sum Σ|xᵢ| of the elements of the vector x (or the sum of the magnitudes of the real and imaginary parts).

### isamax(Math::Libgsl::Vector::Num32 $x --> Int)

### idamax(Math::Libgsl::Vector $x --> Int)

### icamax(Math::Libgsl::Vector::Complex32 $x --> Int)

### izamax(Math::Libgsl::Vector::Complex64 $x --> Int)

These functions return the index of the largest element of the vector x. The largest element is determined by its absolute magnitude for real vectors and by the sum of the magnitudes of the real and imaginary parts Σ|R(xᵢ)| + |I(xᵢ)| for complex vectors. If the largest value occurs several times then the index of the first occurrence is returned.

### sswap(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)

### dswap(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)

### cswap(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)

### zswap(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions exchange the elements of the vectors. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### scopy(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)

### dcopy(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)

### ccopy(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)

### zcopy(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions copy the elements of the vector x into the vector y. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### saxpy(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)

### daxpy(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)

### caxpy(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)

### zaxpy(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions compute the sum y = αx + y. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### sscal(Num() $α, Math::Libgsl::Vector::Num32 $x)

### dscal(Num() $α, Math::Libgsl::Vector $x)

### cscal(Complex $α, Math::Libgsl::Vector::Complex32 $x)

### zscal(Complex $α, Math::Libgsl::Vector::Complex64 $x)

### csscal(Num() $α, Math::Libgsl::Vector::Complex32 $x)

### zdscal(Num() $α, Math::Libgsl::Vector::Complex64 $x)

These functions rescale the vector x by α.

### srotg(Num() $a, Num() $b --> List)

### drotg(Num() $a, Num() $b --> List)

These functions compute a Givens rotation which zeroes the vector (a, b). They return the magnitude of the resulting vector and the coefficients (c, s) which zero the vector (a, b). In case of error a failure object is returned.

### srot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int)

### drot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int)

These functions apply a Givens rotation (x ′ , y ′ ) = (cx + sy, −sx + cy) to the vectors x, y. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### srotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List)

### drotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List)

These functions compute a modified Givens transformation. They return a list of five elements (see the BLAS manual for an explanation). In case of error a failure object is returned.

### srotm(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int)

### drotm(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int)

These functions apply a modified Givens transformation. These functions return GSL_SUCCESS if successful, or one of the error codes (see the gsl-error enum in Math::Libgsl::Constants).

Level 2
-------

### sgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y --> Int)

### dgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y --> Int)

### cgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int)

### zgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int)

These functions compute the matrix-vector product and sum y = αop(A)x + βy. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### strmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int)

### dtrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int)

### ctrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int)

### ztrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int)

These functions compute the matrix-vector product x = op(A)x for the triangular matrix A. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used. If Diag is CblasNonUnit then the diagonal of the matrix is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see the cblas-uplo and cblas-diag enums in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### strsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int)

### dtrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int)

### ctrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int)

### ztrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int)

These functions compute inv(op(A))x for x. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used. If Diag is CblasNonUnit then the diagonal of the matrix is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see the cblas-uplo and cblas-diag enums in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y --> Int)

### dsymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y --> Int)

These functions compute the matrix-vector product and sum y = αAx + βy for the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### chemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int)

### zhemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int)

These functions compute the matrix-vector product and sum y = αAx + βy for the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically assumed to be zero and are not referenced. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### sger(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A --> Int)

### dger(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A --> Int)

### cgeru(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)

### zgeru(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the rank-1 update A = αxy T + A of the matrix A. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### cgerc(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)

### zgerc(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the conjugate rank-1 update A = αxH(y) + A of the matrix A. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssyr(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Matrix::Num32 $A --> Int)

### dsyr(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Matrix $A --> Int)

These functions compute the symmetric rank-1 update A = αxT(x) + A of the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### cher(Int $Uplo, num32 $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Matrix::Complex32 $A --> Int)

### zher(Int $Uplo, num64 $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the hermitian rank-1 update A = αxx H + A of the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A --> Int)

### dsyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A --> Int)

These functions compute the symmetric rank-2 update A = αxT(y) + αyT(x) + A of the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### cher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)

### zher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the hermitian rank-2 update A = αxH(y) + α * yH(x) + A of the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

Level 3
-------

### sgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)

### dgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)

### cgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αop(A)op(B) + βC where op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans and similarly for the parameter TransB (see the cblas-transpose enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)

### dsymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)

### csymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zsymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αAB + βC for Side is CblasLeft and C = αBA + βC for Side is CblasRight, where the matrix A is symmetric (see the cblas-side enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### chemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zhemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αAB + βC for Side is CblasLeft and C = αBA + βC for Side is CblasRight, where the matrix A is hermitian (see the cblas-side enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### strmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int)

### dtrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int)

### ctrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int)

### ztrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int)

These functions compute the matrix-matrix product B = αop(A)B for Side is CblasLeft and B = αBop(A) for Side is CblasRight (see the cblas-side enum in Math::Libgsl::Constants). The matrix A is triangular and op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used (see the cblas-uplo enum in Math::Libgsl::Constants). If Diag is CblasNonUnit then the diagonal of A is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see cblas-diag enums in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### strsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int)

### dtrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int)

### ctrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int)

### ztrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int)

These functions compute the inverse-matrix matrix product B = αop(inv(A))B for Side is CblasLeft and B = αBop(inv(A)) for Side is CblasRight (see the cblas-side enum in Math::Libgsl::Constants). The matrix A is triangular and op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used (see the cblas-uplo enum in Math::Libgsl::Constants). If Diag is CblasNonUnit then the diagonal of A is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see cblas-diag enums in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)

### dsyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Num() $β, Math::Libgsl::Matrix $C --> Int)

### csyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zsyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-k update of the symmetric matrix C, C = αAT(A) + βC when Trans is CblasNoTrans and C = αT(A)A + βC when Trans is CblasTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### cherk(Int $Uplo, Int $TransA, num32 $α, Math::Libgsl::Matrix::Complex32 $A, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zherk(Int $Uplo, Int $TransA, num64 $α, Math::Libgsl::Matrix::Complex64 $A, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-k update of the hermitian matrix C, C = αAH(A) + βC when Trans is CblasNoTrans and C = αH(A)A + βC when Trans is CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### ssyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)

### dsyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)

### csyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zsyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-2k update of the symmetric matrix C, C = αAT(B) + αBT(A) + βC when Trans is CblasNoTrans and C = αT(A)B + αT(B)A + βC when Trans is CblasTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants). These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

### cher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int)

### zher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-2k update of the hermitian matrix C, C = αAH(B) + conj(α)BH(A) + βC when Trans is CblasNoTrans and C = αH(A)B + conj(α)H(B)A + βC when Trans is CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero. These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/).

The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

The BLAS C Library manual is available here [https://software.intel.com/en-us/mkl-developer-reference-c-blas-routines](https://software.intel.com/en-us/mkl-developer-reference-c-blas-routines) and here [http://netlib.org/blas/#_level_1](http://netlib.org/blas/#_level_1).

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux
------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04 and Ubuntu 20.04+
------------------------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::BLAS

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

