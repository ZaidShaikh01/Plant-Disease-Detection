import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Variables
  File? imageFile;
  late List _results = [];
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    loadModel();
    imagePicker = ImagePicker();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt"))!;
    print('Model Loading Status: $res');
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions ?? []; // Ensure it's not null
      imageFile = image; // Update the imageFile variable
    });
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return value ?? false; // Return false if value is null
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.deepPurpleAccent),
            displayMedium: TextStyle(color: Colors.deepPurpleAccent),
            bodyMedium: TextStyle(color: Colors.deepPurpleAccent),
            titleMedium: TextStyle(color: Colors.pinkAccent),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://w0.peakpx.com/wallpaper/61/489/HD-wallpaper-leaves-plants-nature-dark-vertical-portrait-display.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: imageFile == null
                ? Center(
              child: Image.asset(
                'assets/images/applogo.png',
                scale: 6,
              ),
            )
                : Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _results.map((result) {
                        return Card(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                                "${result['label']} - ${result['confidence'].toStringAsFixed(2)}"),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "tag",
                  onPressed: chooseImage,
                  child: const Icon(Icons.drive_file_move_rtl),
                ),
                Expanded(child: Container()),
                FloatingActionButton(
                  heroTag: "abc",
                  onPressed: captureImage,
                  child: const Icon(Icons.camera_alt_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get from gallery
  chooseImage() async {
    XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (selectedImage != null) {
      imageClassification(File(selectedImage.path));
    }
  }

  /// Get from Camera
  captureImage() async {
    XFile? selectedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (selectedImage != null) {
      imageClassification(File(selectedImage.path));
    }
  }
}
