# staff-directory-23

## Node version

This project uses [nvm](https://github.com/nvm-sh/nvm) to manage Node.js versions.

To use the correct version locally:

```bash
nvm install
nvm use
```


---

## ✅ Add a hook (optional)

To automatically load the correct node version when entering the directory, add this to your shell config:

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