#!/usr/bin/env raku

use Math::Libgsl::Constants;
use Math::Libgsl::Raw::Matrix :ALL;
use lib 'lib';
use Math::Libgsl::Raw::BLAS :ALL;

my gsl_matrix $A = gsl_matrix_calloc(2, 3);
gsl_matrix_set($A, 0, 0, .11e0);
gsl_matrix_set($A, 0, 1, .12e0);
gsl_matrix_set($A, 0, 2, .13e0);
gsl_matrix_set($A, 1, 0, .21e0);
gsl_matrix_set($A, 1, 1, .22e0);
gsl_matrix_set($A, 1, 2, .23e0);

my gsl_matrix $B = gsl_matrix_calloc(3, 2);
gsl_matrix_set($B, 0, 0, 1011e0);
gsl_matrix_set($B, 0, 1, 1012e0);
gsl_matrix_set($B, 1, 0, 1021e0);
gsl_matrix_set($B, 1, 1, 1022e0);
gsl_matrix_set($B, 2, 0, 1031e0);
gsl_matrix_set($B, 2, 1, 1032e0);

my gsl_matrix $C = gsl_matrix_calloc(2, 2);

gsl_blas_dgemm(CblasNoTrans, CblasNoTrans, 1e0, $A, $B, 0e0, $C);
printf "[ %g, %g\n",  gsl_matrix_get($C, 0, 0), gsl_matrix_get($C, 0, 1);
printf "  %g, %g]\n", gsl_matrix_get($C, 1, 0), gsl_matrix_get($C, 1, 1);
