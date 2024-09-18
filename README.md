# staff-directory-23

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