use v6;

unit class Math::Libgsl::BLAS::Complex64:ver<0.0.2>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::BLAS :ALL;
use Math::Libgsl::Raw::Complex :ALL;
use Math::Libgsl::Vector::Complex64;
use Math::Libgsl::Matrix::Complex64;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;

# Level 1
sub zdotu(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex) is export {
  my gsl_complex $dotu = alloc_gsl_complex;
  my $ret = gsl_blas_zdotu($x.vector, $y.vector, $dotu);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  my Complex $c = $dotu.dat[0] + i * $dotu.dat[1];
  free_gsl_complex($dotu);
  $c
}

sub zdotc(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Complex) is export {
  my gsl_complex $dotu = alloc_gsl_complex;
  my $ret = gsl_blas_zdotc($x.vector, $y.vector, $dotu);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  my Complex $c = $dotu.dat[0] + i * $dotu.dat[1];
  free_gsl_complex($dotu);
  $c
}

sub dznrm2(Math::Libgsl::Vector::Complex64 $x --> Num) is export {
  gsl_blas_dznrm2($x.vector)
}

sub dzasum(Math::Libgsl::Vector::Complex64 $x --> Num) is export {
  gsl_blas_dzasum($x.vector)
}

sub izamax(Math::Libgsl::Vector::Complex64 $x --> Int) is export {
  gsl_blas_izamax($x.vector)
}

sub zswap(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_zswap($x.vector, $y.vector)
}

sub zcopy(Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_zcopy($x.vector, $y.vector)
}

sub zaxpy(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my $ret = mgsl_blas_zaxpy($alpha, $x.vector, $y.vector);
  free_gsl_complex($alpha);
  $ret
}

sub zscal(Complex $α, Math::Libgsl::Vector::Complex64 $x) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_zscal($alpha, $x.vector);
  free_gsl_complex($alpha)
}

sub zdscal(Num() $α, Math::Libgsl::Vector::Complex64 $x) is export {
  my num64 $alpha = $α;
  gsl_blas_zdscal($alpha, $x.vector)
}

# Level 2
sub zgemv(Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zgemv($TransA, $alpha, $A.matrix, $x.vector, $beta, $y.vector)
}

sub ztrmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int) is export {
  gsl_blas_ztrmv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub ztrsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x --> Int) is export {
  gsl_blas_ztrsv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub zhemv(Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Vector::Complex64 $x, Complex $β, Math::Libgsl::Vector::Complex64 $y --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zhemv($Uplo, $alpha, $A.matrix, $x.vector, $beta, $y.vector)
}

sub zgeru(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_zgeru($alpha, $x.vector, $y.vector, $A.matrix)
}

sub zgerc(Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_zgerc($alpha, $x.vector, $y.vector, $A.matrix)
}

sub zher(Int $Uplo, num64 $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Matrix::Complex64 $A --> Int) is export {
  gsl_blas_zher($Uplo, $α, $x.vector, $A.matrix)
}

sub zher2(Int $Uplo, Complex $α, Math::Libgsl::Vector::Complex64 $x, Math::Libgsl::Vector::Complex64 $y, Math::Libgsl::Matrix::Complex64 $A --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_zher2($Uplo, $alpha, $x.vector, $y.vector, $A.matrix)
}

# Level 3
sub zgemm(Int $TransA, Int $TransB, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zgemm($TransA, $TransB, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub zsymm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zsymm($Side, $Uplo, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub zhemm(Int $Side, Int $Uplo, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zhemm($Side, $Uplo, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub ztrmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_ztrmm($Side, $Uplo, $TransA, $Diag, $alpha, $A.matrix, $B.matrix)
}

sub ztrsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_ztrsm($Side, $Uplo, $TransA, $Diag, $alpha, $A.matrix, $B.matrix)
}

sub zsyrk(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zsyrk($Uplo, $TransA, $alpha, $A.matrix, $beta, $C.matrix)
}

sub zherk(Int $Uplo, Int $TransA, num64 $α, Math::Libgsl::Matrix::Complex64 $A, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  gsl_blas_zherk($Uplo, $TransA, $α, $A.matrix, $β, $C.matrix)
}

sub zsyr2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, Complex $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  my gsl_complex $beta = alloc_gsl_complex;
  mgsl_complex_rect($β.re, $β.im, $beta);
  mgsl_blas_zsyr2k($Uplo, $TransA, $alpha, $A.matrix, $B.matrix, $beta, $C.matrix)
}

sub zher2k(Int $Uplo, Int $TransA, Complex $α, Math::Libgsl::Matrix::Complex64 $A, Math::Libgsl::Matrix::Complex64 $B, num64 $β, Math::Libgsl::Matrix::Complex64 $C --> Int) is export {
  my gsl_complex $alpha = alloc_gsl_complex;
  mgsl_complex_rect($α.re, $α.im, $alpha);
  mgsl_blas_zher2k($Uplo, $TransA, $alpha, $A.matrix, $B.matrix, $β, $C.matrix)
}
