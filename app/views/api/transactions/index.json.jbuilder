json.open_transactions @open_transactions do |trans|
  json.id trans.id
  json.user trans.user.full_name
  json.peer_firstname trans.peer.firstname
  json.peer_fullname trans.peer.full_name
  json.amount number_to_currency(trans.amount)
  json.terms trans.terms
end
