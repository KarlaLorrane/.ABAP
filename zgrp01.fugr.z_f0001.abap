FUNCTION Z_F0001.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(NUMERO1) TYPE  I
*"     REFERENCE(NUMERO2) TYPE  I
*"     REFERENCE(OPERACAO) TYPE  C
*"  EXPORTING
*"     REFERENCE(RESULTADO) TYPE  I
*"  EXCEPTIONS
*"      INV_OPERADOR
*"      DIVI_ZERO
*"----------------------------------------------------------------------
CLEAR RESULTADO.
*Validação divisão por zero.
IF OPERACAO = '/' AND NUMERO2 = '0'.
  RAISE DIVI_ZERO.
ENDIF.

CASE OPERACAO.
  WHEN '+'.
    RESULTADO = NUMERO1 + NUMERO2.
  WHEN '-'.
    RESULTADO = NUMERO1 - NUMERO2.
  WHEN '*'.
    RESULTADO = NUMERO1 * NUMERO2.
  WHEN '/'.
    RESULTADO = NUMERO1 / NUMERO2.
   WHEN OTHERS.
     RAISE INV_OPERADOR.

ENDCASE.


ENDFUNCTION.
