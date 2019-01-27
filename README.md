#Taskboard

##Models

* User
**	Member
**	Admin
* List
* Card
* Comment

##Relations

Single table Inheritance is done for admin and member model
Admin can create many Lists(one-to-many)
List has many memebers(added by admin) and members can belong to many lists(many-to-many)
List has many Cards(one-to-many)
Card has many Comments && Comments can have many comments(replies)(one-to-many with polymorphic relation on commentable)

##Api-endpoints

We have four controllers for each model
and all the endpoints for each controller is documented through apipie
so if you go to the root url - it will be redirected to the apipie documentation where one can refer the urls, request response for the api.

As of now it has been hosted in heroku cloud - https://taskboardv1.herokuapp.com
