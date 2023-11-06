## CHANGELOG:
```
--- 1
rails g migration CreateUser name phone email password_digest
rails g migration CreateUserWallet user:references assignable:references{polymorphic} in_out description 'amount:decimal{26,2}' 'total:decimal{26,2}'
rails g migration CreateUserToken user:references token refresh_token expired_at:datetime user_agent
rails g migration CreateTransfer from:bigint:index to:bigint:index code 'amount:decimal{26,2}' status
rails g migration CreateWithdrawal user:references code 'amount:decimal{26,2}' bank_name bank_account_number bank_account_name status

```

### PENDING
```

```
