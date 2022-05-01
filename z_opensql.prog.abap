*&---------------------------------------------------------------------*
*& Report Z_OPENSQL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report z_opensql.
*tabelas transparentes

tables zt0001.
parameters: p_codct  like zt0001-codct obligatory,
            p_denom  like zt0001-denom obligatory,
            p_insert radiobutton group gr1,
            p_update radiobutton group gr1,
            p_modify radiobutton group gr1,
            p_delete radiobutton group gr1.

*Exemplo comando INSERT
if p_insert = 'X'.
  clear zt0001.
  zt0001-codct = p_codct.
  zt0001-denom = p_denom.
  insert zt0001.

  if sy-subrc = 0.
    commit work.
    message 'Registo cadastrado com sucesso' type 'S'.
  else.
    rollback work.
    message 'Erro no cadastro.' type 'I'.
  endif.

*Exemplo comando UPDATE
elseif p_update = 'X'.

  update zt0001
  set denom = p_denom
  where codct = p_codct.
  if sy-subrc = 0.
    commit work.
    message 'Registo atualizado com sucesso' type 'S'.
  else.
    rollback work.
    message 'Erro na atualização.' type 'I'.
  endif.

*Exemplo comando MODIFY
elseif p_modify = 'X'.
  clear zt0001.
  zt0001-codct = p_codct.
  zt0001-denom = p_denom.
  modify zt0001.

  if sy-subrc = 0.
    commit work.
    message 'Processo realizado com sucesso' type 'S'.
  else.
    rollback work.
    message 'Erro no processamento.' type 'I'.
  endif.

*Exemplo comando DELETE
*Aqui usei o codct porque cadastrei um errado lol
elseif p_delete = 'X'.
  DELETE FROM ZT0001 WHERE codct = P_codct.
    if sy-subrc = 0.
    commit work.
    message 'Processo realizado com sucesso' type 'S'.
  else.
    rollback work.
    message 'Erro no processamento.' type 'I'.
  endif.

endif.
