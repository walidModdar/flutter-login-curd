import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/service.dart';
import 'package:flutter_login/players.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController instances for each field
  TextEditingController playernamecontroller = TextEditingController();
  TextEditingController clubnamecontroller = TextEditingController();
  TextEditingController playernumbercontroller = TextEditingController();
  TextEditingController playersalarycontroller = TextEditingController();

  // Function to upload data
  void uploadData() async {
    // Validate form data before uploading
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> uploaddata = {
        "club": clubnamecontroller.text,
        "name": playernamecontroller.text,
        "number": playernumbercontroller.text,
        "salary": playersalarycontroller.text,
      };

      await Service().addPlayer(uploaddata);
      Fluttertoast.showToast(
        msg: "Data Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PlayersListPage(), // Dirige vers ProfileScreen
                ),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
        title: const Text("Players"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20.0),

              // Player Name TextField
              TextFormField(
                controller: playernamecontroller,
                decoration: InputDecoration(
                  labelText: 'Player Name *', // Label for the field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Player Name';
                  }
                  return null;
                },
              ),

              // Player Club TextField
              TextFormField(
                controller: clubnamecontroller,
                decoration: InputDecoration(
                  labelText: 'Player Club *', // Label for the field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Player Club';
                  }
                  return null;
                },
              ),

              // Player Number TextField
              TextFormField(
                controller: playernumbercontroller,
                decoration: InputDecoration(
                  labelText: 'Player Number *', // Label for the field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Player Number';
                  }
                  return null;
                },
              ),

              // Player Salary TextField
              TextFormField(
                controller: playersalarycontroller,
                decoration: InputDecoration(
                  labelText: 'Player Salary *', // Label for the field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Player Salary';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0),

              // Create button
              ElevatedButton(
                onPressed: () {
                  uploadData();
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayersListPage(), // Dirige vers ProfileScreen
                    ),
                  );      
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
