import 'package:chat_app_flutter/blocs/chatside_bloc.dart';
import 'package:chat_app_flutter/skjermbilder/ui/meldinger.dart';
import 'package:chat_app_flutter/skjermbilder/ui/message_buble.dart';
import 'package:chat_app_flutter/skjermbilder/ui/ny_melding.dart';
import 'package:chat_app_flutter/skjermbilder/ui/search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/meldinger.dart';

class ChatSide extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChatSide());
  }

  @override
  _ChatSideState createState() => _ChatSideState();
}

//Side hvor man søker opp andre brukere, og sender meldinger
class _ChatSideState extends State<ChatSide> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsideBloc,ChatsideState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: SearchAppBar(),
              automaticallyImplyLeading: false
            ),
            body: BlocBuilder<ChatsideBloc,ChatsideState>(
              builder: (context,state){
                if(state is ChatsideInitialState 
                    || state is SearchFieldOpen ||state is BrukerFinnesIkkeState) {
                  return Container(
                    color: Colors.lime[200],
                    child: Center(
                       child: Text('Søk etter noen og sende melding til',
                       style: TextStyle(fontSize: 18.0),),
                    ),
                  );
                }
                if(state is SnakkeMedState){
                  return  Column(
                    children: [
                      Meldinger(),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: NyMelding(state.mottakersNavn)),
                    ],
                  );
                }
                if(state is MeldingSendtState){
                  return Column(
                    children: [
                      Meldinger(),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: NyMelding(state.mottakersNavn)
                      )
                    ],
                  );
                }
              },
           )
        );
      }
    );
  }
}
