json.transaction do
  json.id @transaction.id
  json.user @transaction.user.full_name
  json.peer_firstname @transaction.peer.firstname
  json.peer_fullname @transaction.peer.full_name
  json.amount number_to_currency(@transaction.amount)
  json.terms number_to_percentage(@transaction.terms, precision: 0)
  json.state @transaction.aasm_state
  json.accrued_interest number_to_currency(@transaction.accrued_interest)
  json.balance number_to_currency(@transaction.balance)
  json.days_since_lending time_ago_in_words(@transaction.created_at) + ' ago'
end