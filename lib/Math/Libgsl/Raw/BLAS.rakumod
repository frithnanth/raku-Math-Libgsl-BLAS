use v6;

unit module Math::Libgsl::Raw::BLAS:ver<0.0.3>:auth<cpan:FRITH>;

use NativeCall;
use LibraryMake;
use Math::Libgsl::Raw::Complex;
use Math::Libgsl::Raw::Matrix :ALL;
use Math::Libgsl::Raw::Matrix::Num32 :ALL;
use Math::Libgsl::Raw::Matrix::Complex64 :ALL;
use Math::Libgsl::Raw::Matrix::Complex32 :ALL;

constant GSLHELPER = %?RESOURCES<libraries/gslhelper>.absolute;

constant LIB  = ('gsl', v23);

# Level 1
sub gsl_blas_sdsdot(num32 $α, gsl_vector_float $x, gsl_vector_float $y, num32 $result is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_sdot(gsl_vector_float $x, gsl_vector_float $y, num32 $result is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dsdot(gsl_vector_float $x, gsl_vector_float $y, num64 $result is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_ddot(gsl_vector $x, gsl_vector $y, num64 $result is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_cdotu(gsl_vector_complex_float $x, gsl_vector_complex_float $y, gsl_complex_float $dotu --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_zdotu(gsl_vector_complex $x, gsl_vector_complex $y, gsl_complex $dotu --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_cdotc(gsl_vector_complex_float $x, gsl_vector_complex_float $y, gsl_complex_float $dotc --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_zdotc(gsl_vector_complex $x, gsl_vector_complex $y, gsl_complex $dotc --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_snrm2(gsl_vector_float $x --> num32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dnrm2(gsl_vector $x --> num64) is native(LIB) is export(:level1) { * }
sub gsl_blas_scnrm2(gsl_vector_complex_float $x --> num32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dznrm2(gsl_vector_complex $x --> num64) is native(LIB) is export(:level1) { * }
sub gsl_blas_sasum(gsl_vector_float $x --> num32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dasum(gsl_vector $x --> num64) is native(LIB) is export(:level1) { * }
sub gsl_blas_scasum(gsl_vector_complex_float $x --> num32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dzasum(gsl_vector_complex $x --> num64) is native(LIB) is export(:level1) { * }
sub gsl_blas_isamax(gsl_vector_float $x --> size_t) is native(LIB) is export(:level1) { * }
sub gsl_blas_idamax(gsl_vector $x --> size_t) is native(LIB) is export(:level1) { * }
sub gsl_blas_icamax(gsl_vector_complex_float $x --> size_t) is native(LIB) is export(:level1) { * }
sub gsl_blas_izamax(gsl_vector_complex $x --> size_t) is native(LIB) is export(:level1) { * }
sub gsl_blas_sswap(gsl_vector_float $x, gsl_vector_float $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dswap(gsl_vector $x, gsl_vector $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_cswap(gsl_vector_complex_float $x, gsl_vector_complex_float $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_zswap(gsl_vector_complex $x, gsl_vector_complex $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_scopy(gsl_vector_float $x, gsl_vector_float $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_dcopy(gsl_vector $x, gsl_vector $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_ccopy(gsl_vector_complex_float $x, gsl_vector_complex_float $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_zcopy(gsl_vector_complex $x, gsl_vector_complex $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_saxpy(num32 $α, gsl_vector_float $x, gsl_vector_float $y --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_daxpy(num64 $α, gsl_vector $x, gsl_vector $y --> int32) is native(LIB) is export(:level1) { * }
sub mgsl_blas_caxpy(gsl_complex_float $α, gsl_vector_complex_float $x, gsl_vector_complex_float $y --> int32) is native(GSLHELPER) is export(:level1) { * }
sub mgsl_blas_zaxpy(gsl_complex $α, gsl_vector_complex $x, gsl_vector_complex $y --> int32) is native(GSLHELPER) is export(:level1) { * }
sub gsl_blas_sscal(num32 $α, gsl_vector_float $x) is native(LIB) is export(:level1) { * }
sub gsl_blas_dscal(num64 $α, gsl_vector $x) is native(LIB) is export(:level1) { * }
sub mgsl_blas_cscal(gsl_complex_float $α, gsl_vector_complex_float $x) is native(GSLHELPER) is export(:level1) { * }
sub mgsl_blas_zscal(gsl_complex $α, gsl_vector_complex $x) is native(GSLHELPER) is export(:level1) { * }
sub gsl_blas_csscal(num32 $α, gsl_vector_complex_float $x) is native(LIB) is export(:level1) { * }
sub gsl_blas_zdscal(num64 $α, gsl_vector_complex $x) is native(LIB) is export(:level1) { * }
sub gsl_blas_srotg(num32 $a is rw, num32 $b is rw, num32 $c is rw, num32 $s is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_drotg(num64 $a is rw, num64 $b is rw, num64 $c is rw, num64 $s is rw --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_srot(gsl_vector_float $x, gsl_vector_float $y, num32 $c, num32 $s --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_drot(gsl_vector $x, gsl_vector $y, num64 $c, num64 $s --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_srotmg(num32 $d1 is rw, num32 $d2 is rw, num32 $b1 is rw, num32 $b2, CArray[num32] $P --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_drotmg(num64 $d1 is rw, num64 $d2 is rw, num64 $b1 is rw, num64 $b2, CArray[num64] $P --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_srotm(gsl_vector_float $x, gsl_vector_float $y, CArray[num32] $P --> int32) is native(LIB) is export(:level1) { * }
sub gsl_blas_drotm(gsl_vector $x, gsl_vector $y, CArray[num64] $P --> int32) is native(LIB) is export(:level1) { * }
# Level 2
sub gsl_blas_sgemv(int32 $TransA, num32 $α, gsl_matrix_float $A, gsl_vector_float $x, num32 $β, gsl_vector_float $y --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dgemv(int32 $TransA, num64 $α, gsl_matrix $A, gsl_vector $x, num64 $β, gsl_vector $y --> int32) is native(LIB) is export(:level2) { * }
sub mgsl_blas_cgemv(int32 $TransA, gsl_complex_float $α, gsl_matrix_complex_float $A, gsl_vector_complex_float $x, gsl_complex_float $β, gsl_vector_complex_float $y --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_zgemv(int32 $TransA, gsl_complex $α, gsl_matrix_complex $A, gsl_vector_complex $x, gsl_complex $β, gsl_vector_complex $y --> int32) is native(GSLHELPER) is export(:level2) { * }
sub gsl_blas_strmv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_float $A, gsl_vector_float $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dtrmv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix $A, gsl_vector $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ctrmv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_complex_float $A, gsl_vector_complex_float $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ztrmv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_complex $A, gsl_vector_complex $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_strsv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_float $A, gsl_vector_float $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dtrsv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix $A, gsl_vector $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ctrsv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_complex_float $A, gsl_vector_complex_float $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ztrsv(int32 $Uplo, int32 $TransA, int32 $Diag, gsl_matrix_complex $A, gsl_vector_complex $x --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ssymv(int32 $Uplo, num32 $alpha, gsl_matrix_float $A, gsl_vector_float $x, num32 $beta, gsl_vector_float $y --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dsymv(int32 $Uplo, num64 $alpha, gsl_matrix $A, gsl_vector $x, num64 $beta, gsl_vector $y --> int32) is native(LIB) is export(:level2) { * }
sub mgsl_blas_chemv(int32 $Uplo, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_vector_complex_float $x, gsl_complex_float $beta, gsl_vector_complex_float $y --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_zhemv(int32 $Uplo, gsl_complex $alpha, gsl_matrix_complex $A, gsl_vector_complex $x, gsl_complex $beta, gsl_vector_complex $y --> int32) is native(GSLHELPER) is export(:level2) { * }
sub gsl_blas_sger(num32 $alpha, gsl_vector_float $x, gsl_vector_float $y, gsl_matrix_float $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dger(num64 $alpha, gsl_vector $x, gsl_vector $y, gsl_matrix $A --> int32) is native(LIB) is export(:level2) { * }
sub mgsl_blas_cgeru(gsl_complex_float $alpha, gsl_vector_complex_float $x, gsl_vector_complex_float $y, gsl_matrix_complex_float $A --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_zgeru(gsl_complex $alpha, gsl_vector_complex $x, gsl_vector_complex $y, gsl_matrix_complex $A --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_cgerc(gsl_complex_float $alpha, gsl_vector_complex_float $x, gsl_vector_complex_float $y, gsl_matrix_complex_float $A --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_zgerc(gsl_complex $alpha, gsl_vector_complex $x, gsl_vector_complex $y, gsl_matrix_complex $A --> int32) is native(GSLHELPER) is export(:level2) { * }
sub gsl_blas_ssyr(int32 $Uplo, num32 $alpha, gsl_vector_float $x, gsl_matrix_float $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dsyr(int32 $Uplo, num64 $alpha, gsl_vector $x, gsl_matrix $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_cher(int32 $Uplo, num32 $alpha, gsl_vector_complex_float $x, gsl_matrix_complex_float $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_zher(int32 $Uplo, num64 $alpha, gsl_vector_complex $x, gsl_matrix_complex $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_ssyr2(int32 $Uplo, num32 $alpha, gsl_vector_float $x, gsl_vector_float $y, gsl_matrix_float $A --> int32) is native(LIB) is export(:level2) { * }
sub gsl_blas_dsyr2(int32 $Uplo, num64 $alpha, gsl_vector $x, gsl_vector $y, gsl_matrix $A --> int32) is native(LIB) is export(:level2) { * }
sub mgsl_blas_cher2(int32 $Uplo, gsl_complex_float $alpha, gsl_vector_complex_float $x, gsl_vector_complex_float $y, gsl_matrix_complex_float $A --> int32) is native(GSLHELPER) is export(:level2) { * }
sub mgsl_blas_zher2(int32 $Uplo, gsl_complex $alpha, gsl_vector_complex $x, gsl_vector_complex $y, gsl_matrix_complex $A --> int32) is native(GSLHELPER) is export(:level2) { * }
# Level 3
sub gsl_blas_sgemm(int32 $TransA, int32 $TransB, num32 $alpha, gsl_matrix_float $A, gsl_matrix_float $B, num32 $beta, gsl_matrix_float $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dgemm(int32 $TransA, int32 $TransB, num64 $alpha, gsl_matrix $A, gsl_matrix $B, num64 $beta, gsl_matrix $C --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_cgemm(int32 $TransA, int32 $TransB, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B, gsl_complex_float $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zgemm(int32 $TransA, int32 $TransB, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B, gsl_complex $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub gsl_blas_ssymm(int32 $Side, int32 $Uplo, num32 $alpha, gsl_matrix_float $A, gsl_matrix_float $B, num32 $beta, gsl_matrix_float $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dsymm(int32 $Side, int32 $Uplo, num64 $alpha, gsl_matrix $A, gsl_matrix $B, num64 $beta, gsl_matrix $C --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_csymm(int32 $Side, int32 $Uplo, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B, gsl_complex_float $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zsymm(int32 $Side, int32 $Uplo, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B, gsl_complex $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_chemm(int32 $Side, int32 $Uplo, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B, gsl_complex_float $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zhemm(int32 $Side, int32 $Uplo, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B, gsl_complex $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub gsl_blas_strmm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, num32 $alpha, gsl_matrix_float $A, gsl_matrix_float $B --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dtrmm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, num64 $alpha, gsl_matrix $A, gsl_matrix $B --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_ctrmm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_ztrmm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B --> int32) is native(GSLHELPER) is export(:level3) { * }
sub gsl_blas_strsm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, num32 $alpha, gsl_matrix_float $A, gsl_matrix_float $B --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dtrsm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, num64 $alpha, gsl_matrix $A, gsl_matrix $B --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_ctrsm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_ztrsm(int32 $Side, int32 $Uplo, int32 $TransA, int32 $Diag, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B --> int32) is native(GSLHELPER) is export(:level3) { * }
sub gsl_blas_ssyrk(int32 $Uplo, int32 $TransA, num32 $alpha, gsl_matrix_float $A, num32 $beta, gsl_matrix_float $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dsyrk(int32 $Uplo, int32 $TransA, num64 $alpha, gsl_matrix $A, num64 $beta, gsl_matrix $C --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_csyrk(int32 $Uplo, int32 $TransA, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_complex_float $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zsyrk(int32 $Uplo, int32 $TransA, gsl_complex $alpha, gsl_matrix_complex $A, gsl_complex $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub gsl_blas_cherk(int32 $Uplo, int32 $TransA, num32 $alpha, gsl_matrix_complex_float $A, num32 $beta, gsl_matrix_complex_float $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_zherk(int32 $Uplo, int32 $TransA, num64 $alpha, gsl_matrix_complex $A, num64 $beta, gsl_matrix_complex $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_ssyr2k(int32 $Uplo, int32 $TransA, num32 $alpha, gsl_matrix_float $A, gsl_matrix_float $B, num32 $beta, gsl_matrix_float $C --> int32) is native(LIB) is export(:level3) { * }
sub gsl_blas_dsyr2k(int32 $Uplo, int32 $TransA, num64 $alpha, gsl_matrix $A, gsl_matrix $B, num64 $beta, gsl_matrix $C --> int32) is native(LIB) is export(:level3) { * }
sub mgsl_blas_csyr2k(int32 $Uplo, int32 $TransA, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B, gsl_complex_float $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zsyr2k(int32 $Uplo, int32 $TransA, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B, gsl_complex $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_cher2k(int32 $Uplo, int32 $TransA, gsl_complex_float $alpha, gsl_matrix_complex_float $A, gsl_matrix_complex_float $B, num32 $beta, gsl_matrix_complex_float $C --> int32) is native(GSLHELPER) is export(:level3) { * }
sub mgsl_blas_zher2k(int32 $Uplo, int32 $TransA, gsl_complex $alpha, gsl_matrix_complex $A, gsl_matrix_complex $B, num64 $beta, gsl_matrix_complex $C --> int32) is native(GSLHELPER) is export(:level3) { * }
