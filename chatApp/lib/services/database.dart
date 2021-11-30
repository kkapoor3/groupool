import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }
  Future<void> addProfileInfo(String email, userData) async {
    Firestore.instance
        .collection("profile")
        .add(userData)
        .catchError((e) {
      print(e.toString());

    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  getProfileInfo(String email) async {
    return Firestore.instance
        .collection("profile")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<bool> addTripRoom(tripData, tripId) {
    Firestore.instance
        .collection("Trips")
        .document(tripId)
        .setData(tripData)
        .catchError((e) {
      print(e);
    });
  }

  Future<bool> addChatRoom2(projectRoom, projectId) {
    Firestore.instance
        .collection("projectRoom")
        .document(projectId)
        .setData(projectRoom)
        .catchError((e) {
      print(e);
    });
  }


  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getTrips(String tripId) async{
    return Firestore.instance
        .collection("Trips")
        .document(tripId)
        .collection("trips")
        .orderBy('from')
        .snapshots();
  }

  getAllTrips() async{
    return Firestore.instance
        .collection("AllTrips")
        .orderBy('from')
        .snapshots();
  }

  getAllProfiles() async{
    return Firestore.instance
        .collection("profile")
        .orderBy('leavingTime')
        .snapshots();
  }



  Future<void> addMessage(String chatRoomId, chatMessageData){

    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  Future<void> addTrip(String tripId, tripData){

    Firestore.instance.collection("Trips")
        .document(tripId)
        .collection("trips")
        .add(tripData).catchError((e){
      print(e.toString());
    });
  }

  Future<void> updateCount(String poolId,usersCount){

    Firestore.instance.collection("projectRoom")
        .document(poolId)
        .updateData({"usersCount":usersCount}).catchError((e){
      print(e.toString());
    });
  }

  Future<void> addtoAllTrips(tripData) async {
    Firestore.instance
        .collection("AllTrips")
        .add(tripData)
        .catchError((e) {
      print(e.toString());
    });
  }
  
  

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getChats2(String projectId) async{
    return Firestore.instance
        .collection('projectRoom')
        .document(projectId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }
  getUsers(String projectId) async{
    return await Firestore.instance
        .collection("projectRoom")
        .where('projectId', isEqualTo: projectId ).getDocuments();

  }


  Future<void> addMessage2(String projectId, chatMessageData){

    Firestore.instance.collection("projectRoom")
        .document(projectId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getUserChats2(String itIsMyName) async {
    return await Firestore.instance
        .collection("projectRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

}
