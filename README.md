# staff-directory-23
🛠 Development Setup (macOS, Apple Silicon)

This project uses MySQL via the mysql2 gem. On macOS (especially Apple Silicon), extra steps may be needed to ensure native extensions build correctly.
✅ Requirements

    Homebrew

    Ruby 3.3.3 (managed via rbenv)

    MySQL (installed via Homebrew)

    zstd (compression library)

🔧 Setup Steps

    Install dependencies:

"brew install mysql zstd"

Make sure Ruby 3.3.3 is selected:

"rbenv install 3.3.3" # if not already installed
"rbenv local 3.3.3"

Install bundler (if not already):

"gem install bundler"

Configure Bundler to build mysql2 correctly:

"bundle config build.mysql2 --with-mysql-config=/opt/homebrew/opt/mysql/bin/mysql_config"

Install gems:

"bundle install"

Start the Rails server:

    bundle exec rails server

🧠 Notes

    You must run MySQL locally for Rails to connect. You can start it via:

    "brew services start mysql"

    If you see ERROR: Failed to build gem native extension for mysql2, recheck that:

        zstd is installed

        You're using Ruby 3.3.3

        You're passing the correct --with-mysql-config path

------------------------------


Run Locally:
To run the set up app locally, use the following commands:

```
bundle install
rails db:migrate
rails db:seed
```

Then, add yourself as a user by doing the following:

```
rails console
```

Then, in the console, type the following:
```
User.create(email:'yourname@uc.edu',password:'securepassword',password_confirmation:'securepassword')
```

You can then start the server with the following command:

```
rails server
```
Then, navigate to `http://localhost:3000` in your web browser.
