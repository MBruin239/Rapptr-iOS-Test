#Issues:

- I did not know the format the web API wanted the email and password to come in so I never got that to actually return success. But the functions are setup for when there would be one.

- I was struggling with the navigation bar going translucent so I set the window background color to the header background color as a work around.

#Notes:

- I upped the iOS deployment target to iOS 13 becuase there was no minimum iOS given and I didn't want to work around not having the SceneDelegate.

- I did the web calls in 3 differnt ways. Chat I did the way I typically architect web requests, login was kept closer to how it was initially setup, and the avatar image was just done in view.

- I used [Gifu](https://github.com/kaishin/gifu) as my CocoaPod becuase I wanted somthing extra to go with the fade out/in functionality.


Thank you!
