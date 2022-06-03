Explore
===

<img src=./img/explore-app-icon.png width="128"> <img src=./img/explore_logo.png width="360">

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description
Explore is an iOS app that makes navigating college campuses simple, social, and fun! We’ve combined regular campus maps with GPS, so you can get instant directions to anything on campus. See where other students are visiting by scrolling through the social feed, and tap a single button for step by step directions there!

<img src='http://g.recordit.co/57GMdsOVix.gif' title='demo_1' alt='Sprint 3 & 4 Video Walkthrough' width=170>ㅤㅤ<img src='http://g.recordit.co/CKyF0E3n3l.gif' title='demo_2' alt='Sprint 3 & 4 Video Walkthrough' width=170>ㅤㅤ<img src='http://g.recordit.co/mAJgksip8E.gif' title='demo_4' alt='Sprint 3 & 4 Video Walkthrough' width=170>ㅤㅤ<img src='http://g.recordit.co/WKpu2H8se3.gif' title='demo_3' alt='Sprint 3 & 4 Video Walkthrough' width=170>

### App Evaluation
- **Category:** Navigation / Social Networking
- **Mobile:** This app is primarily intended to be used on mobile. Having a list of all services around campus is great for users on the go, because users can use the app on their phone to navigate to that location on campus. Scrolling functionality on the home feed is optimized for mobile devices, just like other apps where the user can quickly view and like each post. All of these features are able to be implemented on a computer, but the idea of the app is revolved around a sleek mobile interface.
- **Story:** When we were new to our university campus, we all had some difficulty navigating around campus for the first-couple of weeks. It wasn't easy finding the best study locations, food spots, leisure areas, and other services around campus. This app solves all the problems of new college students trying to familize themselves with their new enviornment. Current students will be able to share their favorite locations while discovering everything else the area has to offer. Not only does this app provide a clear directory of all services on campus, this app also includes the most up-to-date and top-rated locations on campus, uploaded by students alike.
- **Market:** Our market is the entire student base at the University at Buffalo's North Campus, with plans to expand to other universities. This consists of thousands of students looking for events or activities. For those users that are adventurous or curious about what events are happening around them, this app provides a great amount of value. It is a useful tool to stay updated.
- **Habit:** Users do not have to stay on the app for extended periods of time, so habit-forming is not too much of an issue. The app provides a quick service in finding a location or event, and users can freely share their favorite places around as much as they please.
- **Scope:** This app's difficulty comes in form of how much research needs to be done to correctly implement our required features. Understanding how to use an API to get coordinates and storing those locations may be a challenge, but research will alleviate some of the difficulty. Navigating through documentation of an unfamiliar framework will require diligence and patience, qualities that our team owns. A bare-bone version of this app is still fun and useful to design because it solves a problem that we all had when arriving to our college campus for the first time. We have clear objectives for this app already listed. We can proudly say that our final design has met those clear-cut goals.  

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* [X] User can view a list of service categories
* [X] User can select a service category and view a map of all locations of the service
* [X] User can tap on the service and get redirected to Apple Maps for real-time directions
* [X] User can view a feed of favorite locations uploaded by others
* [X] User can save the post to the 'Saved' screen
* [X] User can press 'Map' on a post to get redirected to Apple Maps for real-time directions
* [X] User can upload their own favorite location by filling out certain fields
* [X] User can login & logout
* [X] User stays logged in across app restarts
* [X] User can view liked posts
* [X] Establish brand identity with an app icon & logo

**Optional Nice-to-have Stories**
* [X] User can choose current location for location of uploaded post
* [X] User can use current location for services map
* [X] Infinite Scroll and Auto Refresh
* [X] Option to Auto-Fill Current Location Coordinates when uploading a post

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their liked posts
* Home Feed
    * Allows user to like other users' posts, and find directions to the location
    *  Post includes image, caption, like button, and directions button
    *  Includes upload button to direct user to Upload Screen
    *  Includes settings button to direct user to Settings Screen
* Specific Post Screen
    * Allows user to like and find location of image
    * Can scroll down to view similar posts of the same category
* Upload Screen
    * Allows user to upload image of spot
    * User will link specific location on the given map
* Services Screen
    * Select a service category to look for on campus
    * printing, food, parking, libraries, dorms
    * Selection will take user to Services Category Screen
* Services Category Screen
    * View the list of services of selected service category
    * Tapping on the list will direct user to a map screen
* Map Screen
    * User can view location of the selected service or post
* Liked Posts Screen
    * Displays the user's liked posts

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Services: Select a service category to look for on campus
* Feed: Posts from other users including a picture, caption, directions and like button are pushed to the screen
* Liked: Displays the user's liked posts

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Services -> Select from a list of services to find -> Map view centered on your location with waypoints of the service you selected -> Directions through Apple Maps app
* Feed (main page) -> See locations or events posted by other users. -> Upload a post by submitting a photo, title, description, location -> Post Screen enables user interaction Directions through Apple Maps to the location or event, and save post to "Liked" to view later.
* Liked -> View all your liked posts


## Wireframes

Hand-drawn mockup:

<img src=./img/wireframe.jpeg width="360">

First protoype displaying map "Services" functionality:

![](https://i.imgur.com/9AohS8o.gif)



## Schema 
### Models
Posts
| Property   | Type            | Description                   |
| ---------- | --------------- | ----------------------------- |
| objectID   | Sting           | unique ID for user post       |
| author     | Pointer to User | image author                  |
| image      | File            | image that user posts         |
| title      | String          | title of image by user        |
| description| String          | description of image by user  |
| likes      | User Relation   | list of posts liked by user   |
| category   | String          | category for type of image    |
| lat        | Double          | latitude of location in post  |
| long       | Double          | longitude of location in post |


### Networking
General
* Home Feed Screen
    * (Read/GET) Query all posts where user is author
* View Post Screen
    * (Read/GET) Query selected post
    * (Create/POST) Create a new like on a post
    * (Delete) Delete existing like
    * (Read/GET) Query all posts that match category of initial post
* Create Post Screen
    * (Create/POST) Create a new post object
* Profile Screen
    * (Read/GET) Query logged in user object
    * (Update/PUT) Update user profile image
* Printer Map View
    * (Read/GET) Query latitude and longitude from WEPA API
    * (Update/PUT) Query latitude and longitude from WEPA API

Wepa API 
* UB Printers URL - https://api.wepanow.com/resources/groups/23/kiosks
    * (Group ID to be replaced with UB Group ID)
    * URL from - https://api.wepanow.com/docs/kiosks.htm
