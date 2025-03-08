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

  // // Holds selected value for display
  // final String _selectedValue = "Select Field";

  // static const WidgetStateProperty<Icon> thumbIcon =
  //     WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
  //       WidgetState.selected: Icon(Icons.check),
  //       WidgetState.any: Icon(Icons.close),
  //     });

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10), // Add padding for consistency
              child: Text(
                "User Information",
                style: TextStyle(
                  fontSize: 15, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Make it bold
                  color: Colors.black, // Adjust color as needed
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
                        fillColor: const Color.fromARGB(255, 255, 218, 108),
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
                        fillColor: const Color.fromARGB(255, 255, 218, 108),
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
                        fillColor: const Color.fromARGB(255, 255, 218, 108),
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
                    color: const Color.fromARGB(255, 255, 218, 108),
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
            Divider(thickness: 2, color: Color(0xFF5B4689)),
            SizedBox(height: 15), // Add spacing between the two containers
            // this updates the emotions of the user
            // it includes the list of emotions which can be choose by the user
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // for text information
                Padding(
                  padding: EdgeInsets.all(10), // Add padding for consistency
                  child: Text(
                    "What do you feel?",
                    style: TextStyle(
                      fontSize: 15, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Make it bold
                      color: Colors.black, // Adjust color as needed
                    ),
                  ),
                ),

                // this container shows the list of emotions
                // modified, designed, and has scrollable feature
                Container(
                  height: 250, // Set a fixed height for the container
                  padding: EdgeInsets.all(10), // Add some padding
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      255,
                      218,
                      108,
                    ), // Background color
                    borderRadius: BorderRadius.circular(
                      15,
                    ), // Optional rounded corners
                  ),

                  // scrollable feature
                  // Make the content scrollable if it overflows
                  child: SingleChildScrollView(
                    // wrap method is used since radio button could overflow in the screen and cause rendering error
                    // this prevent the overflowing of radio buttons which then wraps for the next line
                    child: Wrap(
                      spacing: 10, // Space between radio buttons horizontally
                      runSpacing: 5, // Space between rows
                      children:
                          _emotions.map((emotion) {
                            // this loops through the list of emotions, for each emotion it creates a radio button
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),

                              child: SizedBox(
                                width: 170,
                                child: RadioListTile<String>(
                                  title: Text(
                                    emotion,
                                  ), // displays the emotion's name
                                  value: emotion,
                                  // groupvalue is used to control which radio button is selected
                                  // this switch the emotion based on the user's choice
                                  groupValue: _selectedEmotion,
                                  onChanged: (String? value) {
                                    // onchanged triggers the radio button is clicked
                                    setState(() {
                                      _selectedEmotion = value;
                                    });
                                  },
                                  // positions the icon on the left side of text
                                  controlAffinity:
                                      ListTileControlAffinity
                                          .leading, // Moves the radio button to the right side
                                  secondary: Icon(
                                    _getEmotionIcon(emotion),
                                    size: 20, // Adjust the size as needed
                                  ),
                                  contentPadding:
                                      EdgeInsets.zero, // Removes extra padding
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15), // Add spacing between the two containers
            // this columns the intensity of the emotion of the user
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10), // Add padding for consistency
                  child: Text(
                    "How intense was the emotion?",
                    style: TextStyle(
                      fontSize: 15, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Make it bold
                      color: Colors.black, // Adjust color as needed
                    ),
                  ),
                ),

                // slider container
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 255, 218, 108),
                  ),
                  // slider method
                  child: Slider(
                    value: _emotionIntensity, // Ensure it's not nullable
                    min: 0, // initial minimum value 0.0
                    max: 10, // maximum value 10.0
                    divisions: 10, // divides the slider into 10 points
                    label: _emotionIntensity.round().toString(), // Fixed typo
                    onChanged: (double value) {
                      setState(() {
                        _emotionIntensity = value; // Update the state
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 15), // Add spacing between the two containers
            Divider(thickness: 2, color: Color(0xFF5B4689)),
            SizedBox(height: 10),

            // Dropdown for weather
            // this column shows the list of weather of the user experiencing
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10), // Add padding for consistency
                  child: Text(
                    "What's the weather today?",
                    style: TextStyle(
                      fontSize: 15, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Make it bold
                      color: Colors.black, // Adjust color as needed
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity, // Takes full width of the parent
                  height: 80, // Adjust height as needed
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Color.fromARGB(255, 255, 218, 108),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        // labelText: "How's the weather today?",
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
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),

                      child: DropdownButtonFormField<String>(
                        value:
                            _selectedWeather, // holds the currently selected weather
                        // changes the value when the user clicked other option
                        onChanged: (String? value) {
                          setState(() {
                            // setState() updates the changes from options selected by the user
                            _selectedWeather = value;
                          });
                        },

                        // list of weathers
                        // .map is used to loops through each weather type
                        items:
                            _weathers.map(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(), // toList() this converts the string list from the _emotions into list of widgets

                        onSaved: (newValue) {
                          print("Dropdown onSaved method triggered");
                        },
                      ),
                      //),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // this is like the alert box of the mood tracker form
            // updates the user's information whenever it hit the submit or reset button
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 218, 108),
                borderRadius: BorderRadius.circular(15),
              ),
              child:
                  _userValues == null
                      ? const Text(
                        "No data submitted yet.",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${_userValues!.name}"),
                          if (_userValues!.nickname != null)
                            Text("Nickname: ${_userValues!.nickname}"),
                          Text("Age: ${_userValues!.age}"),
                          Text(
                            "Exercised Today?: ${_submittedExercisedToday ? "Stay Fit!" : "Exercise Today!"}",
                          ),
                          Text(
                            "Emotion: $_submittedEmotion ${_submittedEmotionIntensity.toStringAsFixed(1)}/10.0",
                          ),
                          Text("Weather: $_submittedWeather"),
                        ],
                      ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5B4689), // Background color
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
                    child: Text('Submit'),
                  ),

                  // Reset Button
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5B4689), // Background color
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
                    child: Text('Reset'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
