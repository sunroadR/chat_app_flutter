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
            //Flexible(
              Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isMe ? Colors.lime[300] : Colors.orangeAccent[100],

                  borderRadius: BorderRadius.circular(12),
                ),

                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16

                ),

                  margin: isMe? EdgeInsets.only(left: 60,top: 20,right: 10):
                          EdgeInsets.only(right: 60,top: 10,left: 10),
                
                child:  isMe ? Row(
                  children: [
                          Expanded(child: Text(message)),
                  ],
                ):
                Row(
                  children: [
                    Expanded(child: Text( message)),
                         ],
                       ),






              ),
            ),
          ],

    );
    }
}