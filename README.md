##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby 2.7.1
- Rails 6.0.3.2

##### 1. Check out the repository

```bash
git@github.com:luvcjssy/school_management.git
```

##### 2. Create database.yml file

Edit the database configuration as required.

```bash
config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000