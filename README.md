# LightSpeed Pic Saver

This is a simple iOS app that fetches random images from an API, displays them in a list, and allows users to manage the content by adding, deleting, and reordering items. The app is built using UIKit and leverages Swift Package Manager (SPM) for dependency management.

## Features

- **Fetch Random Images**: The app fetches random images from the [Picsum API](https://picsum.photos/v2/list) and displays them in a list.
- **Persistence**: The fetched images are saved locally and appended to the bottom of the list.
- **UI Updates**: The UI updates dynamically as new items are added.
- **Content Management**: Users can delete and reorder items in the list.
- **Swift Package Manager**: The app uses SPM for managing dependencies (if any).
- **Testing**: Includes unit tests to ensure the app's functionality.

## Getting Started

### Prerequisites

- Xcode 14.0 or later
- iOS 15.0 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/DrDijkstra/LightSpeed.git
   ```
2. Open the project in Xcode:
   ```bash
   cd LightSpeed
   open LSPicSaver.xcodeproj
   ```
3. Build and run the project on the simulator or a physical device.

## Usage

1. **Fetch and Save**: Tap the "Fetch Random Image" button to fetch a random image from the API. The image and its author will be saved locally and added to the list.
2. **Delete Items**: Swipe left on an item in the list to delete it.
3. **Reorder Items**: Tap and hold an item to drag and reorder it within the list.

## Architecture

- **Networking**: The app uses `URLSession` to handle API requests.
- **Persistence**: Data is persisted using `UserDefaults` or CoreData (based on your implementation).
- **UI**: The UI is built using UIKit, with a focus on a responsive and polished design.
- **Delegates**: The app uses delegates and protocols for communication between components.

## Testing

The app includes unit tests for key functionalities, such as:

- Fetching random images from the API
- Saving and retrieving images locally
- Managing the list (adding, deleting, reordering)

To run the tests:

1. Open the project in Xcode.
2. Select the "LSPicSaver" scheme.
3. Press `Command + U` to run the tests.

## Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire) 
- [Kingfisher](https://github.com/onevcat/Kingfisher) 
- [XCoordinator](https://github.com/quickbirdstudios/XCoordinator) 
- [CHTCollectionViewWaterfallLayout](https://github.com/chiahsien/CHTCollectionViewWaterfallLayout)


## Acknowledgments

- Thanks to [Picsum](https://picsum.photos) for providing the free image API.

---

Replace the placeholders with your actual repository link and other details as needed. This README file provides a clear overview of the app, its features, and instructions for running and contributing to the project.
