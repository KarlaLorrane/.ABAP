report z_innerjoin.


tables: zt0002.

types: begin of ty_mater,
         matnr  like zt0002-matnr,
         denom  like zt0002-denom,
         codct  like zt0002-codct,
         orige  like zt0002-orige,
         valor  like zt0002-valor,
         waers  like zt0002-waers,
         codct1 like zt0001-codct,
         denom1 like zt0001-denom,
       end of ty_mater.

data t_mater type table of ty_mater.
data w_mater type ty_mater.

selection-screen begin of block b01 with frame title text-001.
select-options: s_codct for zt0002-codct,
                s_matnr for zt0002-matnr.
selection-screen end of block b01.

start-of-selection.
  perform f_seleciona_dados.
  perform f_imprime_dados.

form f_seleciona_dados .

  select zt0002~matnr zt0002~denom zt0002~codct zt0002~orige zt0002~valor zt0002~waers zt0001~codct zt0001~denom
    from zt0002
    inner join zt0001
    on zt0002~codct = zt0001~codct
    into table t_mater
    where zt0002~codct in s_codct
    and zt0002~matnr in s_matnr.

  if sy-subrc <> 0.
    message text-002 type 'I'.
    stop.
  endif.
endform.

form f_imprime_dados .
  loop at t_mater into w_mater.
    write:/ w_mater-matnr, w_mater-denom,w_mater-codct,w_mater-orige,w_mater-valor,w_mater-waers, w_mater-codct1,w_mater-denom1.
  endloop.
endform.
