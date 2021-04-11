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

  Future<bool> finnesChatListe() async {
    try {
      final liste = await db.collection(
          'brukere/' + _auth.currentUser.displayName + '/chats').get();
      if (liste.docs.length == 0) {
        return false;
      }
      else
        return true;
    } catch (e) {
      throw e;
    }
  }

  Future<void> opprettChatteListeMellomBrukere(String navn,
      String melding) async {
        var finnes = await finnesChatListe();
        if (finnes) {
          await sendMelding(navn, melding);
        }
        else {
          await db.collection('brukere/').doc(_auth.currentUser.displayName)
              .collection('/chats/').doc(navn).set({
                'text': melding,
                'sent': Timestamp.now(),
                'userId': _auth.currentUser.uid,
                'brukeNavn': _auth.currentUser.displayName,
                'motakerNavn': navn
              });

          await db.collection('brukere/').doc(navn)
              .collection('/chats/').doc(_auth.currentUser.displayName).set({
                'text': melding,
                'sent': Timestamp.now(),
                'userId': _auth.currentUser.uid,
                'brukeNavn': _auth.currentUser.displayName,
                'motakerNavn': navn
              });
          }
      }

      Future<bool> finnesMeldingerMellomMotakerOgSender(String navn) async {
        try {
          final liste = await db.collection(
              'brukere/' + _auth.currentUser.displayName + '/chats/' + navn + '/meldinger').get();
              if (liste.docs.length == 0) {
                return false;
              }
              else
                return true;
        } catch (e) {
          throw e;
        }
      }

      Future<void> sendMelding(String navn, String melding) async {
        db.collection('brukere/').doc(_auth.currentUser.displayName)
            .collection('/chats/').doc(navn).collection('/meldinger').add({
              'text': melding,
              'sent': Timestamp.now(),
              'userId': _auth.currentUser.uid,
              'brukeNavn': _auth.currentUser.displayName,
              'motakerNavn': navn
            });

        db.collection('brukere/').doc(navn)
            .collection('/chats/').doc(_auth.currentUser.displayName).collection('/meldinger').add({
              'text': melding,
              'sent': Timestamp.now(),
              'userId': _auth.currentUser.uid,
              'brukeNavn': _auth.currentUser.displayName,
              'motakerNavn': navn
            });
      }

      Stream<QuerySnapshot> hentMeldiner(String navn) {
        return db
            .collection('brukere/').doc(_auth.currentUser.displayName).collection('/chats/')
            .doc(navn).collection('/meldinger')
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
}