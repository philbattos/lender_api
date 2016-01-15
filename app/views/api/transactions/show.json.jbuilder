json.transaction do
  json.id @transaction.id
  json.user @transaction.user.full_name
  json.peer_firstname @transaction.peer.firstname
  json.peer_fullname @transaction.peer.full_name
  json.amount number_to_currency(@transaction.amount)
  json.terms @transaction.terms
  json.state @transaction.aasm_state
end