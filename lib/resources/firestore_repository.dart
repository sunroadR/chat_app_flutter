import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class FirestoreProvider {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  /// Registrerer brukerm, ved å opprette et dokument,
  /// hvor brukernavnet er navnet på dokumentet
  Future <void> registrerBruker(String brukerNavn) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInAnonymously();
      //Dokumentet inneholder brukernavn og UserId
      db.collection('brukere/').doc(brukerNavn).set({
        'userId': _auth.currentUser.uid,
        'brukerNavn': brukerNavn.trim(),
      });
      userCredential.user.updateProfile(displayName: brukerNavn.trim());
    } on PlatformException catch (error) {}
  }

  // Sjekker om brukernavn er i bruk
  Future<bool> brukerNavnFinnes(String navn) async {
    try {
      CollectionReference brukere = db.collection('brukere/');
      var docu = await brukere.doc(navn).get();
      return docu.exists;
    } catch (e) {
      throw e;
    }
  }
      Future<void> sendMelding(String navn, String melding) async {
       // Gir meldingen en unik id,
        var navnMelding= db.collection('brukere/').doc(_auth.currentUser.displayName)
            .collection('/chats/').doc(navn).collection('/meldinger').doc().id;

        // legger meldingen inn i sender list over meligder med motaker
        DocumentReference sentMelding=db.collection('brukere/').doc(_auth.currentUser.displayName)
            .collection('/chats/').doc(navn).collection('/meldinger').doc(navnMelding);
          sentMelding.set({
              'text': melding,
              'sent': Timestamp.now(),
              'userId': _auth.currentUser.uid,
              'brukeNavn': _auth.currentUser.displayName,
              'motakerNavn': navn,
               'navnMelding':navnMelding,
               'likt':false,
          });
        // legger meldingen inn i motakers list over meligder med sender
        DocumentReference motattMelding=db.collection('brukere/').doc(navn)
            .collection('/chats/').doc(_auth.currentUser.displayName)
            .collection('/meldinger/').doc(navnMelding);
            motattMelding.set({
              'text': melding,
              'sent': Timestamp.now(),
              'userId': _auth.currentUser.uid,
              'brukeNavn': _auth.currentUser.displayName,
              'motakerNavn': navn,
              'navnMelding':navnMelding,
              'likt':false,
            });
      }

      Stream<QuerySnapshot> hentMeldinger(String navn) {
        return db
            .collection('brukere/').doc(_auth.currentUser.displayName)
            .collection('/chats/').doc(navn).collection('/meldinger/')
            .orderBy(
              'sent',
              descending: true,
            )
            .snapshots();
      }

      String hentUserId()  {
      var  userId = _auth.currentUser.uid.toString();
        return userId;
      }

      bool finnesBrukerId(){
      if(_auth.currentUser == null){
        return false;
      }
      else
        return true;
  }


  Stream<void> oppDaterLike(String meldingNavn,String sendersNavn) {

    db.collection('brukere').doc(_auth.currentUser.displayName)
        .collection('chats').doc(sendersNavn)
        .collection('meldinger').doc(meldingNavn)
        .update({
          'likt': true,
        }).then((value) => print('Likt Oppdatert '))
    .catchError((error)=>print('Feilet med å like  $error'));

     db.collection('brukere').doc(sendersNavn).collection('chats')
       .doc(_auth.currentUser.displayName).collection('meldinger').doc(meldingNavn)
     ..update({
       'likt': true,

     }).then((value) => print('Likt Oppdatert  '))
         .catchError((error)=>print('Feilet med å like  $error'));
  }

  String hentDisplyName()  {
    return  _auth.currentUser.displayName;
  }

}