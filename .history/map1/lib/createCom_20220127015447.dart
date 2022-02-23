

import 'package:flutter/material.dart';
import 'package:map1/components/RoundedButton.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

class CreateCom extends StatefulWidget {
  CreateCom({ Key? key,required this.box, required this.image }) : super(key: key);
  String image;
  String box;

  @override
  _CreateComState createState() => _CreateComState();
}

class _CreateComState extends State<CreateCom> {

  final messageController = TextEditingController();
  final messageController2 = TextEditingController();
  late String titreCom;
  late String textCom;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ScrollController  scoll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNiceBlue,
      appBar: AppBar(
        backgroundColor: kNiceBlue,
        title: Text("Nouveau Commentaire"),),
      body: SlidingUpPanel(
        
        color: kNiceBlue,
        
      panel:
       Center(
        child: Column(
          children: [
            const Card(
              color: kspecialbleu,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Titre du commentaire")
              ),
            ),
            Card(
              color: klittleorange,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: messageController,
                  onChanged: (value){
                    
                    textCom = value;
                  },
                ),
              ),
            ),
            const Card(
              color: kspecialbleu,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contenu")
                ),
              ),
            
            Card(
              color: klittleorange,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: messageController2,
                  onChanged: (value){
                    textCom = value;
                  },
                ),
              ),
            ),
            RoundedButton(
              colour: kgreybleu,
              title: "Publier",
              onPressed: (){
                messageController.clear();
                messageController2.clear();
                User? user = FirebaseAuth.instance.currentUser;
                if(user != null){
                  _firestore.collection("commentaires").add({
                  "timestamp" : FieldValue.serverTimestamp(),
                  "text" : textCom,
                  "sender" : user.email,
                  "boite" : widget.box,
                  });
                } 
              },
            )
          ],
        ),
        
      ),
      collapsed: Container(
        color: kNiceBlue,
        child: Center(
          child: Text(
            "Commentaire",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(widget.image),
              Card(
                child : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(widget.box,style: TextStyle(fontSize: 25 ),),
                ),
              ),
            ]
          ),
          SizedBox()
          Text("Adresse : dede")
        ],
      ),
    ),
    );
  }
}




