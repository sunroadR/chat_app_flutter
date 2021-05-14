import 'package:chat_app_flutter/blocs/chatside_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chatside_bloc.dart';

class SearchAppBar extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _SearchAppBarState();
  }
}

//Appbar hvor man søker opp andre brukere
class _SearchAppBarState extends State<SearchAppBar> {
  final _myController = TextEditingController();
  String _brukerNavn = '';

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _startsideBloc = BlocProvider.of<ChatsideBloc>(context);
    
    return BlocListener <ChatsideBloc, ChatsideState>(
        listener: (context, state) {
          if (state is BrukerFinnesIkkeState) {
            return  Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.amber,
                content: Text('Brukernavnet finnes ikke',style: TextStyle(
                  color: Colors.black, fontSize: 20
                ),),
              ),
            );
          }
        },
        
        child: BlocBuilder<ChatsideBloc, ChatsideState>(
            builder: (context, state) {
              return  LayoutBuilder(
                  builder: (context, constraints) {
                    if (state is ChatsideInitialState ||state is BrukerFinnesIkkeState
                    || state is HarKlikket){
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: AppNavn('Chat App')),
                          Container(
                            width: 30,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: (() {
                                  if (state is ChatsideInitialState||state is BrukerFinnesIkkeState 
                                      || state is SnakkeMedState) {
                                      _startsideBloc.add(OpenForSearch());
                                  }
                                }),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    if(state is SnakkeMedState){
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppNavn(state.mottakersNavn),
                            Container(
                              width: 30,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (() {
                                    if (state is ChatsideInitialState||state is BrukerFinnesIkkeState
                                        || state is SnakkeMedState) {
                                      _startsideBloc.add(OpenForSearch());
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      if (state is SearchFieldOpen|| state is SnakkeMedState||state is HarKlikket) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppNavn('Chat App'),
                            SizedBox(width: 5,),
                            SearchField(),
                            Container(
                              width: 30,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (() {
                                    if (state is SearchFieldOpen||  state is SnakkeMedState ){
                                      _startsideBloc.add(FinnesBruker(_myController.text));
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      if(state is MeldingSendtState){
                        return  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppNavn(state.mottakersNavn),
                            Container(
                              width: 30,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (() {
                                    if (state is ChatsideInitialState||state is BrukerFinnesIkkeState
                                        || state is SnakkeMedState|| state is MeldingSendtState) {
                                      _startsideBloc.add(OpenForSearch());
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    if(state is HarKlikket){
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppNavn(state.mottakersNavn),
                          Container(
                            width: 30,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: (() {
                                  if (state is ChatsideInitialState||state is BrukerFinnesIkkeState
                                      || state is SnakkeMedState|| state is MeldingSendtState) {
                                    _startsideBloc.add(OpenForSearch());
                                  }
                                }),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    }
                  );

            }

        )
      );
    }

    Widget AppNavn(String navn) {
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(
            navn,
            style: TextStyle(
              fontSize: 18,
            )
        ),
      );
    }

    Widget SearchField() {
      return Container(
        height: 30,
        width: 200,
        child: Visibility(
          visible: true,
          child: TextField(
            controller: _myController,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                )),
           ),
        ),
      );
    }
  }

