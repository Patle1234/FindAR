# FindAR: Event Planning with AR

FindAR is an innovative iOS application designed to simplify event planning using the power of Firebase and ARKit. Whether you’re organizing a birthday party, graduation ceremony, or any other special event, FindAR recommends products tailored to your needs and lets you visualize them in augmented reality for a seamless planning experience.

## Description

FindAR revolutionizes how you prepare for events by offering product recommendations based on your selected events and allowing you to manage multiple plans simultaneously. Built for iOS using Firebase for backend services and ARKit for augmented reality features, FindAR combines smart suggestions, intuitive organization, and AR visualization in a single platform.

Whether you’re planning one event or juggling several, FindAR makes it easy to save products, compare options, and visualize items in your space—all from the convenience of your phone.

## Features

### **Home TabView**
- **Event Selection**: Choose from a predefined list of events (e.g., Birthday, Graduation, Funeral). Update your event at any time to refresh recommendations.
- **Smart Recommendations**:
  - Swipe **right** to save a product.
  - Swipe **left** to skip an item.
  - Swipe **down** or tap to view detailed information.
- **Product Details**:
  - Comprehensive description.
  - User reviews.
  - Links to vendors with pricing information.
  - Quick AR view button.

### **Cart TabView**
- **Event Organization**:
  - View saved items for each planned event in individual dropdown menus.
  - Access detailed views for each saved item.
- **Total Cart View**:
  - Combine items from all events into a single, comprehensive cart.

### **AR TabView**
- **Augmented Reality Visuals**:
  - View and interact with selected products in AR.
  - Quickly access AR from the product details page or a dedicated AR tab.

## Getting Started

### Dependencies

Before setting up FindAR, ensure your development environment meets the following requirements:

- **Xcode**: Version 14.0 or higher
- **iOS SDK**: Compatible with iOS 15.0+
- **Firebase**: For backend services
- **ARKit**: Enabled in your Xcode project
- **Operating System**: macOS

### Installing

1. **Clone the repository**:  
   ```
   git clone https://github.com/Patle1234/FindAR.git
   ```
2. **Navigate to the project folder**:  
   ```
   cd FindAR
   ```
3. **Install dependencies**:  
   Open the project in Xcode and resolve any missing dependencies.
4. **Set up Firebase**:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Download the `GoogleService-Info.plist` file and add it to the Xcode project.
   - Enable Firebase Firestore for storing data.
5. **Run the app**:  
   Build and run the app using an iOS simulator or physical device.

### Executing the Program

1. Launch the app on your device.
2. Select an event and browse product recommendations.
3. Swipe to save, skip, or explore items in detail.
4. Visualize items in AR and manage saved products via the cart.

## Help

### Common Issues

- **Issue**: "Firebase connection error."  
  **Solution**: Ensure your Firebase configuration is correct and the `GoogleService-Info.plist` file is added to the project.

- **Issue**: "AR features are not working."  
  **Solution**: Verify that ARKit is enabled in your project settings and your device supports AR.

- **Issue**: "App crashes on launch."  
  **Solution**: Update your Xcode and iOS SDK to the latest versions.

## Authors

- **Dev Patel** – Creator and Lead Developer  
  - [GitHub](https://github.com/Patle1234)  
  - [LinkedIn](https://www.linkedin.com/in/devpatel88/)

## Version History

- **0.2**
  - Added AR visualization features.
  - Enhanced product recommendation algorithm.
  - See [commit changes](https://github.com/Patle1234/FindAR/commits) for more details.
- **0.1**
  - Initial release with event planning and cart functionality.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the LICENSE.md file for details.

## Acknowledgments

- **Inspiration**: The idea for FindAR was inspired by the challenges of organizing multiple events and visualizing products in real-time.
- **Libraries Used**:
  - [Firebase](https://firebase.google.com/) - Backend services.
  - [ARKit](https://developer.apple.com/augmented-reality/) - Augmented reality features for iOS.
- Special thanks to [awesome-readme](https://github.com/matiassingers/awesome-readme) for the inspiration in writing great documentation.
