# Cities
iOS app in swift using local json to display and search cities

## Features
- Listing all cities
- Live search (filter) using
- Map details screen for the selected city
- Unit tests covering view model and binding

## Followed Architectures

### Coordinator Pattern
- Handle all the logic for presentation between View Controllers and provides an encapsulations of navigation logic.

### MVVM (Model-View-ViewModel) with binding
- Model: Holds the application data models
- View: It displays a representation of the model and receives the user's interaction with the view (clicks, keyboard, gestures, etc.), and it forwards the handling of these to the view model via the data binding (properties, event callbacks, etc.) that is defined to link the view and view model.
- ViewModel: Holds the business logic exposing public properties and functions

## Future Enhancements
- Map region (zoom level) dynamic adjustment to fit all cities/countries based on their longitude and latitude
- Adding UI tests