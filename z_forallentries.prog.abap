*&---------------------------------------------------------------------*
*& Report Z_FORALLENTRIES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FORALLENTRIES.

*Tabela Transparente - tabela de BD.
TABLES: ZT0001.

*Tabelas internas - tempo de execução
DATA: T_ZT0001 TYPE TABLE OF ZT0001 WITH HEADER LINE,
      T_ZT0002 TYPE TABLE OF ZT0002 WITH HEADER LINE.

*Telas de Seleção
SELECT-OPTIONS: S_CODCT FOR ZT0001-CODCT,
                S_DENOM FOR ZT0001-DENOM.

*Inicio do Processamento
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
FORM F_SELECIONA_DADOS .

  SELECT * FROM ZT0001
    INTO TABLE T_ZT0001
    WHERE DENOM IN S_DENOM
    AND  CODCT IN S_CODCT.

  IF SY-SUBRC IS INITIAL. " IS INITIAL = 0 (as duas escritas são iguais)

    SELECT * FROM ZT0002 INTO TABLE  T_ZT0002
      FOR ALL ENTRIES IN T_ZT0001
      WHERE CODCT  = T_ZT0001-CODCT.
  ELSE.
    MESSAGE TEXT-001 TYPE 'I'."Não foramm encontrados registos para esse critério de seleção.
    STOP.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_IMPRIME_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM F_IMPRIME_DADOS .

  SORT T_ZT0002 BY CODCT.
  SORT T_ZT0001 BY CODCT.

  LOOP AT T_ZT0001.
    WRITE:/ T_ZT0001-DENOM,  T_ZT0001-CODCT.
    READ TABLE T_ZT0002 WITH KEY CODCT = T_ZT0001-CODCT BINARY SEARCH.
    IF SY-SUBRC IS INITIAL. " IS INITIAL = 0 (as duas escritas são iguais)
      WRITE: T_ZT0001-DENOM. "MESSAGE TEXT-002 TYPE 'I'.
    ENDIF.
  ENDLOOP.
ENDFORM.
