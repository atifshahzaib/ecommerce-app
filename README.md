To use this project, you must have these requirements before running project:

- Ruby version: 3.1.1

- Rails version: 5.2.6

- Database: The Database used in this Project is 'PostgreSQL' having '14.1v' Version.

## Install Gems

Install these gems to fulfil prerequisites

```
gem 'bootstrap'
gem 'cloudinary'
gem 'devise'
gem 'jquery-rails'
gem 'pundit'
gem 'stripe'
gem 'faker'
```

## System dependencies:

In order to make this Application up and running, there are mostly built-in libraries used but one of the library is to be installed in the system for better utilization. It is 'ImageMagick' that should must be in your system.

## Configuration:

This whole project is already configured with its libraries but in order to start on your own, you have to use the `bundle install` command in order to install all the gems and libraries necessary for the application. Also, the ImageMagick can be installed with 'sudo apt install imagemagick' and it will be ready to use.

## Database initialization:

Once the application is installed and running on your computer, you might want to initialize the database using provided schema of the database, you have to run the `rails db:create db:migrate` command and it will make your database to the latest version and level as supposed by the Application. For this database, I have also used Seeds file for Fake Data for Products only just for two users having ID's 1 and 2. So, first of all, sign up two users and also confirm emails so that user will be verified. Now, you can use `rails db:seed` command to seed data for products.

