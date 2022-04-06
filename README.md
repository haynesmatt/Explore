UB Explore
===

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Navigate, share, and discover with UB Explore. Easily find your way around UB with a directory of essential services on and off campus. Share your favorite spots around UB with posts and its location. Discover new areas around campus with other students' posts.

### App Evaluation
- **Category:** Navigation / Social Networking
- **Mobile:** This app is primarily intended to be used on mobile. Having a list of all services around UB is great for users on the go, because users can use the app on their phone to navigate to that location on campus. Scrolling functionality on the home feed is optimized for mobile devices, just like other apps where the user can quickly view and like each post. All of these features are able to be implemented on a computer, but the idea of the app is revolved around a sleek mobile interface.
- **Story:** When we were new to UB, we all had some difficulty navigating around campus for the first-couple of weeks. It wasn't easy finding the best study locations, food spots, leisure areas, and other services around campus. This app solves all the problems of new UB students trying to familize themselves with their new enviornment. Current students will be able to share their favorite locations while discovering everything else the area has to offer. Not only does this app provide a clear directory of all services on campus, this app also includes the most up-to-date and top-rated locations on campus, uploaded by students alike.
- **Market:** Our market is the entire student base at the University at Buffalo's North Campus. This consists of thousands of students looking for events or activities. For those users that are adventurous or curious about what events are going on on the North Campus, this app provides a great amount of value. It is a useful tool to stay updated.
- **Habit:** Users do not have to stay on the app for extended periods of time, so habit-forming is not too much of an issue. The app provides a quick service in finding a location or event, and users can freely share their favorite places around as much as they please.
- **Scope:** This app's difficulty comes in form of how much research needs to be done to correctly implement our required features. Understanding how to use an API to get coordinates and storing those locations may be a challenge, but research will alleviate some of the difficulty. A bare-bone version of this app is still fun and useful to design because it solves a problem that we all had when arriving at UB for the first time. We have clear objective for this app already listed. Our final design is still in progress.  

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* User can view feed of favorite locations uploaded by others
* User can like post and get location of post
* User can upload their own favorite location
* User can view services
* User can select a service and view map location
* User can login/logout
* User can view liked posts

**Optional Nice-to-have Stories**
* User can access settings button on home page to filter post categories on feed
* User can select preferred campus
* User can see a map view of all services (filtered too)

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their liked posts
* Home Feed
    * Allows user to like other users' posts, and find directions to the location
    *  Post includes image, caption, like button, and directions button
    *  Includes upload button to direct user to Upload Screen
    *  Includes settings button to direct user to Settings Screen
* Upload Screen
    * Allows user to upload image of spot
    * User will link specific location on the given map
* Settings Screen
    * Given user the option to filter Home Feed posts by category
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
* Feed (main page) -> See locations or events posted by other users. Also interact by liking a post or get directions to the location or event.
* Liked -> View all your liked post 


## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype
First protoype displaying map "Services" functionality:

![](https://i.imgur.com/9AohS8o.gif)



## Schema 
[This section will be completed in Unit 9]
### Models
Posts
| Property  | Type           |Description                    |
| --------- | -------------- |-------------------------------|
| objectID  | Sting          | unique ID for user post       |
| author    | Pointer to User| image author                  |
| image     | File           | image that user posts         |
| caption   | String         | description of image by user  |
| likesCount| Int            | number of likes for the post  |
| lat       | Double         | latitude of location in post  |
| long      | Double         | longitude of location in post |
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
