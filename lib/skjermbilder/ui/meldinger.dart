import 'package:chat_app_flutter/resources/firestore_repository.dart';
import 'package:chat_app_flutter/skjermbilder/ui/message_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/chatside_bloc.dart';

//Utskrift av meldinger mellom to brukere.
class Meldinger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chatBloc = BlocProvider.of<ChatsideBloc>(context);

    return BlocBuilder<ChatsideBloc, ChatsideState>(
        builder: (context, state) {
         return FutureBuilder(builder: (ctx, futureSnapShot) {
            if (futureSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is MeldingSendtState) {
              return StreamBuilder(
                  stream: _chatBloc.henteMeldinger(state.mottakersNavn),
                  builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {

                    if (chatSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final chatDocs = chatSnapshot.data.docs;
                    ;                  return chatDocs.isNotEmpty?Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: chatDocs.length,
                        itemBuilder: (ctx, index) =>
                            MessageBuble(
                              chatDocs[index]['text'],
                              chatDocs[index]['userId'] == _chatBloc.hentUserId(),
                              chatDocs[index]['likt'],
                              chatDocs[index]['navnMelding'],
                              chatDocs[index]['brukeNavn'],

                            ),
                      ),
                    ):
                    Container();
                  });



            }

            if(state is SnakkeMedState ) {
              return StreamBuilder(
                stream: _chatBloc.henteMeldinger(state.mottakersNavn),
                builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {

                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatDocs = chatSnapshot.data.docs;
;                  return chatDocs.isNotEmpty?Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: chatDocs.length,
                        itemBuilder: (ctx, index) =>
                          MessageBuble(
                            chatDocs[index]['text'],
                            chatDocs[index]['userId'] == _chatBloc.hentUserId(),
                            chatDocs[index]['likt'],
                            chatDocs[index]['navnMelding'],
                            chatDocs[index]['brukeNavn'],

                          ),
                      ),
                  ):
                  Container();
                });
            }
            if(state is HarKlikket ) {
              return StreamBuilder(
                  stream: _chatBloc.henteMeldinger(state.mottakersNavn),
                  builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {

                    if (chatSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }


                    final chatDocs = chatSnapshot.data.docs;
                    return chatDocs.isNotEmpty?Flexible(
                                        child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        itemCount: chatDocs.length,
                        itemBuilder: (ctx, index) =>
                            MessageBuble(
                              chatDocs[index]['text'],
                              chatDocs[index]['userId'] == _chatBloc.hentUserId(),
                              chatDocs[index]['likt'],
                              chatDocs[index]['navnMelding'],
                              chatDocs[index]['brukeNavn'],

                            ),
                      ),
                    ):

                    Container();
                  });
            }


          });
      }
    );
    }


}
