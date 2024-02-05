use v6.c;

unit class Math::Libgsl::BLAS:ver<0.0.5>:auth<zef:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::BLAS :ALL;
use Math::Libgsl::Vector;
use Math::Libgsl::Matrix;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;

# Level 1
sub ddot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Num) is export {
  my num64 $res = 0e0;
  my $ret = gsl_blas_ddot($x.vector, $y.vector, $res);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  $res
}

sub dnrm2(Math::Libgsl::Vector $x --> Num) is export {
  gsl_blas_dnrm2($x.vector)
}

sub dasum(Math::Libgsl::Vector $x --> Num) is export {
  gsl_blas_dasum($x.vector)
}

sub idamax(Math::Libgsl::Vector $x --> Int) is export {
  gsl_blas_idamax($x.vector)
}

sub dswap(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_dswap($x.vector, $y.vector)
}

sub dcopy(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_dcopy($x.vector, $y.vector)
}

sub daxpy(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  my num64 $alpha = $α;
  my $ret = gsl_blas_daxpy($alpha, $x.vector, $y.vector)
}

sub dscal(Num() $α, Math::Libgsl::Vector $x) is export {
  my num64 $alpha = $α;
  gsl_blas_dscal($alpha, $x.vector)
}

sub drotg(Num() $a, Num() $b --> List) is export {
  my num64 $ma = $a;
  my num64 $mb = $b;
  my num64 ($mc, $ms);
  my $ret = gsl_blas_drotg($ma, $mb, $mc, $ms);
  fail X::Libgsl.new: errno => $ret, error => "Can't apply Givens rotation" if $ret ≠ GSL_SUCCESS;
  $ma, $mc, $ms
}

sub drot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int) is export {
  my num64 $mc = $c;
  my num64 $ms = $s;
  gsl_blas_drot($x.vector, $y.vector, $mc, $ms);
}

sub drotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List) is export {
  my num64 $md1 = $d1;
  my num64 $md2 = $d2;
  my num64 $mb1 = $b1;
  my num64 $mb2 = $b2;
  my $P = CArray[num64].allocate(5);
  my $ret = gsl_blas_drotmg($md1, $md2, $mb1, $mb2, $P);
  fail X::Libgsl.new: errno => $ret, error => "Can't apply modified Givens rotation" if $ret ≠ GSL_SUCCESS;
  $P.list
}

sub drotm(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int) is export {
  my CArray[num64] $P .= new: @param».Num;
  gsl_blas_drotm($x.vector, $y.vector, $P)
}

# Level 2
sub dgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y --> Int) is export {
  gsl_blas_dgemv($TransA, $α, $A.matrix, $x.vector, $β, $y.vector)
}

sub dtrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int) is export {
  gsl_blas_dtrmv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub dtrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int) is export {
  gsl_blas_dtrsv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub dsymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y  --> Int) is export {
  gsl_blas_dsymv($Uplo, $α, $A.matrix, $x.vector, $β, $y.vector)
}

sub dger(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A  --> Int) is export {
  gsl_blas_dger($α, $x.vector, $y.vector, $A.matrix)
}

sub dsyr(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Matrix $A  --> Int) is export {
  gsl_blas_dsyr($Uplo, $α, $x.vector, $A.matrix)
}

sub dsyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A  --> Int) is export {
  gsl_blas_dsyr2($Uplo, $α, $x.vector, $y.vector, $A.matrix)
}

# Level 3
sub dgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int) is export {
  gsl_blas_dgemm($TransA, $TransB, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}

sub dsymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int) is export {
  gsl_blas_dsymm($Side, $Uplo, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}

sub dtrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int) is export {
  gsl_blas_dtrmm($Side, $Uplo, $TransA, $Diag, $α, $A.matrix, $B.matrix)
}

sub dtrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int) is export {
  gsl_blas_dtrsm($Side, $Uplo, $TransA, $Diag, $α, $A.matrix, $B.matrix)
}

sub dsyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Num() $β, Math::Libgsl::Matrix $C --> Int) is export {
  gsl_blas_dsyrk($Uplo, $TransA, $α, $A.matrix, $β, $C.matrix)
}

sub dsyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int) is export {
  gsl_blas_dsyr2k($Uplo, $TransA, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}

=begin pod

=head1 NAME

Math::Libgsl::BLAS - An interface to libgsl, the Gnu Scientific Library - BLAS (Basic Linear Algebra Subprograms).

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Libgsl::Raw::BLAS :ALL;

use Math::Libgsl::BLAS;
use Math::Libgsl::BLAS::Num32;
use Math::Libgsl::BLAS::Complex32;
use Math::Libgsl::BLAS::Complex64;

=end code

=head1 DESCRIPTION

Math::Libgsl::BLAS is an interface to the BLAS functions of the libgsl, the Gnu Scientific Library

This package provides both the low-level interface to the C library (Raw) and a more comfortable interface layer for the Raku programmer.

Throughout this package I used a naming convention corresponding to that of the C library, stripping the initial C<gsl_blas_>.

The functions are divided in three levels:

=item Level 1: vector operations
=item Level 2: matrix-vector operations
=item Level 3: matrix-matrix operations

The names of the functions specify the kind of operation, the matrix type, and the underlying data type. For more information please read the L<C Library Documentation>.

Since the original C library provided functions for four data types, so does this module.
The Math::Libgsl::BLAS module provides functions that work on the default data type: num64. The functions working on num32 vector and matrices are in the Math::Libgsl::BLAS::Num32 module; those working on complex64 and complex32 are respectively in the Math::Libgsl::BLAS::Complex64 and Math::Libgsl::BLAS::Complex32 modules.

So for example this code will be executed using num32 data type variables:

=begin code :lang<raku>

use Math::Libgsl::Vector::Num32;
use Math::Libgsl::BLAS::Num32;

my $x = Math::Libgsl::Vector::Num32.new: 10;
$x.setall(.1);
my $y = Math::Libgsl::Vector::Num32.new: 10;
$y.setall(.2);
say sdsdot(.3, $x, $y); # output: 0.5

=end code

Here I'm following the order the functions are listed in the C Library Manual.

=head2 Level 1

=head3 sdsdot(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)

This function computes the sum α + T(x)y, where T(x) is the transpose of x.

=head3 sdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)
=head3 dsdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num)
=head3 ddot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Num)
=head3 cdotu(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex)
=head3 zdotu(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex)

These functions compute the scalar product T(x)y.

=head3 cdotc(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex)
=head3 zdotc(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex)

These functions compute the complex conjugate scalar product H(x)y.

=head3 snrm2(Math::Libgsl::Vector::Num32 $x --> Num)
=head3 dnrm2(Math::Libgsl::Vector $x --> Num)
=head3 scnrm2(Math::Libgsl::Vector::Complex32 $x --> Num)
=head3 dznrm2(Math::Libgsl::Vector::Complex64 $x --> Num)

These functions compute the Euclidean norm ||x||₂.

=head3 sasum(Math::Libgsl::Vector::Num32 $x --> Num)
=head3 dasum(Math::Libgsl::Vector $x --> Num)
=head3 scasum(Math::Libgsl::Vector::Complex32 $x --> Num)
=head3 dzasum(Math::Libgsl::Vector::Complex64 $x --> Num)

These functions compute the absolute sum Σ|xᵢ| of the elements of the vector x (or the sum of the magnitudes of the real and imaginary parts).

=head3 isamax(Math::Libgsl::Vector::Num32 $x --> Int)
=head3 idamax(Math::Libgsl::Vector $x --> Int)
=head3 icamax(Math::Libgsl::Vector::Complex32 $x --> Int)
=head3 izamax(Math::Libgsl::Vector::Complex64 $x --> Int)

These functions return the index of the largest element of the vector x.
The largest element is determined by its absolute magnitude for real vectors and by the sum of the magnitudes of the real and imaginary parts Σ|R(xᵢ)| + |I(xᵢ)| for complex vectors.
If the largest value occurs several times then the index of the first occurrence is returned.

=head3 sswap(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 dswap(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 cswap(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 zswap(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions exchange the elements of the vectors.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 scopy(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 dcopy(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 ccopy(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 zcopy(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions copy the elements of the vector x into the vector y.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 saxpy(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 daxpy(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 caxpy(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int)
=head3 zaxpy(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int)

These functions compute the sum y = αx + y.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 sscal(Num() $α, Math::Libgsl::Vector::Num32 $x)
=head3 dscal(Num() $α, Math::Libgsl::Vector $x)
=head3 cscal(Complex $α, Math::Libgsl::Vector::Complex32 $x)
=head3 zscal(Complex $α, Math::Libgsl::Vector::Complex64 $x)
=head3 csscal(Num() $α, Math::Libgsl::Vector::Complex32 $x)
=head3 zdscal(Num() $α, Math::Libgsl::Vector::Complex64 $x)

These functions rescale the vector x by α.

=head3 srotg(Num() $a, Num() $b --> List)
=head3 drotg(Num() $a, Num() $b --> List)

These functions compute a Givens rotation which zeroes the vector (a, b).
They return the magnitude  of the resulting vector and the coefficients (c, s) which zero the vector (a, b).
In case of error a failure object is returned.

=head3 srot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int)
=head3 drot(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int)

These functions apply a Givens rotation (x ′ , y ′ ) = (cx + sy, −sx + cy) to the vectors x, y.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 srotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List)
=head3 drotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List)

These functions compute a modified Givens transformation.
They return a list of five elements (see the BLAS manual for an explanation).
In case of error a failure object is returned.

=head3 srotm(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int)
=head3 drotm(Math::Libgsl::Vector $x, Math::Libgsl::Vector $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int)

These functions apply a modified Givens transformation.
These functions return GSL_SUCCESS if successful, or one of the error codes (see the gsl-error enum in Math::Libgsl::Constants).

=head2 Level 2

=head3 sgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y --> Int)
=head3 dgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y --> Int)
=head3 cgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int)
=head3 zgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int)

These functions compute the matrix-vector product and sum y = αop(A)x + βy. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 strmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int)
=head3 dtrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int)
=head3 ctrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int)
=head3 ztrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int)

These functions compute the matrix-vector product x = op(A)x for the triangular matrix A. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants).
When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used. If Diag is CblasNonUnit then the diagonal of the matrix is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see the cblas-uplo and cblas-diag enums in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 strsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int)
=head3 dtrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x --> Int)
=head3 ctrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int)
=head3 ztrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int)

These functions compute inv(op(A))x for x. "op" can be a no-op, a transpose, or a hermitian transpose (see the cblas-transpose enum in Math::Libgsl::Constants).
When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used. If Diag is CblasNonUnit then the diagonal of the matrix is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see the cblas-uplo and cblas-diag enums in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y  --> Int)
=head3 dsymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Vector $x, Num() $β, Math::Libgsl::Vector $y  --> Int)

These functions compute the matrix-vector product and sum y = αAx + βy for the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 chemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int)
=head3 zhemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int)

These functions compute the matrix-vector product and sum y = αAx + βy for the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically assumed to be zero and are not referenced.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 sger(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A  --> Int)
=head3 dger(Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A  --> Int)
=head3 cgeru(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)
=head3 zgeru(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the rank-1 update A = αxy T + A of the matrix A.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 cgerc(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)
=head3 zgerc(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the conjugate rank-1 update A = αxH(y) + A of the matrix A.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssyr(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Matrix::Num32 $A  --> Int)
=head3 dsyr(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Matrix $A  --> Int)

These functions compute the symmetric rank-1 update A = αxT(x) + A of the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 cher(Int $Uplo, num32 $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Matrix::Complex32 $A --> Int)
=head3 zher(Int $Uplo, num64 $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the hermitian rank-1 update A = αxx H + A of the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A  --> Int)
=head3 dsyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector $x, Math::Libgsl::Vector $y, Math::Libgsl::Matrix $A  --> Int)

These functions compute the symmetric rank-2 update A = αxT(y) + αyT(x) + A of the symmetric matrix A. Since the matrix A is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 cher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int)
=head3 zher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int)

These functions compute the hermitian rank-2 update A = αxH(y) + α * yH(x) + A of the hermitian matrix A. Since the matrix A is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head2 Level 3

=head3 sgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)
=head3 dgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)
=head3 cgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αop(A)op(B) + βC where op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans and similarly for the parameter TransB (see the cblas-transpose enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)
=head3 dsymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)
=head3 csymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zsymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αAB + βC for Side is CblasLeft and C = αBA + βC for Side is CblasRight, where the matrix A is symmetric (see the cblas-side enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 chemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zhemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute the matrix-matrix product and sum C = αAB + βC for Side is CblasLeft and C = αBA + βC for Side is CblasRight, where the matrix A is hermitian (see the cblas-side enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle and diagonal of A are used, and when Uplo is CblasLower then the lower triangle and diagonal of A are used (see the cblas-uplo enum in Math::Libgsl::Constants). The imaginary elements of the diagonal are automatically set to zero.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 strmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int)
=head3 dtrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int)
=head3 ctrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int)
=head3 ztrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int)

These functions compute the matrix-matrix product B = αop(A)B for Side is CblasLeft and B = αBop(A) for Side is CblasRight (see the cblas-side enum in Math::Libgsl::Constants). The matrix A is triangular and op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used (see the cblas-uplo enum in Math::Libgsl::Constants). If Diag is CblasNonUnit then the diagonal of A is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see cblas-diag enums in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 strsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int)
=head3 dtrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B --> Int)
=head3 ctrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int)
=head3 ztrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int)

These functions compute the inverse-matrix matrix product B = αop(inv(A))B for Side is CblasLeft and B = αBop(inv(A)) for Side is CblasRight (see the cblas-side enum in Math::Libgsl::Constants). The matrix A is triangular and op(A) = A, T(A), H(A) for TransA = CblasNoTrans, CblasTrans, CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). When Uplo is CblasUpper then the upper triangle of A is used, and when Uplo is CblasLower then the lower triangle of A is used (see the cblas-uplo enum in Math::Libgsl::Constants). If Diag is CblasNonUnit then the diagonal of A is used, but if Diag is CblasUnit then the diagonal elements of the matrix A are taken as unity and are not referenced (see cblas-diag enums in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)
=head3 dsyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Num() $β, Math::Libgsl::Matrix $C --> Int)
=head3 csyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zsyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-k update of the symmetric matrix C, C = αAT(A) + βC when Trans is CblasNoTrans and C = αT(A)A + βC when Trans is CblasTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 cherk(Int $Uplo, Int $TransA, num32 $α, Math::Libgsl::Matrix::Complex32 $A, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zherk(Int $Uplo, Int $TransA, num64 $α, Math::Libgsl::Matrix::Complex64 $A, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-k update of the hermitian matrix C, C = αAH(A) + βC when Trans is CblasNoTrans and C = αH(A)A + βC when Trans is CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants).
The imaginary elements of the diagonal are automatically set to zero.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 ssyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int)
=head3 dsyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix $A, Math::Libgsl::Matrix $B, Num() $β, Math::Libgsl::Matrix $C --> Int)
=head3 csyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zsyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-2k update of the symmetric matrix C, C = αAT(B) + αBT(A) + βC when Trans is CblasNoTrans and C = αT(A)B + αT(B)A + βC when Trans is CblasTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is symmetric only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants).
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head3 cher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int)
=head3 zher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int)

These functions compute a rank-2k update of the hermitian matrix C, C = αAH(B) + conj(α)BH(A) + βC when Trans is CblasNoTrans and C = αH(A)B + conj(α)H(B)A + βC when Trans is CblasConjTrans (see the cblas-transpose enum in Math::Libgsl::Constants). Since the matrix C is hermitian only its upper half or lower half need to be stored. When Uplo is CblasUpper then the upper triangle and diagonal of C are used, and when Uplo is CblasLower then the lower triangle and diagonal of C are used (see the cblas-uplo enum in Math::Libgsl::Constants).
The imaginary elements of the diagonal are automatically set to zero.
These functions return GSL_SUCCESS if successful, or one of the error codes listed in Math::Libgsl::Constants::gsl-error.

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.

The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

The BLAS C Library manual is available here L<https://software.intel.com/en-us/mkl-developer-reference-c-blas-routines> and here L<http://netlib.org/blas/#_level_1>.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04 and Ubuntu 20.04+

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::BLAS
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
