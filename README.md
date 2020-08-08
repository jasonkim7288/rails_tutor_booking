<h1 align="center"> Tutor booking app
</h1>

# Table of Contents

* [A problem that needs solving](#A-problem-that-needs-solving)
* [Deployed app link](#Deployed-app-link)
* [GitHub repository link](#GitHub-repository-link)
* [Description](#Description)
* [User stories](#User-stories)
* [Wireframes](#Wireframes)
* [ERD](#ERD)
* [High-level components](#High-level-components)
* [Third party services](#Third-party-services)
* [Models](#Models)
* [Database relations](#Database-relaqtions)
* [Database schema design](#Database-schema-design)
<br /><br /><br />

# A problem that needs solving
Most of aspiring web/mobile developers have very little chance to present, lecture, or discuss about their own projects to the others whether it is online or offline. Finishing a project by themselves and not sharing anything with other developers will loose a good oppertunity which could have empowered their development and communication skills. Sometimes even learning programming language needs to be get lectured, discussed or helped by others.

[Go back](#table-of-contents)<br /><br /><br />

# Deployed app link

Deployed app link : https://devtutorbooking.herokuapp.com/

[Go back](#table-of-contents)<br /><br /><br />

# GitHub repository link

GitHub repository link :  https://github.com/jasonkim7288/rails_tutor_booking

[Go back](#table-of-contents)<br /><br /><br />

# Description

## Purpose
Tutor Booking app is a development tutor sessions booking app for any web/mobile developer or student to organize a session to have a presentation, give a lecture, or have a discussion with other students about their project or some programming language subject whether it is online or offline. These tutor sessions will make them help each other and become better developers.

## Functionality / features
Tutor Booking app is fully responsive from mobile to desktop and uses Google Maps API so that users can easily check out the place where the session will take place.
### Home page
The first screen when users enter this Tutor Booking App is the motto "Helping each other will make you great developers" which is the purpose of this app. There is a search field on the navbar which users can search tutor sessions by tutor's name, tutor's details, comments, tutor session's details. In the middle of the page, users can filter the tutor sessions list by their place type and category. At the bottom of this page, there will be 12 recent tuto sessions list.
### Tutor session detail page
On top of the tutor session detail page, there is a category for the current tutor session which is clickable and leads to the related filtered tutor sessions list. Users can check the title, description, the tutor's information, schedule, place or video conference URL, participants, the number of seats remained, etc. They are also able to create, edit, and delete comments on the current tutor session.

### Create/Edit tutor session page
All registered users can make their own tutor sessions and maintain them. The header image is fixed based on the category so that the tutors don't need to put too much time on making their own header image. If the tutor session is going to be online, video conference URL such as Zoom, Skype, Discord can be input. If it is a offline session, there is an easy way to input address where it takes place by autocomplete function and dynamic Google Map. Start and end date is automatically set to 9am to 5pm tomorrow,and easily changable.

### Sign up and Log in page
Simple card style sign up and log in pages make users feel free to join. If a user forgot his or her password, then reset password instruction will be sent through the user's email.

### Filtered and Searched sessions list page
Users can always find their suitable sessions by the search function on the navbar, filter selection on the main pate, or category selection on the tutor session detail page.

### Edit profile page
Once a user signs up, it will lead to the edit profile page. The user have 3 choices to have a profile icon. If the user didn't update his or her name on the edit profile page, the profile icon will refer to the email address and make email's initial-based icon. If the user updated his or her name, it will make name's initial-based icon. If the user uploaded image file, it will refer to the uploaded image. If the user updated his or her 'about me', other users can also search tutor sessions by this information.

## Sitemap
![](docs/TutorBookingSitemap.png)

## Screenshots
#### Home
![Screenshot for home](docs/screenshot_home.png)
#### Sign up
![Screenshot for sign up](docs/screenshot_sign_up.png)
#### Tutor session detail
![Screenshot for tutor session detail-1](docs/screenshot_tutor_session_detail_1.png)
![Screenshot for tutor session detail-2](docs/screenshot_tutor_session_detail_2.png)
#### Edit tutor session
![Screenshot for edit tutor session](docs/screenshot_edit_tutor_session.png)
#### Filtered sessions list
![Screenshot for filtered sessions list](docs/screenshot_filtered_sessions_list.png)
#### Edit profile
![Screenshot for edit profile](docs/screenshot_edit_profile.png)

## Target audience
Tutor Booking app is for any student who wants to be a web/mobile app developer and for any current web/mobile app developer who wants to help students.

## Tech stack
- Ruby on Rails : front end and back end source code
- Heroku : deploy the code
- Google Maps JavaScript API : display dynamic Google map on create, update, and show page of the tutor session
- Google Places API : address autocomplete function on create, update page of the tutor session
- Stimulus js : javascript in Rails to implement Google Maps API
- Stimulus Reflex : reactive web interface for the component-based page update to implement instant create, update, and delete of comments
- Bootstrap : css framework
- AWS S3 bucket : cloud service for the profile image upload
- tempusdominus-bootstrap-4 : dateTime picker package with bootstrap to manage start and end datetime of the tutor session
- Devise : authentication gem
- cancancan : authorization gem. All users including guests can read all the tutor sessons list. Registered users can create, edit, delete their own sessions only. Administrators can manage all tutor sessions no matter who made the tutor sessions.
- pg_search : PostgreSQL full text search gem to search the tutor sessions by tutor's name, tutor's details, comments, tutor session's details
- telephone_number : localized phone number verification gem

[Go back](#table-of-contents)<br /><br /><br />

# User stories
Dev Tutor Booking app helps developers organise online or offline meetings with small numbers of students so that they can improve their development skills by communicating and helping each other.


[Go back](#table-of-contents)<br /><br /><br />



# Wireframes
## for mobile (iPhone 8 plus)

Download <a href="docs/DevTutorBookingApp_Mobile.bmpr"> Balsamiq </a> or <a href="docs/DevTutorBookingApp-Mobile.pdf"> PDF </a> for checking the flow

![Wireframe for iPhon 8 plus](docs/Wireframe_mobile.png)

## for tablet (iPad)

Download <a href="docs/DevTutorBookingApp_Tablet.bmpr"> Balsamiq </a> or <a href="docs/DevTutorBookingApp-Tablet.pdf"> PDF </a> for checking the flow

![Wireframe for iPad pro](docs/Wireframe_tablet.png)

## for desktop

Download <a href="docs/DevTutorBookingApp_Desktop.bmpr"> Balsamiq </a> or <a href="docs/DevTutorBookingApp-Desktop.pdf"> PDF </a> for checking the flow

![Wireframe for desktop](docs/Wireframe_desktop.png)

[Go back](#table-of-contents)<br /><br /><br />

# ERD
![ERD](docs/ERD_DevTutorBooking.png)

[Go back](#table-of-contents)<br /><br /><br />

# High-level components


[Go back](#table-of-contents)<br /><br /><br />

# Third party services


[Go back](#table-of-contents)<br /><br /><br />

# Models


[Go back](#table-of-contents)<br /><br /><br />

# Database relations


[Go back](#table-of-contents)<br /><br /><br />

# Database schema design


[Go back](#table-of-contents)<br /><br /><br />
