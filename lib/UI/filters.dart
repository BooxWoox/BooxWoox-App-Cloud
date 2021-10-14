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
        children: 
          [Column(
            children: [
              SmartSelect.multiple(
                title: 'Price',
                value: _car,
                onChange: (selected) => setState(() => _car = selected.value),
                choiceItems: choices.price,
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
                choiceItems: choices.genre,
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