import 'package:flutter/material.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCom extends StatefulWidget {
  CreateCom({ Key? key,required this.box }) : super(key: key);

  String box;

  @override
  _CreateComState createState() => _CreateComState();
}

class _CreateComState extends State<CreateCom> {

  final messageController = TextEditingController();
  late String titreCom;
  late String textCom;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nouveau Commentaire"),),
      body: SlidingUpPanel(
      panel: Center(
        child: Column(
          children: [
            const Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Titre du commentaire")
              ),
            ),
            Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    textCom = value;
                  },
                ),
              ),
            ),
            const Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contenu")
                ),
              ),
            
            Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    textCom = value;
                  },
                ),
              ),
            ),
            TextButton(onPressed: (){
              messageController.clear();
              User? user = FirebaseAuth.instance.currentUser;
              if(user != null){
                _firestore.collection("messages").add({
                        "timestamp" : FieldValue.serverTimestamp(),
                                "text" : text,
                                "sender" : user.email,
                            });

            }, child: Text("Publier"))
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset('images/photoBoite1.jpg'),
          Card(
            child : Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(widget.box,style: TextStyle(fontSize: 25 ),),
            ),
          ),
          
        ]
      ),
    ),
    );
  }
}




