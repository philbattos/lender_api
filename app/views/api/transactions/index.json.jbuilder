json.open_transactions @open_transactions do |trans|
  json.id trans.id
  json.user User.find(trans.user_id).full_name
  json.peer_firstname User.find(trans.peer_id).firstname
  json.peer_fullname User.find(trans.peer_id).full_name
  json.amount number_to_currency(trans.amount)
  json.terms trans.terms
end
