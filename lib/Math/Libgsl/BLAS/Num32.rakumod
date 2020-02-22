use v6;

unit class Math::Libgsl::BLAS::Num32:ver<0.0.3>:auth<cpan:FRITH>;

use NativeCall;
use Math::Libgsl::Raw::BLAS :ALL;
use Math::Libgsl::Vector::Num32;
use Math::Libgsl::Matrix::Num32;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;

# Level 1
sub sdsdot(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num) is export {
  my num32 $res = 0e0;
  my num32 $alpha = $α;
  my $ret = gsl_blas_sdsdot($alpha, $x.vector, $y.vector, $res);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  $res
}

sub sdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num) is export {
  my num32 $res = 0e0;
  my $ret = gsl_blas_sdot($x.vector, $y.vector, $res);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  $res
}

sub dsdot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Num) is export {
  my num64 $res = 0e0;
  my $ret = gsl_blas_dsdot($x.vector, $y.vector, $res);
  fail X::Libgsl.new: errno => $ret, error => "Can't multiply vectors" if $ret ≠ GSL_SUCCESS;
  $res
}

sub snrm2(Math::Libgsl::Vector::Num32 $x --> Num) is export {
  gsl_blas_snrm2($x.vector)
}

sub sasum(Math::Libgsl::Vector::Num32 $x --> Num) is export {
  gsl_blas_sasum($x.vector)
}

sub isamax(Math::Libgsl::Vector::Num32 $x --> Int) is export {
  gsl_blas_isamax($x.vector)
}

sub sswap(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_sswap($x.vector, $y.vector)
}

sub scopy(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  gsl_blas_scopy($x.vector, $y.vector)
}

sub saxpy(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size } --> Int) is export {
  my num32 $alpha = $α;
  gsl_blas_saxpy($alpha, $x.vector, $y.vector)
}

sub sscal(Num() $α, Math::Libgsl::Vector::Num32 $x) is export {
  my num32 $alpha = $α;
  gsl_blas_sscal($alpha, $x.vector)
}

sub srotg(Num() $a, Num() $b --> List) is export {
  my num32 $ma = $a;
  my num32 $mb = $b;
  my num32 ($mc, $ms);
  my $ret = gsl_blas_srotg($ma, $mb, $mc, $ms);
  fail X::Libgsl.new: errno => $ret, error => "Can't apply Givens rotation" if $ret ≠ GSL_SUCCESS;
  $ma, $mc, $ms
}

sub srot(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, Num() $c, Num() $s --> Int) is export {
  my num32 $mc = $c;
  my num32 $ms = $s;
  gsl_blas_srot($x.vector, $y.vector, $mc, $ms);
}

sub srotmg(Num() $d1, Num() $d2, Num() $b1, Num() $b2 --> List) is export {
  my num32 $md1 = $d1;
  my num32 $md2 = $d2;
  my num32 $mb1 = $b1;
  my num32 $mb2 = $b2;
  my $P = CArray[num32].allocate(5);
  my $ret = gsl_blas_srotmg($md1, $md2, $mb1, $mb2, $P);
  fail X::Libgsl.new: errno => $ret, error => "Can't apply Givens rotation" if $ret ≠ GSL_SUCCESS;
  $P.list
}

sub srotm(Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y where { $y.vector.size == $x.vector.size }, @param where *.elems == 5 --> Int) is export {
  my CArray[num32] $P .= new: @param».Num;
  gsl_blas_srotm($x.vector, $y.vector, $P)
}

# Level 2
sub sgemv(Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y --> Int) is export {
  gsl_blas_sgemv($TransA, $α, $A.matrix, $x.vector, $β, $y.vector)
}

sub strmv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int) is export {
  gsl_blas_strmv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub strsv(Int $Uplo, Int $TransA, Int $Diag, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x --> Int) is export {
  gsl_blas_strsv($Uplo, $TransA, $Diag, $A.matrix, $x.vector)
}

sub ssymv(Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Vector::Num32 $x, Num() $β, Math::Libgsl::Vector::Num32 $y  --> Int) is export {
  gsl_blas_ssymv($Uplo, $α, $A.matrix, $x.vector, $β, $y.vector)
}

sub sger(Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A  --> Int) is export {
  gsl_blas_sger($α, $x.vector, $y.vector, $A.matrix)
}

sub ssyr(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Matrix::Num32 $A  --> Int) is export {
  gsl_blas_ssyr($Uplo, $α, $x.vector, $A.matrix)
}

sub ssyr2(Int $Uplo, Num() $α, Math::Libgsl::Vector::Num32 $x, Math::Libgsl::Vector::Num32 $y, Math::Libgsl::Matrix::Num32 $A  --> Int) is export {
  gsl_blas_ssyr2($Uplo, $α, $x.vector, $y.vector, $A.matrix)
}

# Level 3
sub sgemm(Int $TransA, Int $TransB, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int) is export {
  gsl_blas_sgemm($TransA, $TransB, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}

sub ssymm(Int $Side, Int $Uplo, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int) is export {
  gsl_blas_ssymm($Side, $Uplo, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}

sub strmm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int) is export {
  gsl_blas_strmm($Side, $Uplo, $TransA, $Diag, $α, $A.matrix, $B.matrix)
}

sub strsm(Int $Side, Int $Uplo, Int $TransA, Int $Diag, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B --> Int) is export {
  gsl_blas_strsm($Side, $Uplo, $TransA, $Diag, $α, $A.matrix, $B.matrix)
}

sub ssyrk(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int) is export {
  gsl_blas_ssyrk($Uplo, $TransA, $α, $A.matrix, $β, $C.matrix)
}

sub ssyr2k(Int $Uplo, Int $TransA, Num() $α, Math::Libgsl::Matrix::Num32 $A, Math::Libgsl::Matrix::Num32 $B, Num() $β, Math::Libgsl::Matrix::Num32 $C --> Int) is export {
  gsl_blas_ssyr2k($Uplo, $TransA, $α, $A.matrix, $B.matrix, $β, $C.matrix)
}
