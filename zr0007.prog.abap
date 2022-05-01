*&---------------------------------------------------------------------*
*& Report ZR0007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zr0007.
*Declaração de Tipos
types: begin of ty_material,
         codmat(10) type c,
         descr(35)  type c,
       end of ty_material.

*Declaração de estrutura (work area) (array)
*Nesse exemplo estamos declarando 2 estruturas, porém de mandeira diferente

data w_material type ty_material.

data: begin of w_cliente,
        codcli(10) type c,
        nome(35)   type c,
      end of w_cliente.


*Declaração de tabela interna
*tamanho 0, quer dizer indefinido

data t_material type table of ty_material.

data: begin of t_fornec occurs 0,
        codfor(10) type c,
        nome(35)   type c,
      end of t_fornec.

*A SAP inidca não declarar heaer liner por causa da Orientação a Objetos
*OOP não suporta a header line.
*O jeito mais correto é: DATA T_MATERIAL TYPE TABLE OF TY_MATERIAL.

*Inserindo registos na table interna (APPEND)
*Início - Exemplo APPEND tabela interna COM HEADER LINE
t_fornec-codfor = 'FORN-0001'.
t_fornec-nome = 'APPLE'.
append t_fornec.
* o comando clear limpa SOMENTE a HEADER LINE
* o comando refresh limpa TUDO.
clear t_fornec.

t_fornec-codfor = 'FORN-0002'.
t_fornec-nome = 'XIAOMI'.
append t_fornec.
*FIM - Exemplo APPEND com tabela interna COM HEADER LINE

*Início - Exemplo APPEND tabela interna COM HEADER LINE
w_material-codmat = 'MAT-001'.
w_material-descr = 'IPHONE 6'.
append w_material to t_material.

clear w_material.
*FIM - Exemplo APPEND com tabela interna SEM HEADER LINE

*LOOP Tabela interna com H.L.
loop at t_fornec where codfor = 'FORN-001'.
  write:/ t_fornec-codfor, t_fornec-nome, 'LOOP'.
endloop.

uline.
*LOOP Tabela interna SEM H.L.
loop at t_material into w_material.
  write:/ w_material-codmat, w_material-descr, 'LOOP'.
endloop.

*Utilizando o o comando Read Table
read table t_fornec index 2.
if sy-subrc = 0.
  write:/ t_fornec-codfor, t_fornec-nome, 'read'.
endif.

uline.

*Utilizando o comando MODIFY
loop at t_material into w_material.
  concatenate w_material-descr 'BRANCO' into w_material-descr separated by space.
  modify t_material from w_material transporting descr.
endloop.

loop at t_material into w_material.
  write:/ w_material-codmat, w_material-descr, 'MODIFY'.
endloop.
