# Taskboard

## Models

* User
  *	Member
  *	Admin
* List
* Card
* Comment

## Relations

* Single table Inheritance is done for admin and member model
* Admin can create many Lists(one-to-many)
* List has many memebers(added by admin) and members can belong to many lists(many-to-many)
* List has many Cards(one-to-many)
* Card has many Comments && Comments can have many comments(replies)(one-to-many with polymorphic relation on commentable)

## Api-endpoints

We have four controllers for each model
and all the endpoints for each controller is documented through apipie
so if you go to the root url - it will be redirected to the apipie documentation where one can refer the urls, request response for the api.

As of now it has been hosted in heroku cloud - https://taskboardv1.herokuapp.com

## Autherization

Here we use simple token based authentication to identify user.
Once a user sign-up using the credentials. Api responds with the authentication token to identify users uniquely 
Users can get this auth token by loging-in using user name and password and api responds back with auth token
Using this auth token in the header of the request user will be uniquely identified in the system.

## Application flow

once user login/ign-up api responds back with unique auth-token.
Using this auth-token based on the user type the user is recognised as an admin or member
Admins can only create a list and assign members to the list
Members and admin can create any number of cards in the list
List is accessible only by members or admin
Only admin is able to delete/modify the list
Members can comment on the cards created by other members
Members can also reply on the comments
