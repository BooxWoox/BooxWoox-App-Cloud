import 'package:bookollab/State/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_select/smart_select.dart';
import 'choices.dart' as choices;
import 'genreAPI.dart';
import 'genreList.dart';

class Filters extends StatefulWidget {
  static String id = 'filters';

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<String> _car = [];
  List<String> _smartphone = [];
  List<String> _days = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFCC00),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SmartSelect.multiple(
                      title: 'Price',
                      value: _car,
                      onChange: (selected) =>
                          setState(() => _car = selected.value),
                      choiceItems: choices.price,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: true,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://bit.ly/3p0LpYh',
                            ),
                          ),
                        );
                      },
                      choiceType: S2ChoiceType.checkboxes,
                      modalType: S2ModalType.popupDialog,
                      modalHeaderStyle: S2ModalHeaderStyle(
                        backgroundColor: Color(0xFFFFCC00),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(indent: 20),
                    SmartSelect.single(
                      title: 'Sort',
                      value: _car,
                      onChange: (selected) =>
                          setState(() => _car = selected.value),
                      choiceItems: choices.sort,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: true,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgqb_VJ-0Pl7X7MR2mapyKRRuuSAHC8bCfnnpTPKvzbgGRRiiIcSwp6RY94bTH6dqSqTI&usqp=CAU',
                            ),
                          ),
                        );
                      },
                      choiceType: S2ChoiceType.switches,
                      modalType: S2ModalType.bottomSheet,
                      modalHeaderStyle: S2ModalHeaderStyle(
                        backgroundColor: Color(0xFFFFCC00),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(indent: 20),
                    Consumer(builder: (context, watch, child) {
                      final genres = watch(allGenres);
                      if (genres.data.value == null) {
                        return LinearProgressIndicator();
                      }
                      return SmartSelect.multiple(
                        title: 'Genre',
                        value: _car,
                        onChange: (selected) =>
                            setState(() => _car = selected.value),
                        // choiceItems: S2Choice.listFrom<String, Map>(
                        //   source: choices.genre,
                        //   value: (index, item) => item['value'],
                        //   title: (index, item) => item['title'],
                        //   // group: (index, item) => item['brand'],
                        // ),

                        choiceItems: genres.data.value
                            .map((e) => S2Choice(value: e, title: e))
                            .toList(),

                        tileBuilder: (context, state) {
                          return S2Tile.fromState(
                            state,
                            isTwoLine: true,
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://assets.ltkcontent.com/images/31018/book-genres_0066f46bde.jpg',
                              ),
                            ),
                          );
                        },

                        choiceType: S2ChoiceType.checkboxes,
                        modalType: S2ModalType.fullPage,
                        modalHeaderStyle: S2ModalHeaderStyle(
                          backgroundColor: Color(0xFFFFCC00),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        modalFilter: true,
                      );
                    }),
                    Divider(indent: 20),
                    SmartSelect.multiple(
                      title: 'Ratings',
                      value: _car,
                      onChange: (selected) =>
                          setState(() => _car = selected.value),
                      choiceItems: choices.ratings,
                      tileBuilder: (context, state) {
                        return S2Tile.fromState(
                          state,
                          isTwoLine: true,
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://www.pngall.com/wp-content/uploads/4/5-Star-Rating-PNG.png',
                            ),
                          ),
                        );
                      },
                      choiceType: S2ChoiceType.chips,
                      modalType: S2ModalType.popupDialog,
                      modalHeaderStyle: S2ModalHeaderStyle(
                        backgroundColor: Color(0xFFFFCC00),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(indent: 20),
                  ],
                ),
              ),
              SizedBox(
                height: 136,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 42, vertical: 10),
                          primary: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 42,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 42, vertical: 10),
                          primary: Color(0xFFFFCC00),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
