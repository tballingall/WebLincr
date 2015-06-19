# README

Weblincr is a Hello World app meant to help developers new to rails learn. This repo (once finished) will contain all the example code.

There are 13 steps to the exercise - each step will have one branch in this repo:

## I can view the homepage (branch: 01-homepage)

##### As a non-credentialed user I can visit the homepage

## I can create a new account (branch: 02-user-account)

##### As a non-credentialed user, providing valid information, I can create a new account.
##### As a non-credentialed user, providing invalid information, I can see errors.

## I can authenticate (branch: 03-authentication)

##### As a non-credentialed user, providing valid information, I can authenticate as a user of collections
- Confirmation will be show on the page
- A Logout link will be shown on page
- A Register link will not be shown on the page
- A Login link will not be shown on the page

##### As a non-credentialed user, providing invalid information, I can see errors.
- Error messages will be shown on the page
- A Logout link will not be shown on page
- A Register link will be shown on the page
- A Login link will be shown on the page

##### As a credentialed user I can log out
- Confirmation will be show on the page
- A Logout link will not be shown on page
- A Register link will be shown on the page
- A Login link will be shown on the page

## I can edit my own information (branch: 04-user-account)

##### As an guest I can not edit user information

##### As an authenticated user I can edit my own information

##### As an authenticated user I can not edit other user's information
- I should not see an edit link for other users
- I should not be able to put user data for other users

## I can view a list of users (branch: 05-user-list)

##### As a non-credentialed user I can view a list of users
- List should be paginated.
- I can click the user's name to view a user profile page

## I can add an avatar to my user profile page (branch: 06-avatar)
##### As a non-authenticated user creating an account I can upload a picture for use as an avatar.
##### As an authenticated user updating my account I can upload a picture for use as an avatar

## I can add a new image collection (branch: 07-albums)
##### As an authenticated user a can add a new image collection to my account
- A link to this image collection will appear on my user profile page
- I can edit information for my image collection
- I can not edit information for the image collection for others

## I can add an image to an collection in my profile (branch: 08-photos)
##### As an authenticated user with a collection I can add an image to that collection
- The first image added to the collection will be designated as the 'primary' image
- The primary image will accompany the link to the collection on my user profile page
- I can designate any image as the primary image for it's collection - replacing the default
- Images will include a field for 'year' for the year the image was taken as a dropdown selection
- Images will include a field for 'color' to designate the primary color in the image
- Images will include a field for a text description

## The system will have Admin users (branch: 09-admins)
##### There will be no UI for this - just a flag on user accounts.
- Admin users can edit any other user's information
- Admin users will be flagged as such on their user profile page


## As a system admin I can moderate images (branch: 10-review)
##### As an authenticated system admin I can view a list of images to review

- This list is chronological without regard for collections
- This list should be paginated
- Selecting an image from the list will change the image to a "flagged" state -- The user should be notified that the image was flagged -- The image will appear grayed out to users who don't own the image -- The image will appear to the user who owns it with a notice that the image is flagged

## I can like other people's photos (branch: 11-liking)
##### As an authenticated user I can like another user's photo
##### As an authenticated user I can not like another user's photo
- My liked photos show on my profile page
- I can not like my own photos

## Picture lists (branch: 12-photo-lists)
##### As a user I can view a list of all users pictures and filter that list by 'liked', color, and/or year

## Switch to MongoDB (branch: 13-mongoid)
##### Rebuild model layer on Mongoid instead of ActiveRecord
