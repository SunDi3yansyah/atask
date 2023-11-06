# users
- name
- phone
- email
- password_digest

# user_wallets
- user:references
- assignable:references{polymorphic}
- in_out
- description
- 'amount:decimal{26,2}'
- 'total:decimal{26,2}'

# user_tokens
- user:references
- token
- refresh_token
- expired_at:datetime
- user_agent

# transfers
- from:bigint:index
- to:bigint:index
- code
- 'amount:decimal{26,2}'
- status

# withdrawals
- user:references
- code
- 'amount:decimal{26,2}'
- bank_name
- bank_account_number
- bank_account_name
- status
