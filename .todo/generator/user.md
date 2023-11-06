# SCAFFOLD (--no-migration --api --skip)
```
rails g scaffold App::User name phone email password_digest --no-migration --api --skip
rails g scaffold App::UserWallet user:references assignable:references{polymorphic} in_out description 'amount:decimal{26,2}' 'total:decimal{26,2}' --no-migration --api --skip
rails g scaffold App::UserToken user:references token refresh_token expired_at:datetime user_agent --no-migration --api --skip
rails g scaffold App::Transfer from:bigint:index to:bigint:index code 'amount:decimal{26,2}' status --no-migration --api --skip
rails g scaffold App::Withdrawal user:references code 'amount:decimal{26,2}' bank_name bank_account_number bank_account_name status --no-migration --api --skip
--- PENDING

```


# MODEL (--no-migration --skip)
```
rails g model App::Account::SignIn --no-migration --skip
--- PENDING

```


# CONTROLLER / SCAFFOLD CONTROLLER
```
rails g controller App::Account::SignIn create --routing-specs
--- PENDING

```


# MAILER
```

--- PENDING

```


# JOB
```

--- PENDING

```
