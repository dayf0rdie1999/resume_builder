import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_builder/module/Contact.dart';
import 'package:resume_builder/module/project.dart';
import 'package:resume_builder/module/work.dart';


class StoreService {

  // Todo: Initializing the firestore
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  // Todo: Creating a function get the admin code
  Future<Map?> getAdminCode() async {
    return _store.collection("admin").doc("passcode").get()
        .then((data) {
      if (data.exists) {
        return {"result": data.data()!["code"]};
      }
    }).catchError((onError) => {"Error": onError});
  }

  Future<Map<String,dynamic>?> getAdminProfile() async {
    return await _store.collection("admin").doc("profile").get()
    .then((result) {
      if (result.exists) {
        return result.data() as Map<String,dynamic>;
      }
    }).catchError((onError) => {"Error": onError});
  }

  // Todo: get specific data for a specific field key
  Future<String> getAdminSpecificData(String codeKey) async {
    return await _store.collection("admin").doc("profile").get()
        .then((result) {
          if (result.exists) {
            return result.data()?["$codeKey"];
          }})
        .catchError((onError) => onError);
  }


  Future<String?> updateData(String collectionName, String documentName, String key, String value) async {

    _store.collection('$collectionName').doc('$documentName').update({
      '$key': value,
    })
      .then((value) => null)
      .catchError((onError) => onError);

  }

  Future<Map<String,dynamic>?> getAdminEducation() async {
    return await _store.collection("adminEducation").doc("Bachelor").get()
        .then((result) {
          if (result.exists) {
            return result.data() as Map<String,dynamic>;
          }
        }).catchError((error) => {"Error": error});
  }

  Future<String?> addProject(ProjectModule project) async {
    await _store.collection("adminProjects").add({
      "title": project.title,
      "projectSkills": project.projectSkills,
      "position": project.position,
      "mainPoints": project.mainPoints,
    }).then((value) => null).catchError((onError) => onError);
  }

  Stream<QuerySnapshot> getProjects() {
    return _store.collection("adminProjects").snapshots();
  }

  Future<String?> deleteProject(String id) async {
    await _store.collection("adminProjects").doc(id).delete()
        .then((result) => null)
        .catchError((onError) => onError);
  }

  Future<String?> updateProject(String id,ProjectModule project) async {
    await _store.collection("adminProjects").doc(id).update({
      "title": project.title,
      "projectSkills": project.projectSkills,
      "position": project.position,
      "mainPoints": project.mainPoints,
    })
        .then((value) => null)
        .catchError((onError) => onError);
  }

  // Todo: reading the work data on firestore
  Stream<QuerySnapshot> getWork() {
    return _store.collection("adminWorks").snapshots();
  }

  Future<String?> updateWork(WorkModule work) async {
    await _store.collection("adminWorks").doc(work.workId).update({
      "companyName": work.companyName,
      "fromDate": work.fromDate,
      "location": work.location,
      "mainPoints": work.mainPoints,
      "position": work.position,
      "toDate": work.toDate,
    })
      .then((value) => null)
      .catchError((onError) => onError);
  }

  Future<String?> deleteWork(WorkModule work) async {
    await _store.collection("adminWorks").doc(work.workId).delete()
      .then((value) => null)
      .catchError((onError) => onError);
  }

  Future<String?> addWork(WorkModule work) async {
    await _store.collection("adminWorks").add({
      "companyName": work.companyName,
      "fromDate": work.fromDate,
      "location": work.location,
      "mainPoints": work.mainPoints,
      "position": work.position,
      "toDate": work.toDate,
    }).then((value) => null).catchError((onError) => onError);
  }

  Future<String?> addContactMessage(ContactInfo contact) async {
    await _store.collection("adminContacts").add({
      "companyName": contact.company,
      "companyLink": contact.companyLink,
      "message": contact.message,
    }).then((value) => null).catchError((onError) => onError);
  }

  Stream<QuerySnapshot> getContactMessages() {
    return _store.collection("adminContacts").snapshots();
  }

  Future<String?> deleteContact(String contactId) async {
    await _store.collection("adminContacts").doc(contactId).delete()
        .then((value) => null)
        .catchError((onError) => onError);
  }

}