import 'package:chat_app_flutter/blocs/chatside_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bobler med ulik farge hvor meldingene skrives.  Egne meldinger kommer på høyre side, de andre kommer på venstre side.
class MessageBuble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool likt;
  final String navnMelding;
  final String mottakersNavn;

  MessageBuble(this.message, this.isMe, this.likt, this.navnMelding, this.mottakersNavn);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        //Flexible(
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: Container(
            decoration: BoxDecoration(
                color: isMe ? Colors.lime[300] : Colors.orangeAccent[100],
                borderRadius: isMe
                    ? BorderRadius.circular(12.0)
                    : BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: isMe
                ? EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.3,
                    top: 20,
                    right: 10)
                : EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3,
                    top: 10,
                    left: 10),
            child: isMe
                ? Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              message,
                              textAlign: TextAlign.right,
                            ),
                          )),
                        ],
                      ),
                      BlocBuilder<ChatsideBloc, ChatsideState>(
                          builder: (context, state) {
                        return likt? Positioned(
                          bottom: -8,
                          right: 0,
                          child: Container(
                            height: 10,
                            width: 10,
                            child: Icon(
                              Icons.thumb_up_alt_sharp,
                              color: Colors.green,
                            ),
                          ),
                        ):
                          Container();

                        return Container();
                        }
                      )
                    ],
                    overflow: Overflow.visible,
                  )
                : Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(message),
                          )),
                        ],
                      ),
                      BlocBuilder<ChatsideBloc, ChatsideState>(
                          builder: (context, state) {
                          return !likt? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              // alignment: Alignment.bottomLeft,

                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ChatsideBloc>(context).add(KlikkerLikeKnapp(navnMelding,mottakersNavn));

                                },
                                icon: const Icon(Icons.thumb_up_alt_outlined),
                                color: Colors.grey[400],
                              ),
                            ),
                          ):
                              Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              // alignment: Alignment.bottomLeft,

                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ChatsideBloc>(context).add(KlikkerLikeKnapp(navnMelding,mottakersNavn));

                                },
                                icon: const Icon(Icons.thumb_up_alt_outlined),
                                color: Colors.green[400],
                              ),
                            ),
                          );
                        }
                      )
                    ],
                    overflow: Overflow.visible,
                  ),
          ),
        ))
      ],
    );
  }
}
