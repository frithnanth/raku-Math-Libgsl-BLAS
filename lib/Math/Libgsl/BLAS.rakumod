use v6.c;

unit class Math::Libgsl::BLAS:ver<0.0.1>:auth<cpan:FRITH>;

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

[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS)

=head1 NAME

Math::Libgsl::BLAS - An interface to libgsl, the Gnu Scientific Library - BLAS (Basic Linear Algebra Subprograms).

=head1 SYNOPSIS

=begin code :lang<perl6>

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

Since the original C library provided four data types, so does this module.
The default data type is num64, accessed through the Math::Libgsl::BLAS module; the functions working on num32 vector and matrices are in the Math::Libgsl::BLAS::Num32 module; those working on complex64 and complex32 are respectively in the Math::Libgsl::BLAS::Complex64 and Math::Libgsl::BLAS::Complex32 modules.

So for example this code will be executed using variables of the num32 data type:

=begin code :lang<perl6>

use Math::Libgsl::Vector::Num32;
use Math::Libgsl::BLAS::Num32;

my $x = Math::Libgsl::Vector::Num32.new: 10;
$x.setall(.1);
my $y = Math::Libgsl::Vector::Num32.new: 10;
$y.setall(.2);
say sdsdot(.3, $x, $y); # output: 0.5

=end code

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.

The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

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
