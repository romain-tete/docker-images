# MySQL Database setup

Requirements:

- The database this connects to must allow remote connections

What this image does :

- Runs until completion
- This sets up a database, a user and grants the created user all privileges on that database
- If the database and user already exists, update the user password
- It waits for the database readiness (sleep 3s and tries again until successful, loops forever if something is misconfigured)

Expected secrets:

- root_password: the password to connect as root
- user_password: the password to set for the created user

Expected environment variables:

- DB_NAME: the name of the database to be created (it will also be the name of the created user)
- DB_HOST: the host to connect to the database with
