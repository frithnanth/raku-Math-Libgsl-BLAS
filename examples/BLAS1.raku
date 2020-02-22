#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 13 BLAS Support, Paragraph 13.2 Examples

use Math::Libgsl::Constants;
use Math::Libgsl::Matrix;
use lib 'lib';
use Math::Libgsl::BLAS;

my @a[2;3] = (0.11, 0.12, 0.13; 0.21, 0.22, 0.23);
my @b[3;2] = (1011, 1012; 1021, 1022; 1031, 1032);
my @c[2;2] = (0, 0; 0, 0);

my Math::Libgsl::Matrix::View $viewa .= new;
my Math::Libgsl::Matrix::View $viewb .= new;
my Math::Libgsl::Matrix::View $viewc .= new;
my Math::Libgsl::Matrix $A = mat-view-array($viewa, @a);
my Math::Libgsl::Matrix $B = mat-view-array($viewb, @b);
my Math::Libgsl::Matrix $C = mat-view-array($viewc, @c);

dgemm(CblasNoTrans, CblasNoTrans, 1, $A, $B, 0, $C);
printf "[ %g, %g\n",  $C[0; 0], $C[0; 1];
printf "  %g, %g]\n", $C[1; 0], $C[1; 1];
