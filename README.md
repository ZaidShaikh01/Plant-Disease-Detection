# Plant Disease Detection App
This Flutter-based application leverages machine learning to identify various plant diseases from leaf images, providing a valuable tool for early disease detection and treatment for farmers and gardeners. The app integrates a custom-trained model with 14 classes and over 3000 sample images, using Google ML Kit for efficient on-device image classification.

# Features
Real-Time Disease Diagnosis
Users can upload a leaf image, and the app identifies diseases across various crops, including tomatoes, potatoes, and peppers.

Login and Signup
Secure authentication powered by Firebase, allowing users to create accounts and log in.

Disease-Specific Insights
For each disease, the app provides details on possible causes and recommended treatments.

Random Image Detection
If a user uploads an unrecognized or random image, the app displays a prompt to "Choose a proper image," ensuring more accurate results.

Offline Functionality
With on-device processing powered by ML Kit, the app can function offline, making it accessible even without an internet connection.

# How It Works

Upload Image
Users upload a leaf image, and the model analyzes it for potential diseases.

Disease Prediction
The app predicts the disease and provides specific advice for both healthy and infected plants.

Random Image Detection
If an unrecognizable image is detected, the app prompts users to try a more suitable image for accurate analysis.

This app helps minimize crop losses by making plant care more accessible and informed.

Development Notes
I encountered an issue where random images (without leaves) still returned a result. To solve this, I created a new model that includes a "Random" class for non-plant images, ensuring that random submissions are better filtered out.

# Packages Used
tflite_v2
image_picker
firebase_auth
firebase_core

# Dependency in pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  image_picker: ^1.1.2
  tflite_v2: ^1.0.0
  firebase_core: ^3.6.0
  firebase_storage: ^12.3.4
  firebase_auth: ^5.3.1
  fluttertoast: ^8.2.8
  cloud_firestore: ^5.4.4
# Additional Configuration in app/build.gradle
To support ML Kit integration, add the following to aaptOptions:
aaptOptions {
    noCompress 'tflite'
    noCompress 'lite'
}
