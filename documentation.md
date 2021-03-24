                            THE ARCHITECTURE    UI -> Controller -> Core -> Data
The UI just makes request through controllers (state management frameworks). 
Controller delegates the request to abstract repositories contained in Core. 
Data implements these repositories, fetches the data in whichever way (over the internet or locally).
Returns the result through the same channel. 
Dependency injection of implementing repositories (container in Data) is done in the UI into controllers' constructor, 
particularly when providing the cubit or provider widget on the widget tree
The architecture is chosen in such a way that each component of the architecture would only import from folders by its side. 
This way, code in each folder is almost self-independent
However, there are some widgets that fetch data directly from their corresponding repository rather than through a controller.
These widgets are all stateful widgets. And this is so in order to avoid using two state management options in a single widget


                            SECURE_STORAGE PACKAGE
Flutter_secure_storage package was used to securely save authentication token, as well as other sensitive info. 
Flutter_secure_storage uses SharedPreferences, only that it stores values with an encryption provided by Android OS
