import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/service.dart';
import 'package:flutter_login/players.dart';

class ReadData extends StatefulWidget {
  const ReadData({Key? key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  String? name, club, number, salary;
  final textController = TextEditingController();

  Future<void> searchUser(String name) async {
    try {
      final querySnapshot = await Service().getPlayer(name);
      final playerData = querySnapshot.docs.first;

      setState(() {
        name = playerData['name'];
        club = playerData['club'];
        salary = playerData['salary'];
        number = playerData['number'];
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "User Not Found",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 22.0,
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
                      PlayersListPage(), 
                ),
              );             
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
        title: const Text("Search"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 107, 189, 255),
              Color.fromARGB(255, 184, 195, 215)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Write Player Name",
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 65, 65),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Name',
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                searchUser(textController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (club != null || number != null || salary != null) ...[
              const SizedBox(height: 40.0),
              _buildPlayerDetail("Club ", club),
              _buildPlayerDetail("Number ", number),
              _buildPlayerDetail("Salary ", "$salary DH"),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDetail(String label, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3, // Adjust the elevation for a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Rounded corners for the card
        side: BorderSide(
            color: Colors.grey, width: 0.5), // Border color and width
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label:",
              style: const TextStyle(
                color: Color.fromARGB(255, 102, 102, 102),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${value ?? 'N/A'}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
