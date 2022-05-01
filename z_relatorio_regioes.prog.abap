*&---------------------------------------------------------------------*
*& Report Z_RELATORIO_REGIOES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_RELATORIO_REGIOES.

*Tabela Transparente
TABLES T005U.

*Tabela interna
DATA: BEGIN OF T_T005U OCCURS 0,
  LAND1 LIKE T005U-LAND1,
  BLAND LIKE T005U-BLAND,
  BEZEI LIKE T005U-BEZEI,
 END OF T_T005U.


*Tela de Seleção
SELECTION-SCREEN BEGIN OF BLOCK B01 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: S_LAND1 FOR T005U-LAND1,
                S_BLAND FOR T005U-BLAND.
SELECTION-SCREEN END OF BLOCK B01.

SELECTION-SCREEN BEGIN OF BLOCK B02 WITH FRAME TITLE TEXT-002.
PARAMETERS : P_SPRAS LIKE T005U-SPRAS.
SELECTION-SCREEN END OF BLOCK B02.

*eventos
INITIALIZATION.
  S_LAND1-LOW ='BR'.
  S_LAND1-SIGN ='I'.
  S_LAND1-OPTION ='EQ'.
  APPEND S_LAND1. CLEAR S_LAND1.

TOP-OF-PAGE.
PERFORM F_IMPRIME_CABECDOC.
START-OF-SELECTION.

PERFORM F_SELECIONA_DADOS.

PERFORM F_IMPRIME_DADOS.


*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_seleciona_dados .

*Rotina de Seleção
SELECT LAND1 BLAND BEZEI
  FROM T005U
  INTO TABLE  T_T005U
  WHERE LAND1 IN S_LAND1
  AND BLAND IN S_BLAND
  AND SPRAS = P_SPRAS.

  IF SY-SUBRC <> 0.
    MESSAGE TEXT-003 TYPE 'I'. "Não Encontrado Registos
    STOP.
    ENDIF.
endform.
*&---------------------------------------------------------------------*
*& Form F_IMPRIME_CABECDOC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_imprime_cabecdoc .
    FORMAT COLOR 1.
    ULINE /(15).
    WRITE: /1 '|',
            2 'País',
            7 '|',
            8 'Região',
            14 '|',
            15 'Denominação',
            35 '|'.
    ULINE /(35).

    FORMAT RESET.

endform.
*&---------------------------------------------------------------------*
*& Form F_IMPRIME_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
form f_imprime_dados .
    LOOP AT T_T005U.
          WRITE: /1 '|',
            2 T_T005U-LAND1,
            7 '|',
            8 T_T005U-BLAND,
            14 '|',
            15 T_T005U-BEZEI,
            35 '|'.
           ULINE /(35).
      ENDLOOP.

endform.
