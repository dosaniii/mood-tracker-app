import 'package:flutter/material.dart';
import 'models/user_model.dart'; // ito yung folder for required

// stateful widget is used for user's interaction where it response and change its apperance
// whenever a user clicked a button -- checkbox, radio button, text field
class FormSample extends StatefulWidget {
  const FormSample({super.key});

  @override
  State<FormSample> createState() => _FormSampleState();
}

class _FormSampleState extends State<FormSample> {
  final _formKey =
      GlobalKey<
        FormState
      >(); // instance of the global key para maaccess yung key ng buong form
  // global key for saving and validating the mood tracker form when the user submit

  // text controllers are used to manage text input fields
  // for name, nickname, age
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // initialized variables which stores the value based on the user's input
  User? _userValues;
  bool _exercisedToday = true;
  String? _selectedWeather = _weathers.first; // default first weather (sunny)
  String? _selectedEmotion = _emotions.first; // default first emotion (joy)
  double _emotionIntensity =
      5.0; // default emotion intensity at 5.0; used for slider

  // stores variables for submitted values
  bool _submittedExercisedToday = true;
  String? _submittedWeather;
  String? _submittedEmotion;
  double _submittedEmotionIntensity = 5.0;

  // ito yung makiktia sa dropdown list
  // list for weathers
  static final List<String> _weathers = [
    "Sunny",
    "Rainy",
    "Stormy",
    "Hailing",
    "Snowy",
    "Cloudy",
    "Foggy",
    "Partly Cloudy",
  ];

  // list for emotions
  static final List<String> _emotions = [
    "Joy",
    "Sadness",
    "Disgust",
    "Anger",
    "Fear",
    "Anxiety",
    "Embarassment",
    "Envy",
  ];

  // icon for emotions
  IconData _getEmotionIcon(String emotion) {
    switch (emotion.trim().toLowerCase()) {
      case 'joy':
        return Icons.sentiment_very_satisfied;
      case 'sadness':
        return Icons.sentiment_dissatisfied_outlined;
      case 'disgust':
        return Icons.sick_outlined;
      case 'anger':
        return Icons.sentiment_very_dissatisfied;
      case 'fear':
        return Icons.sentiment_neutral;
      case 'anxiety':
        return Icons.face_5_rounded;
      case 'embarrassment':
        return Icons.abc;
      case 'envy':
        return Icons.sentiment_very_dissatisfied_sharp;
      default:
        return Icons.emoji_emotions;
    }
  }

  // dispose() is for memory keeping pag maraming controllers para madispose sila properly or mag-clear ng mga memory
  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // function which saves the user's information whenever the submit button is clicked
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form data

      setState(() {
        // Update submitted values
        _userValues = User(
          name: _nameController.text,
          nickname:
              //_nicknameController.text is the current value
              // .isNotEmpty checks if its empty
              _nicknameController.text.isNotEmpty
                  // if ? _nicknameController.text is not empty, then use the entered value
                  ? _nicknameController.text
                  // otherwise, return null or empty
                  : null,
          age: _ageController.text,
          exercisedToday: _exercisedToday,
          emotion: _selectedEmotion,
          weather: _selectedWeather,
        );

        // Sync real-time values to submitted values
        _submittedExercisedToday = _exercisedToday;
        _submittedWeather = _selectedWeather;
        _submittedEmotion = _selectedEmotion;
        _submittedEmotionIntensity = _emotionIntensity;
      });
    } else {
      print("Form is invalid");
    }
  }

  // function that resets the user's information when it is clicked
  void _resetForm() {
    _formKey.currentState!.reset(); // Reset the form

    setState(() {
      // Clear text controllers
      _nameController.clear();
      _nicknameController.clear();
      _ageController.clear();

      // Reset real-time values
      _exercisedToday = true;
      _selectedWeather = _weathers.first;
      _selectedEmotion = _emotions.first;
      _emotionIntensity = 5.0;

      // Reset submitted values
      _userValues = null;
      _submittedExercisedToday = true;
      _submittedWeather = null;
      _submittedEmotion = null;
      _submittedEmotionIntensity = 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key:
          _formKey, // ito yung dineclare sa taas kanina which is yung global key
      autovalidateMode:
          AutovalidateMode
              .onUnfocus, // pang focus lang ng mga pipindutin na button (pang validate)
      // main content of mood tracker form
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.all(10), // Add padding for consistency
              child: Text(
                "User Information",
                style: TextStyle(
                  color: Color(0xFFFFBF42),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            // Dropdown Form Field

            // for user's information including names, nickname, and age, also if the user got to exercised today
            // for name text field
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    // TextFormField is the textfield inside a forms
                    // this merges the textfield and formfield together for better construction of widget
                    child: TextFormField(
                      // designing the border
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFDC6),
                        // pang outlined border pang design lang
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // Rounded corners
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ), // Hide the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Enter your Name",
                        labelText: "Name",
                      ),
                      controller: _nameController, // bakit hindi onchange?
                      validator: (value) {
                        // pwede lang to para sa textformfield
                        // naglalagay lang ng logic para sa pag eevaluate
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }

                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),

            // for nickname text field
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      //
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFDC6),
                        // pang outlined border pang design lang
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ), // Rounded corners
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ), // Hide the border
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Enter your Nickname",
                        labelText: "Nickname",
                      ),
                      controller: _nicknameController, // bakit hindi onchange?
                      validator: (value) {
                        // pwede lang to para sa textformfield
                        // naglalagay lang ng logic para sa pag eevaluate
                        return null; // allow empty input
                      },
                    ),
                  ),
                ),
              ],
            ),

            // for age text field
            Row(
              children: [
                // Age Input (Expanded to take available space)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFDC6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Enter your Age",
                        labelText: "Age",
                      ),
                      controller: _ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your age";
                        }
                        if (int.tryParse(value) == null) {
                          return "Must be an integer!";
                        }
                        final age = int.tryParse(
                          value,
                        ); // Try parsing the input as an integer
                        if (age == null) {
                          return "Age must be a valid integer";
                        }
                        if (age <= 0) {
                          return "Age must be greater than 0";
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                // Space between Age and Switch
                SizedBox(width: 10),

                // Exercised Today? (Fixed Width)
                // same row with the age
                // separate container for modifying its properties
                Container(
                  width: 200, // Adjust width as needed
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFFFFDC6),
                  ),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Exercised Today?",
                      style: TextStyle(fontSize: 15),
                    ),
                    value: _exercisedToday,
                    onChanged: (bool newValue) {
                      setState(() {
                        _exercisedToday = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 15), // Add spacing between the two containers
            // Divider(thickness: 2, color: Color(0xFF5B4689)),
            SizedBox(height: 15), // Add spacing between the two containers
            // this updates the emotions of the user
            // it includes the list of emotions which can be choose by the user

            // --CONTAINER FOR EMOTION, WEATHER, SUBMIT AND RESET BUTTON
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(
                      0xFFFFD95A,
                    ), // Background color for the container
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  padding: EdgeInsets.all(16), // Padding inside the container
                  child: Column(
                    children: [
                      // --WHAT'S THE WEATHER TODAY? SECTION
                      Padding(
                        padding: EdgeInsets.all(
                          10,
                        ), // Add padding for consistency
                        child: Text(
                          "What's the weather today?",
                          style: TextStyle(
                            color: Color(0xFFFFBF42),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ), // Spacing between weather dropdown and "What do you feel?" section
                      // --WHAT DO YOU FEEL? SECTION
                      Padding(
                        padding: EdgeInsets.all(
                          10,
                        ), // Add padding for consistency
                        child: Text(
                          "What do you feel?",
                          style: TextStyle(
                            color: Color(0xFFFFBF42),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      // --DROPDOWN FOR EMOTIONS
                      SizedBox(
                        width:
                            double.infinity, // Takes full width of the parent
                        height: 80, // Adjust height as needed
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              filled: true, // Enables background color
                              fillColor: const Color.fromARGB(
                                255,
                                255,
                                218,
                                108,
                              ), // Background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // Rounded corners
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ), // Hide the border
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value:
                                  _selectedEmotion, // Holds the currently selected emotion
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedEmotion = value;
                                });
                              },
                              items:
                                  _emotions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onSaved: (newValue) {
                                print("Dropdown onSaved method triggered");
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ), // Spacing between dropdown and slider
                      // --EMOTION INTENSITY SLIDER
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ), // Horizontal padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Emotion Intensity: ${_emotionIntensity.toStringAsFixed(1)}/10.0",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Slider(
                              value: _emotionIntensity,
                              min: 0.0,
                              max: 10.0,
                              divisions: 10,
                              label: _emotionIntensity.toStringAsFixed(1),
                              onChanged: (double value) {
                                setState(() {
                                  _emotionIntensity = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      // --DROPDOWN FOR WEATHER
                      SizedBox(
                        width:
                            double.infinity, // Takes full width of the parent
                        height: 80, // Adjust height as needed
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              filled: true, // Enables background color
                              fillColor: const Color.fromARGB(
                                255,
                                255,
                                218,
                                108,
                              ), // Background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ), // Rounded corners
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ), // Hide the border
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value:
                                  _selectedWeather, // Holds the currently selected weather
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedWeather = value;
                                });
                              },
                              items:
                                  _weathers.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onSaved: (newValue) {
                                print("Dropdown onSaved method triggered");
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ), // Spacing between slider and buttons
                      // --SUBMIT AND RESET BUTTONS
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Submit Button
                            ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFFDC6),

                                /// Background color
                                foregroundColor: Color.fromARGB(
                                  255,
                                  255,
                                  218,
                                  108,
                                ), // Text color
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ), // Button padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ), // Rounded corners
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Reset Button
                            ElevatedButton(
                              onPressed: _resetForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(
                                  0xFFFFFDC6,
                                ), // Background color
                                foregroundColor: Color.fromARGB(
                                  255,
                                  255,
                                  218,
                                  108,
                                ), // Text color
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ), // Button padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ), // Rounded corners
                                ),
                              ),
                              child: Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // SizedBox(height: 15), // Add spacing between the two containers
            // Divider(thickness: 2, color: Color(0xFF5B4689)),
            // SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
