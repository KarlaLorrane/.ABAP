*&---------------------------------------------------------------------*
*& Report Z_PAISES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PAISES.

*Tabela Transparente
TABLES T005T. "Country Names

*Tela de Seleção

PARAMETERS P_SPRAS LIKE T005T-SPRAS DEFAULT 'EN'.
ULINE (30).
WRITE: /01 '|',
        02 'País',
        07 '|',
        08 'Denominação',
        30 '|'.
ULINE /(30).

SELECT * FROM T005T WHERE SPRAS = P_SPRAS.
WRITE: /01 '|',
        02 T005T-LAND1,
        07 '|',
        08 T005T-LANDX,
        30 '|'.
ULINE /(30).

ENDSELECT.
