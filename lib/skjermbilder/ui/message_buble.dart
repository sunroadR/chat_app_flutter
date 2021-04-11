import 'package:flutter/material.dart';

//Bobler med ulik farge hvor meldingene skrives.  Egne meldinger kommer på høyre side, de andre kommer på venstre side.
class MessageBuble extends StatelessWidget {
  final String message;
  final bool isMe;

  MessageBuble(this.message, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end :
      MainAxisAlignment.start,
      children: [
        Container(color: Colors.indigoAccent,),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.lime[300] : Colors.orangeAccent[100],
              borderRadius: BorderRadius.circular(12),
            ),
            width: 140,
            height: 40,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16
            ),
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),

            child: isMe ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(message),
                ]
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(message)
                ],
              ),
          ),
        ],
      );
    }
}