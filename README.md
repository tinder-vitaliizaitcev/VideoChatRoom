# VideoChatRoom

This is an example of how Video chat can be implemented from an Architecture perspective.

Probably I implemented discover not exactly how it supposed to be, but I’ll add changes later. Now it’s more Viper :)

Basically the goals were:
 - Separate responsibilities
 - Make View Controller dumb (use only as a container)
 - Build composition view in a way any part of it can be easily replaced or modified later
 - Use protocols everywhere when it’s possible
 - Set communication between layers like View <---> ViewModel <---> Context. View just responsible for user inputs and display received data. ViewModel is communication + prepares data for display for UI. Context responsible for data fetch.
