# Postgresql setup 
After installation run this command:
```bash
sudo su - postgres -c "initdb -D /var/lib/postgres/data"
```
This sets up necessary files and folders for Postgresql to run

Then start and enable postgresql.service
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

## TO access PostgreSQL
```bash
sudo -iu postgres
psql
\q # to exit psql
exit # exit from the posgres user
```

### Create database and user
```bash
-- Create a database
CREATE DATABASE yourdbname;

-- Create a user
CREATE USER yourusername WITH PASSWORD 'yourpassword';

-- Give user access to the database
GRANT ALL PRIVILEGES ON DATABASE yourdbname TO yourusername;
```

### Allow password authentication for apps(django,etc)
```bash
sudo nvim /var/lib/postgres/data/pg_hba.conf

```
> [!IMPORTANT]
>Configure PostgreSQL to use md5 password authentication in the pg_hba.conf file. 
>    This is necessary if you want to enable remote connections :
>copy and paste the below in the file pg_hba.conf or replace with md5
>```bash
># "local" is for Unix domain socket connections only
>local   all             all                                     md5 
># IPv4 local connections:
>host    all             all             127.0.0.1/32            md5
># IPv6 local connections:
>host    all             all             ::1/128                 md5
>
># always restart after this change
>sudo systemctl restart postgresql.service
>```

# Run after successful
```bash
sudo psql -U <username> -d <database_name> -h 127.0.0.1
```

### For git commit:
feat: A new feature
feat: Add user profile page
fix: A bug fix
fix: Stop cart from crashing on empty checkout
docs: Documentation changes
docs: Update README with install steps
style: Code style tweaks (formatting, etc.)
style: Reformat CSS with Prettier
refactor: Rewriting code without changing how it works
refactor: Clean up login function
test: Adding or changing tests
test: Add tests for signup form
chore: Routine tasks (like updating tools)
chore: Bump Python to 3.11
