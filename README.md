# Staff Directory

UC Libraries staff directory application. Manages employees and departments with Devise-based authentication.

**Stack:** Rails 8.1.2, Ruby 3.4.7, MySQL (development/production), SQLite (test). JavaScript via Shakapacker; styles via Sprockets and Sass.

---

## Requirements

- **Homebrew** (macOS)
- **Ruby 3.4.7** (e.g. [rbenv](https://github.com/rbenv/rbenv))
- **Rails 8.1.2** (installed via Bundler)
- **MySQL** (Homebrew on macOS)
- **zstd** (compression library, for mysql2 native extension)
- **Node.js** (version in [.nvmrc](.nvmrc), managed via [nvm](https://github.com/nvm-sh/nvm))
- **Yarn** (for JavaScript dependencies)

---

## Setup (macOS, Apple Silicon)

This project uses MySQL via the mysql2 gem. On macOS (especially Apple Silicon), extra steps may be needed so native extensions build correctly.

### 1. Install system dependencies

```bash
brew install mysql zstd
```

### 2. Ruby

```bash
rbenv install 3.4.7   # if not already installed
rbenv local 3.4.7
gem install bundler
```

Configure Bundler to build mysql2 correctly:

```bash
bundle config build.mysql2 --with-mysql-config=/opt/homebrew/opt/mysql/bin/mysql_config
```

### 3. Node.js

```bash
nvm install
nvm use
yarn install
```

### 4. Gems and database

```bash
bundle install
cp config/database.yml.example config/database.yml   # if needed; edit with your DB settings
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

### 5. Create a user (optional)

In the Rails console:

```bash
bundle exec rails console
```

```ruby
User.create!(
  email: 'yourname@uc.edu',
  password: 'securepassword',
  password_confirmation: 'securepassword'
)
```

---

## Running locally

Start MySQL (if not already running):

```bash
brew services start mysql
```

Start the Rails server:

```bash
bundle exec rails server
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

For live JavaScript/asset reload during development, in a second terminal:

```bash
bin/shakapacker-dev-server
```

---

## Running tests

```bash
bundle exec rspec
```

Test suite uses SQLite (see `config/database.yml` test configuration).

---

## Optional: nvm hook

To automatically switch to the correct Node version when entering the project directory, add this to your shell config (e.g. `.zshrc`):

```bash
# Auto-load node version from .nvmrc if present
autoload -U add-zsh-hook

load-nvmrc() {
  if nvm --version &> /dev/null; then
    if [ -f .nvmrc ]; then
      nvm use &> /dev/null
    fi
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

---

## Troubleshooting

**MySQL connection:** Ensure MySQL is running (`brew services start mysql`). The app expects a database and config as in `config/database.yml` (use `config/database.yml.example` as a template if the file is not committed).

**`Failed to build gem native extension` for mysql2:** Check that:

- `zstd` is installed (`brew install zstd`)
- You are using Ruby 3.4.7 (`rbenv local 3.4.7`)
- The Bundler mysql2 config points to your MySQL install (e.g. `bundle config build.mysql2 --with-mysql-config=/opt/homebrew/opt/mysql/bin/mysql_config` for Homebrew on Apple Silicon)

**Environment variables:** The app uses [dotenv-rails](https://github.com/bkeepers/dotenv). Copy or create `.env.development` and `.env.test` as needed (see existing examples in the repo if present).
