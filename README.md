# propile

Community Conference Program Compiler

## Running propile locally

This is adapted from https://github.com/agile-france/propile. But note that this repo's master branch is a fork of the master branch of https://github.com/rwestgeest/propile.

This assumes you are running UNIX-like operating system.

Setting up the database (SQLite) for development environment (DB file will be stored in file `data/development.sqlite3`):
```
RAILS_ENV=development bundle exec rake db:setup
```

Creating a account so you can log into propile:
1. start a rails console using the development environment:

    ```
    RAILS_ENV=development bundle exec rails console
    ```

1. in the rails console type the following commands

    ```
    email, pass = "your@email-address.xyz", "your password"
    me = Account.new
    me.maintainer = true
    me.email = email
    me.password = pass
    me.password_confirmation = pass
    me.confirmed_at = Time.now
    me.create_presenter
    me.save
    ```

1. exit the console with `exit`
1. start the server with `RAILS_ENV=development bundle exec rails server`
1. browser to `http://localhost:3000`
