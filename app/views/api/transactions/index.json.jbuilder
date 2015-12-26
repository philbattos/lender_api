json.transactions @transactions do |trans|
  json.user User.find(trans.user_id).full_name
  json.peer User.find(trans.peer_id).full_name
  json.amount number_to_currency(trans.amount)
  json.terms trans.terms
end
