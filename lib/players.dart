import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/new_player.dart';
import 'package:flutter_login/search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'service.dart'; 

class PlayersListPage extends StatefulWidget {
  const PlayersListPage({Key? key}) : super(key: key);

  @override
  _PlayersListPageState createState() => _PlayersListPageState();
}

class _PlayersListPageState extends State<PlayersListPage> {
  Service service = Service(); // Instance de votre classe Service
  late Future<QuerySnapshot> playersFuture;

  @override
  void initState() {
    super.initState();
    playersFuture = service.getAllPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
           IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ReadData(), 
                ),
              );             
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(), // Dirige vers ProfileScreen
                ),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
        title: const Text('Liste des Joueurs'),
        backgroundColor: Colors.blue,
        elevation: 4, // Épaisseur de l'ombre sous l'appBar
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: playersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final players = snapshot.data!.docs;

            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final playerData =
                    players[index].data() as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      playerData['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Club: ${playerData['club']} ',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          'Number: ${playerData['number']}',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Salary: ${playerData['salary']} DH',
                          style: TextStyle(color: Colors.red),
                        ),

                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Appeler la fonction pour supprimer le joueur ici
                        final playerId = players[index].id;
                        service.DeletePlayer(playerId);
                         Fluttertoast.showToast(
                          msg: "Deleted Successfully!!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                          Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                PlayersListPage(), // Dirige vers ProfileScreen
                          ),
                        );
                        
                    
                      },
                      
                    ),

                    // ... Autres éléments du ListTile
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
