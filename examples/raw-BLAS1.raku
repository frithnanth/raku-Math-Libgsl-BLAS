#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 13 BLAS Support, Paragraph 13.2 Examples

use Math::Libgsl::Constants;
use Math::Libgsl::Raw::Matrix :ALL;
use NativeCall;
use lib 'lib';
use Math::Libgsl::Raw::BLAS :ALL;

my CArray[num64] $a .= new: (0.11, 0.12, 0.13, 0.21, 0.22, 0.23)».Num;
my CArray[num64] $b .= new: (1011, 1012, 1021, 1022, 1031, 1032)».Num;
my CArray[num64] $c .= new: (0, 0, 0, 0)».Num;

my gsl_matrix_view $viewa = alloc_gsl_matrix_view;
my gsl_matrix_view $viewb = alloc_gsl_matrix_view;
my gsl_matrix_view $viewc = alloc_gsl_matrix_view;
my gsl_matrix $A = mgsl_matrix_view_array($viewa, $a, 2, 3);
my gsl_matrix $B = mgsl_matrix_view_array($viewb, $b, 3, 2);
my gsl_matrix $C = mgsl_matrix_view_array($viewc, $c, 2, 2);

gsl_blas_dgemm(CblasNoTrans, CblasNoTrans, 1e0, $A, $B, 0e0, $C);
printf "[ %g, %g\n",  gsl_matrix_get($C, 0, 0), gsl_matrix_get($C, 0, 1);
printf "  %g, %g]\n", gsl_matrix_get($C, 1, 0), gsl_matrix_get($C, 1, 1);
