# staff-directory-23

## Prerequisites
```
current version of NVM
Node 20.14.0
Ruby Version 3.3.3
SQLite 3
```

## Node Version Management

This project uses nvm (Node Version Manager) to manage Node.js versions. The `.nvmrc` file is
configured to use Node version 20.14.0.

When running locally, you will need to set the node version with `nvm use` as described below under "Installation".  
For deployment, the `.nvmrc` file will be used to set the node version and the deployment script will automatically
use the correct version.

## Installing
1. Clone the repository: `git clone https://github.com/uclibs/staff-directory-23.git ./path/to/local`
1. Change to the application's directory: e.g. `cd ./path/to/local`
1. Make sure you are on the qa branch: `git checkout qa`
1. Install the node version listed in .nvmrc: `nvm install`
1. Direct to the correct node version listed in .nvmrc: `nvm use`
1. Install bundler (if needed): `gem install bundler`
1. Run bundler: `bundle install`
1. Run the database migrations: `bundle exec rails db:migrate`
1. To include the colleges at UC, seed the database: `bundle exec rails db:seed`
1. Then, add yourself as a user by doing the following:

```
rails console
```

Then, in the console, type the following:
```
User.create(email:'yourname@uc.edu',password:'securepassword',password_confirmation:'securepassword')
```

1. Start the rails server: `bundle exec rails server`
1. Visit the site at [http://localhost:3000] (http://localhost:3000)

## Running the tests
1. Run the database migrations if you haven't already: ```bundle exec rails db:migrate```
1. Run the test suite: ```bundle exec rspec```

## Note on Dependency Management
While this repository includes a yarn.lock file, you do not need to run yarn install or yarn build
to use the program.  The application is fully operational with bundle install alone, which manages
all necessary Ruby dependencies.