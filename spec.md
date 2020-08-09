# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
The app is using Sinatra.
- [x] Use ActiveRecord for storing information in a database
The app is using active record.
- [x] Include more than one model class (e.g. User, Post, Category)
The project includeds a goal model, a logs model a points model and a users model.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
The users model has many logs and has one goal
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
The logs model belongs to the users model and the goals model belongs to the users model.
- [x] Include user accounts with unique login attribute (username or email)
The user logs in with a username and password.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
The models have crud
- [x] Ensure that users can't modify content created by other users
The project has security in place to ensure that only logged in and authenticated users can crud thier own content.
- [x] Include user input validations
The project includes manual validations, but does not utilize validation within active record.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
The project has messaging for all validations and user actions.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
I have a large number of Git commits.
- [x] Your commit messages are meaningful
Comment message are aligned to commites
- [x] You made the changes in a commit that relate to the commit message
There were some commits in the beginning of the project where I forgot to make commits while solving some large problems so there are commits that are very large and aren't 100% details.  For the most part this is done.
- [x] You don't include changes in a commit that aren't related to the commit message
There were some commits in the beginning of the project where I forgot to make commits while solving some large problems so there are commits that are very large and aren't 100% details.  For the most part this is done.
