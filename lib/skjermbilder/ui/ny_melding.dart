import 'package:chat_app_flutter/blocs/chatside_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NyMelding extends StatefulWidget {
  final String mottakersNavn;
  NyMelding(this.mottakersNavn);

  @override
  State<StatefulWidget> createState() {
    return _NyMeldingState(mottakersNavn);
  }
}

//Felt for å skrive ny melding på chatsiden
class _NyMeldingState extends State<NyMelding> {
  final String _mottakersNavn;
  _NyMeldingState(this._mottakersNavn);

  String get mottakersNavn => _mottakersNavn;

  @override
  Widget build(BuildContext context) {
    final _controller = new TextEditingController();

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    _controller.clear();

    return BlocBuilder<ChatsideBloc, ChatsideState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send en melding..'),
                  )
                ),
                IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(Icons.send),
                    onPressed: () {
                      _controller.text.trim().isEmpty ? null :
                      BlocProvider.of<ChatsideBloc>(context).add(
                        SendMelding(_controller.text,mottakersNavn)
                      );
                    }
                )
              ],
            ),
          );
        }
        );
  }
}
