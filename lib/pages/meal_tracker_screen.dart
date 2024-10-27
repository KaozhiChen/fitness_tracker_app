import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:async';
import '../services/database_helper.dart';
import 'package:fitness_tracker_app/theme/colors.dart';


class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late String result = ""; // Stores the scanned text result
  bool imageRetakeNeeded = true; // Determines if a new image is needed
  bool databaseUpdated = false; // Indicates if the database was updated
  File? _image; // Stores the selected image
  InputImage? inputImage; // Stores the input image for text recognition
  final picker = ImagePicker(); // Used to select images from gallery/camera
  final TextEditingController _calorieController = TextEditingController(); // Controller for manual calorie input
  int servings = 1;

  // Opens gallery and chooses an image
  Future pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Store the image file
        imageToText(InputImage.fromFilePath(pickedFile.path)); // Extract text
      }
    });
  }

  // Opens camera and takes an image
  Future captureImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Store the captured image
        imageToText(InputImage.fromFilePath(pickedFile.path)); // Extract text
      }
    });
  }

  // Scans the image for text
  Future imageToText(inputImage) async {
    result = '';
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    setState(() {
      bool isNutritionFactsLabel = false;
      for (TextBlock block in recognizedText.blocks) {
        if (block.text.contains('Nutrition')) {
          isNutritionFactsLabel = true;
        }
        if (!(block.text.contains(RegExp(r'[A-Za-z%]+'))) && isNutritionFactsLabel) {
          result = block.text; // Capture calorie data
          imageRetakeNeeded = false;
          askForServings(); // Ask for servings after scanning text
          return;
        }
      }
      result = isNutritionFactsLabel
          ? 'Please take a clearer picture of the Nutrition Facts label.'
          : 'Please scan a Nutrition Facts label.';
      imageRetakeNeeded = true;
    });
  }

  // Ask user for the number of servings
  void askForServings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How many servings did you eat?'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter number of servings",
              hintStyle: TextStyle(color: labelColor),
            ),
            onChanged: (value) {
              servings = int.tryParse(value) ?? 1; // Default to 1 if invalid input
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Submit", style: TextStyle(color: primary)),
              onPressed: () {
                setState(() {
                  // Multiply the calories by servings
                  result = (int.parse(result) * servings).toString();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null || databaseUpdated
                ? chooseImage()
                : displayResult(),
          ],
        ),
      ),
    );
  }

  // Setup to display chooseImageButtons
  Widget chooseImage() {
    return Column(
      children: [
        const SizedBox(height: 75),
        databaseUpdated
            ? const Center(
                child: Text('Calories added to database.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))
            : const Center(
                child: Text('No image selected.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        const SizedBox(height: 20),
        chooseImageButtons(),
      ],
    );
  }

  // Displays Gallery and Camera buttons
  Widget chooseImageButtons() {
    databaseUpdated = false;
    return Column(
      children: [
        imageRetakeNeeded
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonTemplate(() {
                      pickImageFromGallery();
                    }, 'Gallery'),
                    buttonTemplate(() {
                      captureImageFromCamera();
                    }, 'Camera'),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonTemplate(() {
                    addCaloriesToDatabase(result);
                    setState(() {
                      databaseUpdated = true;
                      imageRetakeNeeded = true;
                    });
                    showSnackBar();
                  }, 'Save Calories'),
                  buttonTemplate(() {
                    setState(() {
                      imageRetakeNeeded = true;
                    });
                  }, 'Choose Another Image'),
                ],
              ),
        SizedBox(
          width: 337.1,
          child: Material(
            elevation: 10,
            shadowColor: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
            color: bgTextField,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _calorieController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Calories Here",
                hintStyle: TextStyle(color: labelColor),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      // Add a submit button below the text field
      buttonTemplate(() {
        // Get the calories entered by the user
        String enteredCalories = _calorieController.text;

        // Add calories to the database using the user input
        addCaloriesToDatabase(enteredCalories);
        setState(() {
          databaseUpdated = true;
          imageRetakeNeeded = true;
        });
        showSnackBar(); // Notify the user of successful addition
      }, 'Submit Calories'), // Submit button
      ],
    );
  }

  // Displays the image and the scanned text
  Widget displayResult() {
    return Column(
      children: [
        SizedBox(
          height: 540,
          child: Center(
            child: Image.file(_image!),
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          child: Text(
            'Calories: $result',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        chooseImageButtons(),
      ],
    );
  }

  // Template for buttons
  Widget buttonTemplate(VoidCallback onPressed, String text) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: primary,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }


  // Function to show a SnackBar message indicating calorie intake has been updated
  void showSnackBar() async {
    final messenger = ScaffoldMessenger.of(context);
    int calories = 0;
    String textForSnackBar;
    // Retrieve the calories for the current day from the database
    if (await DatabaseHelper.instance.getCaloriesForDay(
            DateTime.now().day, DateTime.now().month, DateTime.now().year) >=
        0) {
      calories = await DatabaseHelper.instance.getCaloriesForDay(
          DateTime.now().day, DateTime.now().month, DateTime.now().year);
      textForSnackBar = 'Calorie Intake Updated!';
    } else {
      textForSnackBar = "Error";
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(textForSnackBar),
      ),
    );
  }

  // Function to add the recognized or manually entered calories to the database
  void addCaloriesToDatabase(String calories) async {
    await DatabaseHelper.instance.incrementCaloriesForDay(DateTime.now().day,
        DateTime.now().month, DateTime.now().year, int.parse(calories));
  }
}