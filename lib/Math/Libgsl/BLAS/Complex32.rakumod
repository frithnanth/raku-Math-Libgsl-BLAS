use v6;

unit class Math::Libgsl::BLAS::Complex32:ver<0.0.3>:auth<zef:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::BLAS :ALL;
use Math::Libgsl::Raw::Complex :ALL;
use Math::Libgsl::Vector::Complex32;
use Math::Libgsl::Matrix::Complex32;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;

# Level 1
sub cdotu(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex) is export {
  my gsl_complex_float $dotu = alloc_gsl_complex_float;
  my $ret = gsl_blas_cdotu($x.vector, $y.vector, $dotu);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  my Complex $c = $dotu.dat[0] + i * $dotu.dat[1];
  free_gsl_complex_float($dotu);
  $c
}

sub cdotc(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Complex) is export {
  my gsl_complex_float $dotu = alloc_gsl_complex_float;
  my $ret = gsl_blas_cdotc($x.vector, $y.vector, $dotu);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  my Complex $c = $dotu.dat[0] + i * $dotu.dat[1];
  free_gsl_complex_float($dotu);
  $c
}

sub scnrm2(Math::Libgsl::Vector::Complex32 $x --> Num) is export {
  gsl_blas_scnrm2($x.vector)
}

sub scasum(Math::Libgsl::Vector::Complex32 $x --> Num) is export {
  gsl_blas_scasum($x.vector)
}

sub icamax(Math::Libgsl::Vector::Complex32 $x --> Int) is export {
  gsl_blas_icamax($x.vector)
}

sub cswap(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_cswap($x.vector, $y.vector)
}

sub ccopy(Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_ccopy($x.vector, $y.vector)
}

sub caxpy(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my $ret = mgsl_blas_caxpy($alpha, $x.vector, $y.vector);
  free_gsl_complex_float($alpha);
  $ret
}

sub cscal(Complex $α, Math::Libgsl::Vector::Complex32 $x) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_cscal($alpha, $x.vector);
  free_gsl_complex_float($alpha)
}

sub csscal(Num() $α, Math::Libgsl::Vector::Complex32 $x) is export {
  my num32 $alpha = $α;
  gsl_blas_csscal($alpha, $x.vector)
}

# Level 2
sub cgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_cgemv($TransA, $alpha, $A.matrix, $x.vector, $beta, $y.vector)
}

sub ctrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int) is export {
  gsl_blas_ctrmv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub ctrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x --> Int) is export {
  gsl_blas_ctrsv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub chemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Vector::Complex32 $x, Complex $β, Math::Libgsl::Vector::Complex32 $y --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_chemv($Uplo, $alpha, $A.matrix, $x.vector, $beta, $y.vector)
}

sub cgeru(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_cgeru($alpha, $x.vector, $y.vector, $A.matrix)
}

sub cgerc(Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_cgerc($alpha, $x.vector, $y.vector, $A.matrix)
}

sub cher(Int $Uplo, num32 $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Matrix::Complex32 $A --> Int) is export {
  gsl_blas_cher($Uplo, $α, $x.vector, $A.matrix)
}

sub cher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex32 $x, Math::Libgsl::Vector::Complex32 $y, Math::Libgsl::Matrix::Complex32 $A --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_cher2($Uplo, $alpha, $x.vector, $y.vector, $A.matrix)
}

# Level 3
sub cgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_cgemm($TransA, $TransB, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub csymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_csymm($Side, $Uplo, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub chemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_chemm($Side, $Uplo, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub ctrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_ctrmm($Side, $Uplo, $TransA, $Diag, $alpha, $A.matrix, $B.matrix)
}

sub ctrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_ctrsm($Side, $Uplo, $TransA, $Diag, $alpha, $A.matrix, $B.matrix)
}

sub csyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_csyrk($Uplo, $TransA, $alpha, $A.matrix, $beta, $C.matrix)
}

sub cherk(Int $Uplo, Int $TransA, num32 $α, Math::Libgsl::Matrix::Complex32 $A, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  gsl_blas_cherk($Uplo, $TransA, $α, $A.matrix, $β, $C.matrix)
}

sub csyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, Complex $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  my gsl_complex_float $beta = alloc_gsl_complex_float;
  mgsl_complex_float_rect($β.re, $β.im, $beta);
  mgsl_blas_csyr2k($Uplo, $TransA, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub cher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex32 $A, Math::Libgsl::Matrix::Complex32 $B, num32 $β, Math::Libgsl::Matrix::Complex32 $C --> Int) is export {
  my gsl_complex_float $alpha = alloc_gsl_complex_float;
  mgsl_complex_float_rect($α.re, $α.im, $alpha);
  mgsl_blas_cher2k($Uplo, $TransA, $alpha, $A.matrix, $B.matrix, $β, $C.matrix)
}
