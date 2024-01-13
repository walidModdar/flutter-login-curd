import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  
  Future addPlayer(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc()
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getPlayer(String name) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .where("name", isEqualTo: name)
        .get();
  }


  Future DeletePlayer(String id) async {
    return await FirebaseFirestore.instance
        .collection("players")
        .doc(id)
        .delete();
  }

  Future<QuerySnapshot> getAllPlayers() async {
    return await FirebaseFirestore.instance
    .collection("players")
    .get();
  }
}
