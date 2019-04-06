CS441

Program 5: Reddit App

Kevin Ren, Jonathan Chang, Kevin Wu

We craeted a basic Reddit app that allows the user to enter a subreddit and the app will return the
title, image, and author of recent posts. If the user enteres an invalid subreddit name or nothing, the app will show an error message in the log and print "Error".

The app reads the RSS feed from the entered subreddit. The information from the RSS feed is seprated into tags so there is a loop that goes through each tag and records the information such as title, author, date, and image URL.
When a subreddit is searched, the app utilizes Android's listview to print the title, author, and date. 
The app utilizes Universal Image Loader (https://github.com/nostra13/Android-Universal-Image-Loader)to display the image via the image URL.
