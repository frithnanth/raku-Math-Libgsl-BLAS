[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-BLAS)

NAME
====

Math::Libgsl::BLAS - An interface to libgsl, the Gnu Scientific Library - BLAS (Basic Linear Algebra Subprograms).

SYNOPSIS
========

```perl6
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

Since the original C library provided four data types, so does this module. The default data type is num64, accessed through the Math::Libgsl::BLAS module; the functions working on num32 vector and matrices are in the Math::Libgsl::BLAS::Num32 module; those working on complex64 and complex32 are respectively in the Math::Libgsl::BLAS::Complex64 and Math::Libgsl::BLAS::Complex32 modules.

So for example this code will be executed using variables of the num32 data type:

```perl6
use Math::Libgsl::Vector::Num32;
use Math::Libgsl::BLAS::Num32;

my $x = Math::Libgsl::Vector::Num32.new: 10;
$x.setall(.1);
my $y = Math::Libgsl::Vector::Num32.new: 10;
$y.setall(.2);
say sdsdot(.3, $x, $y); # output: 0.5
```

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/).

The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux
------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

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

