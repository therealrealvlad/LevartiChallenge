# LevartiChallenge
This repo hosts my work on the Levarti Coding Challenge

I created a simple app to (a) log an existing user in (username: "tonyvlad", password: "mobiledev"), and (b) populate a table view with images and text downloaded from a JSON service. I've added a couple of unit tests for the log in screen too.

The user can search the text associated with each image, with the table view updating as the text input updates. 

The user can delete items from the table view, and refresh the table view by pulling down on the view. 

When the table view is refreshed like this, only those items that have not previously been deleted will populate the table. 
