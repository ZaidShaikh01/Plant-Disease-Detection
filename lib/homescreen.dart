import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;
  late List _results = [];
  late String possibleCauses = "";
  late String possibleSolution = "";
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
      _results = recognitions ?? [];
      imageFile = image;
    });

    if (_results.isNotEmpty) {
      String label = _results[0]['label'];
      applyDiagnosis(label);
    }
  }

  void applyDiagnosis(String label) {
    switch (label) {
      case "Pepper Bell Bacterial Spot":
        possibleCauses =
        "Caused by Xanthomonas bacteria, spread through splashing rain.";
        possibleSolution =
        "Spray early and often. Use copper and Mancozeb sprays.";
        break;

      case "Pepper Bell Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Potato Early Blight":
        possibleCauses =
        "The fungus Alternaria solani, high humidity and long periods of leaf wetness.";
        possibleSolution =
        "Maintain optimum growing conditions: proper fertilization, irrigation, and pest management.";
        break;

      case "Potato Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Potato Late Blight":
        possibleCauses =
        "Occurs in humid regions with temperatures ranging between 4 and 29 °C.";
        possibleSolution =
        "Eliminate cull piles and volunteer potatoes, use proper harvesting and storage practices, and apply fungicides when necessary.";
        break;

      case "Tomato Bacterial Spot":
        possibleCauses =
        "Xanthomonas bacteria can be introduced on contaminated seed and transplants, which may or may not show symptoms.";
        possibleSolution =
        "Remove symptomatic plants from the field or greenhouse to prevent the spread to healthy plants.";
        break;

      case "Tomato Early Blight":
        possibleCauses =
        "Caused by the fungus Alternaria solani, which thrives in high humidity and long periods of leaf wetness.";
        possibleSolution =
        "Maintain optimum growing conditions: proper fertilization, irrigation, and pest management.";
        break;

      case "Tomato Healthy":
        possibleCauses = "Crops are okay.";
        possibleSolution = "N/A";
        break;

      case "Tomato Late Blight":
        possibleCauses = "Caused by the water mold Phytophthora infestans.";
        possibleSolution = "Apply fungicide timely to control the spread.";
        break;

      case "Tomato Leaf Mold":
        possibleCauses = "High relative humidity (greater than 85%).";
        possibleSolution =
        "Grow leaf mold-resistant varieties and use drip irrigation to avoid watering foliage.";
        break;

      case "Tomato Septoria Leaf Spot":
        possibleCauses =
        "A fungus that spreads by spores, especially in wet or humid weather. Attacks plants in the nightshade family and can be harbored on related weeds.";
        possibleSolution =
        "Remove infected leaves immediately and use organic fungicides as a preventative measure.";
        break;

      case "Tomato Spotted Spider Mites":
        possibleCauses =
        "Spider mites feed on leaves during hot and dry conditions.";
        possibleSolution =
        "Use a strong stream of water to knock spider mites off the plants, or apply insecticidal soaps and horticultural oils.";
        break;

      case "Tomato Target Spot":
        possibleCauses =
        "Caused by the fungus Corynespora cassiicola, which spreads to plants.";
        possibleSolution =
        "Plant resistant varieties and keep farms free from weeds.";
        break;

      case "Tomato Mosaic Virus":
        possibleCauses =
        "Spread by aphids, mites, fungi, nematodes, and contact; can also be transmitted via pollen and seeds.";
        possibleSolution =
        "Remove all infected plants and destroy them as there is no cure.";
        break;

      case "Tomato Yellow Leaf Curl Virus":
        possibleCauses =
        "Physically spread plant-to-plant by the silverleaf whitefly.";
        possibleSolution =
        "Spray Imidacloprid on the entire plant, especially under the leaves.";
        break;

      default:
        possibleCauses = "N/A";
        possibleSolution = "N/A";
        break;
    }
  }


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
        return value ?? false;
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
                      children: [
                        ..._results.map((result) {
                          return Card(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                              ),
                            ),
                          );
                        }).toList(),
                        if (possibleCauses.isNotEmpty)
                          Card(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Possible Causes: $possibleCauses"),
                                  const SizedBox(height: 8),
                                  Text("Possible Solutions: $possibleSolution"),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "gallery",
                  onPressed: chooseImage,
                  child: const Icon(Icons.drive_file_move_rtl),
                ),
                Expanded(child: Container()),
                FloatingActionButton(
                  heroTag: "camera",
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
