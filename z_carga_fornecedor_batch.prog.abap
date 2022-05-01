*&---------------------------------------------------------------------*
*& Report Z_CARGA_FORNECEDOR_BATCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CARGA_FORNECEDOR_BATCH.
*TIPOS
TYPES: BEGIN OF TY_FILE,
         CODCT LIKE ZT0001-CODCT,
         DENOM LIKE ZT0001-DENOM,
       END OF TY_FILE.

*TABELAS INTERNAS
DATA: T_FILE TYPE STANDARD TABLE OF TY_FILE.

*WORKAREA
DATA: W_FILE TYPE TY_FILE.

*tela de seleção
PARAMETERS  P_FILE TYPE LOCALFILE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.
  PERFORM F_SELECIONA_FICHEIRO.

START-OF-SELECTION.
  PERFORM F_UPLOAD_FILE.
*&---------------------------------------------------------------------*
*& Form F_SELECIONA_FICHEIRO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM F_SELECIONA_FICHEIRO .
  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
*     PROGRAM_NAME        = SYST-REPID
*     DYNPRO_NUMBER       = SYST-DYNNR
      FIELD_NAME = P_FILE
*     STATIC     = ' '
*     MASK       = ' '
*     FILEOPERATION       = 'R'
*     PATH       =
    CHANGING
      FILE_NAME  = P_FILE
*     LOCATION_FLAG       = 'P'
* EXCEPTIONS
*     MASK_TOO_LONG       = 1
*     OTHERS     = 2
    .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_UPLOAD_FILE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM F_UPLOAD_FILE .

  DATA: VL_FILE TYPE STRING.
  VL_FILE = P_FILE.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      FILENAME                = VL_FILE
      FILETYPE                = 'ASC'
*     HAS_FIELD_SEPARATOR     = ' '
*     HEADER_LENGTH           = 0
*     READ_BY_LINE            = 'X'
*     DAT_MODE                = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     CHECK_BOM               = ' '
*     VIRUS_SCAN_PROFILE      =
*     NO_AUTH_CHECK           = ' '
* IMPORTING
*     FILELENGTH              =
*     HEADER                  =
    TABLES
      DATA_TAB                = T_FILE
* CHANGING
*     ISSCANPERFORMED         = ' '
    EXCEPTIONS
      FILE_OPEN_ERROR         = 1
      FILE_READ_ERROR         = 2
      NO_BATCH                = 3
      GUI_REFUSE_FILETRANSFER = 4
      INVALID_TYPE            = 5
      NO_AUTHORITY            = 6
      UNKNOWN_ERROR           = 7
      BAD_DATA_FORMAT         = 8
      HEADER_NOT_ALLOWED      = 9
      SEPARATOR_NOT_ALLOWED   = 10
      HEADER_TOO_LONG         = 11
      UNKNOWN_DP_ERROR        = 12
      ACCESS_DENIED           = 13
      DP_OUT_OF_MEMORY        = 14
      DISK_FULL               = 15
      DP_TIMEOUT              = 16
      OTHERS                  = 17.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
