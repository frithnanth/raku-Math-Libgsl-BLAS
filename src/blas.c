#include <gsl/gsl_complex.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_blas.h>

/* Level 1 */
int mgsl_blas_caxpy(gsl_complex_float *alpha, gsl_vector_complex_float *x, gsl_vector_complex_float *y)
{
  return gsl_blas_caxpy(*alpha, x, y);
}

int mgsl_blas_zaxpy(gsl_complex *alpha, gsl_vector_complex *x, gsl_vector_complex *y)
{
  return gsl_blas_zaxpy(*alpha, x, y);
}

void mgsl_blas_cscal(gsl_complex_float *alpha, gsl_vector_complex_float *x)
{
  gsl_blas_cscal(*alpha, x);
}

void mgsl_blas_zscal(gsl_complex *alpha, gsl_vector_complex *x)
{
  gsl_blas_zscal(*alpha, x);
}

/* Level 2 */
int mgsl_blas_cgemv(CBLAS_TRANSPOSE_t TransA, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_vector_complex_float *x, gsl_complex_float *beta, gsl_vector_complex_float *y)
{
  return gsl_blas_cgemv(TransA, *alpha, A, x, *beta, y);
}

int mgsl_blas_zgemv(CBLAS_TRANSPOSE_t TransA, gsl_complex *alpha, gsl_matrix_complex *A, gsl_vector_complex *x, gsl_complex *beta, gsl_vector_complex *y)
{
  return gsl_blas_zgemv(TransA, *alpha, A, x, *beta, y);
}

int mgsl_blas_chemv(CBLAS_UPLO_t Uplo, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_vector_complex_float *x, gsl_complex_float *beta, gsl_vector_complex_float *y)
{
  return gsl_blas_chemv(Uplo, *alpha, A, x, *beta, y);
}

int mgsl_blas_zhemv(CBLAS_UPLO_t Uplo, gsl_complex *alpha, gsl_matrix_complex *A, gsl_vector_complex *x, gsl_complex *beta, gsl_vector_complex *y)
{
  return gsl_blas_zhemv(Uplo, *alpha, A, x, *beta, y);
}

int mgsl_blas_cgeru(gsl_complex_float *alpha, gsl_vector_complex_float *x, gsl_vector_complex_float *y, gsl_matrix_complex_float *A)
{
  return gsl_blas_cgeru(*alpha, x, y, A);
}

int mgsl_blas_zgeru(gsl_complex *alpha, gsl_vector_complex *x, gsl_vector_complex *y, gsl_matrix_complex *A)
{
  return gsl_blas_zgeru(*alpha, x, y, A);
}

int mgsl_blas_cgerc(gsl_complex_float *alpha, gsl_vector_complex_float *x, gsl_vector_complex_float *y, gsl_matrix_complex_float *A)
{
  return gsl_blas_cgerc(*alpha, x, y, A);
}

int mgsl_blas_zgerc(gsl_complex *alpha, gsl_vector_complex *x, gsl_vector_complex *y, gsl_matrix_complex *A)
{
  return gsl_blas_zgerc(*alpha, x, y, A);
}

int mgsl_blas_cher2(CBLAS_UPLO_t Uplo, gsl_complex_float *alpha, gsl_vector_complex_float *x, gsl_vector_complex_float *y, gsl_matrix_complex_float *A)
{
  return gsl_blas_cher2(Uplo, *alpha, x, y, A);
}

int mgsl_blas_zher2(CBLAS_UPLO_t Uplo, gsl_complex *alpha, gsl_vector_complex *x, gsl_vector_complex *y, gsl_matrix_complex *A)
{
  return gsl_blas_zher2(Uplo, *alpha, x, y, A);
}

int mgsl_blas_cgemm(CBLAS_TRANSPOSE_t TransA, CBLAS_TRANSPOSE_t TransB, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B, gsl_complex_float *beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_cgemm(TransA, TransB, *alpha, A, B, *beta, C);
}

int mgsl_blas_zgemm(CBLAS_TRANSPOSE_t TransA, CBLAS_TRANSPOSE_t TransB, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B, gsl_complex *beta, gsl_matrix_complex *C)
{
  return gsl_blas_zgemm(TransA, TransB, *alpha, A, B, *beta, C);
}

int mgsl_blas_csymm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B, gsl_complex_float *beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_csymm(Side, Uplo, *alpha, A, B, *beta, C);
}

int mgsl_blas_zsymm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B, gsl_complex *beta, gsl_matrix_complex *C)
{
  return gsl_blas_zsymm(Side, Uplo, *alpha, A, B, *beta, C);
}

int mgsl_blas_chemm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B, gsl_complex_float *beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_chemm(Side, Uplo, *alpha, A, B, *beta, C);
}

int mgsl_blas_zhemm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B, gsl_complex *beta, gsl_matrix_complex *C)
{
  return gsl_blas_zhemm(Side, Uplo, *alpha, A, B, *beta, C);
}

int mgsl_blas_ctrmm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, CBLAS_DIAG_t Diag, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B)
{
  return gsl_blas_ctrmm(Side, Uplo, TransA, Diag, *alpha, A, B);
}

int mgsl_blas_ztrmm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, CBLAS_DIAG_t Diag, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B)
{
  return gsl_blas_ztrmm(Side, Uplo, TransA, Diag, *alpha, A, B);
}

int mgsl_blas_ctrsm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, CBLAS_DIAG_t Diag, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B)
{
  return gsl_blas_ctrsm(Side, Uplo, TransA, Diag, *alpha, A, B);
}

int mgsl_blas_ztrsm(CBLAS_SIDE_t Side, CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, CBLAS_DIAG_t Diag, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B)
{
  return gsl_blas_ztrsm(Side, Uplo, TransA, Diag, *alpha, A, B);
}

int mgsl_blas_csyrk(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_complex_float *beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_csyrk(Uplo, TransA, *alpha, A, *beta, C);
}

int mgsl_blas_zsyrk(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex *alpha, gsl_matrix_complex *A, gsl_complex *beta, gsl_matrix_complex *C)
{
  return gsl_blas_zsyrk(Uplo, TransA, *alpha, A, *beta, C);
}

int mgsl_blas_csyr2k(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B, gsl_complex_float *beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_csyr2k(Uplo, TransA, *alpha, A, B, *beta, C);
}

int mgsl_blas_zsyr2k(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B, gsl_complex *beta, gsl_matrix_complex *C)
{
  return gsl_blas_zsyr2k(Uplo, TransA, *alpha, A, B, *beta, C);
}

int mgsl_blas_cher2k(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex_float *alpha, gsl_matrix_complex_float *A, gsl_matrix_complex_float *B, float beta, gsl_matrix_complex_float *C)
{
  return gsl_blas_cher2k(Uplo, TransA, *alpha, A, B, beta, C);
}

int mgsl_blas_zher2k(CBLAS_UPLO_t Uplo, CBLAS_TRANSPOSE_t TransA, gsl_complex *alpha, gsl_matrix_complex *A, gsl_matrix_complex *B, double beta, gsl_matrix_complex *C)
{
  return gsl_blas_zher2k(Uplo, TransA, *alpha, A, B, beta, C);
}
