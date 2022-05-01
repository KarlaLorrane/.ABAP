*&---------------------------------------------------------------------*
*& Report Z_CALCULATOR_FUNC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CALCULATOR_FUNC.
*Declaração de Variáveis

DATA: V_RESUL TYPE I.

*Tela de seleção
PARAMETERS:   P_NUM1 TYPE I,
              P_NUM2 TYPE I,
              P_OPER TYPE C.
*Eventos
START-OF-SELECTION.
PERFORM F_EXECUTA_CALCULO.
PERFORM F_IMPRIME_RESULTADO.



*&---------------------------------------------------------------------*
*& Form F_EXECUTA_CALCULO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_executa_calculo .


call function 'Z_F0001'
  exporting
    numero1            = P_NUM1
    numero2            = P_NUM2
    operacao           = P_OPER
 IMPORTING
   RESULTADO          = V_RESUL
 EXCEPTIONS
   INV_OPERADOR       = 1
   DIVI_ZERO          = 2
   OTHERS             = 3.
  if sy-subrc <> 0.

 if sy-subrc = 1.
MESSAGE TEXT-001 TYPE 'I'.
STOP.

ELSEIF sy-subrc = 2.
MESSAGE TEXT-002 TYPE 'I'.
STOP.

ELSE.
   sy-subrc = 3.
MESSAGE TEXT-003 TYPE 'I'.
STOP.
  endif.

  endif.



endform.
*&---------------------------------------------------------------------*
*& Form F_IMPRIME_RESULTADO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_imprime_resultado .
WRITE: TEXT-004, V_RESUL.
endform.
