import 'package:flutter/material.dart';
import 'form_sample.dart';

class UserInteractivitySample extends StatefulWidget {
  const UserInteractivitySample({super.key});

  @override
  State<UserInteractivitySample> createState() =>
      _UserInteractivitySampleState();
}

class _UserInteractivitySampleState extends State<UserInteractivitySample> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BeeWell.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "Mood Tracker",
        //     style: TextStyle(
        //       fontFamily: 'Poppins',
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   foregroundColor: Colors.white,
        // ),
        backgroundColor: Colors.transparent, // Set the background color here
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Keeps padding unchanged
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Wrapping image inside a Container to control size without affecting spacing
                SizedBox(height: 75),
                Container(
                  height: 70, // Adjusted height
                  width: 300, // Adjusted width
                  alignment: Alignment.center,
                  //Keeps it centered
                  child: Image.asset(
                    'assets/icon.png',
                    fit: BoxFit.contain, // Ensures it doesn't stretch
                  ),
                ),

                // SizedBox(height: 20), // Keeps spacing between the image and form
                // Your form widget
                FormSample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
