*&---------------------------------------------------------------------*
*& Report Z_PAISES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PAISES_2.

*Tabela Transparente
TABLES T005T. "Country Names

*Tabela Interna
DATA: T_T005T TYPE TABLE OF T005T WITH HEADER LINE.

*Tela de Seleção

PARAMETERS P_SPRAS LIKE T005T-SPRAS DEFAULT 'EN'.
ULINE (30).
WRITE: /01 '|',
        02 'País',
        07 '|',
        08 'Denominação',
        30 '|'.
ULINE /(30).

SELECT * FROM T005T INTO TABLE T_T005T WHERE SPRAS = P_SPRAS.
  LOOP AT T_T005T.
WRITE: /01 '|',
        02 T_T005T-LAND1,
        07 '|',
        08 T_T005T-LANDX,
        30 '|'.
ULINE /(30).
ENDLOOP.
