import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_select/smart_select.dart';
import 'choices.dart' as choices;

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
        title: Text('Filters', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xFFFFCC00),
      ),

      body: ListView(
        children: [
          Column(
            children: [
              SmartSelect.multiple(
                title: 'Price',
                value: _car,
                onChange: (selected) => setState(() => _car = selected.value),
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
                onChange: (selected) => setState(() => _car = selected.value),
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
      
              SmartSelect.multiple(
                title: 'Genre',
                value: _car,
                onChange: (selected) => setState(() => _car = selected.value),
                // choiceItems: S2Choice.listFrom<String, Map>(
                //   source: choices.genre,
                //   value: (index, item) => item['value'],
                //   title: (index, item) => item['title'],
                //   // group: (index, item) => item['brand'],
                // ),

                choiceItems: choices.gesfsfnre,

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
              ),
      
              Divider(indent: 20),
      
              SmartSelect.multiple(
                title: 'Ratings',
                value: _car,
                onChange: (selected) => setState(() => _car = selected.value),
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
        ],
      ),
    );
  }
}