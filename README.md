# README

This document describes how to run and test the application locally in development mode and in production mode.

* Firstly, If you encounter any trouble in getting it up and running locally then please use the following link to test it in production mode
    
    * <a target="blank" href="https://user-registration-application.herokuapp.com/">user-registration-application</a>
    * Make sure that the emails you use for succesful sign ups have mailboxes or else the emails will bounce which would hurt my IP's reputation.
    * check your junk/spam folder if you do not receive notification emails to your inbox.
    
* Feature Description:

    * As a user, You can visit sign up page and sign up with my email (with valid format and unique in database) and password (with confirmation and at least eight characters).
    * When You sign up successfully, You would see my profile page.
    * When You sign up successfully, You would receive a welcome email.
    * When You sign up incorrectly, You would see error message in sign up page.
    * As a user, You can edit my username and password in profile page. You can also see my email in the page but You can not edit it.
    * When You first time entering the page, my username would be my email prefixing, e.g. (email is “user@example.com” , username would be “user”)
    * When You edit my username, it should contain at least five characters. (Default username does not has this limitation)
    * As a user, You can log out the system.
    * When You log out, You would see the login page.
    * As a user, You can visit login page and login with my email and password.
    * As a user, You can visit login page and click “forgot password” if You forgot my password.
    * When You visit forgot password page, You can fill my email and ask the system to send reset password email.
    * As a user, You can visit reset password page from the link inside reset password email and reset my password (with confirmation and at least eight characters). The link should be unique and only valid within six hours.

* Ruby version - 2.6.3

    * Make sure ruby is installed on your computer. If it is a mac then the OS comes with a pre installed ruby version.

* Rails version - 5.1.7

* Clone this repository to your local hard disk by downloading the zip folder

    * After unzipping the folder cd into the application folder from your terminal.
    
        * cd '/your_downloads_path/user_registration_app-master'

* Gem installation and database.

    * Make sure Postgres is installed on your computer and run the following commands from the root folder:
        * gem install bundler
        * bundle install
        * brew services start postgresql (for mac)
        * bundle exec rake db:create
        * bundle exec rake db:migrate
     
* Routes available
    * /
    * /signup
    * /login
    * /forgot_password

* To look at all available REST end points
    * rake routes
  
* Running the application (development mode)
    * Make sure you are in the project root folder and use the following command from your terminal to start the server.
        * rails s
    * Once the server is up and running open your browser (preferably chrome) and type in the following url.
        * http://localhost:3000/
    * links to the signup page and login page are available on the home page and link to forgot password can be found on the login page. In addition to this you can use the following urls to visit those pages:
        * http://localhost:3000/signup
        * http://localhost:3000/login
        * http://localhost:3000/forgot_password
    * On the forgot password page provide an email to request for a password reset email. It checks whether the email exists in the database(If the user signed up successfully in the application) and opens the message that is supposed to be sent to that email address in a new tab.
    * Click on the link from the email and it redirects you to the password reset page where you can set up a new password for your account.
    * This page will also display username field if the default username is less than 5 characters and you will also have to update your username along with setting a new password.

* How to run the test suite
    * Make sure you are in the project root folder and use the following command to run all the tests:
        * rake test
    * Run the following commands for running individual tests for controllers and models.
        * rails test test/controllers/users_controller_test.rb
        * rails test test/controllers/sessions_controller_test.rb
        * rails test test/models/user_test.rb