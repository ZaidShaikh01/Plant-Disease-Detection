#Plant Disease Detection App
This Flutter-based application uses machine learning to identify various plant diseases from leaf images, assisting farmers and gardeners in early disease detection and treatment. The app integrates a custom-trained model with 14 classes and over 3000 sample images, leveraging Google ML Kit for efficient on-device image classification.

#Features
Real-Time Disease Diagnosis: Upload a leaf image, and the app identifies diseases across various crops, including tomatoes, potatoes, and peppers.
Login and Sign up feature: using firebase.
Disease-Specific Insights: For each disease, the app provides possible causes and recommended treatments.
Random Image Detection: Displays a prompt to "Choose proper image" if an unrecognized or random image is submitted, ensuring accurate results.
Offline Functionality: Utilizes on-device processing with ML Kit, enabling offline use.

How It Works
Users upload a leaf image.
The model predicts the disease, returning specific advice for healthy and infected plants.
If an unrecognizable image is detected, the app prompts users to try a more suitable image.
This project is an efficient tool for minimizing crop losses, making plant care more accessible and informed.

#My notes
I faced a problem where I was getting output even after the image was totally random and didn't include any leaf. So, I created a new model in which I've created a new class as Random for random images. That's how I solved it.

#List of packages
1. tflite_v2
2. image_picker
3. firebase_auth
4. firebase_core

# Dependency in pubspec.ymal
dependencies:
  flutter:
    sdk: flutter


  The following adds the Cupertino Icons font to your application.
  Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  image_picker: ^1.1.2

  tflite_v2: ^1.0.0
  firebase_core: ^3.6.0
  firebase_storage: ^12.3.4
  firebase_auth: ^5.3.1
  fluttertoast: ^8.2.8
  cloud_firestore: ^5.4.4
# Add this in app\build.gradle

aaptOptions {
        noCompress 'tflite'
        noCompress 'lite'
    }
