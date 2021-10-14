import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class EditBook extends StatefulWidget {
  static String id = 'EditBook';
  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  List<String> genreTags = [];
  String condition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.00),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Book details',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Book name',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Book name here',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.00),
                  )),
              maxLines: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Author name',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Author name here',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.00),
                  )),
              maxLines: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Condition',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                contentPadding: EdgeInsets.all(10),
                hintText: 'Select condition of book',
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: condition,
                  isDense: true,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(child: Text("used"), value: "used"),
                    DropdownMenuItem(child: Text("unused"), value: "unused"),
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      condition = newValue;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Genre tags',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldTags(
              // box is not appearig around this widget and i dont know why
              tagsStyler: TagsStyler(
                tagTextStyle: TextStyle(color: Colors.black),
                tagDecoration: BoxDecoration(
                  color: const Color(0xFFFFBD06),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                tagCancelIcon: Icon(Icons.cancel,
                    size: 16.0, color: Color.fromARGB(255, 235, 214, 214)),
                tagPadding: const EdgeInsets.all(10.0),
              ),
              textFieldStyler: TextFieldStyler(
                hintText: "Give space after writting  every tag",
                isDense: false,
                textFieldFocusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                textFieldBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
              ),
              onDelete: (tag) {
                genreTags.remove(tag);
              },
              onTag: (tag) {
                genreTags.add(tag);
              },
              validator: (String tag) {
                print('validator: $tag');
                if (tag.length > 20) {
                  return "hey that is too much";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.00, bottom: 15.00),
              child: Text(
                'Cost details',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Quoted deposit',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0.00, left: 5.00, bottom: 5.00),
              child: Text(
                '*Please Enter value between xx.xx to yy.yy*',
                style: TextStyle(fontSize: 10.00, color: Colors.red),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '>30%',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.00),
                ),
              ),
              maxLines: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'MRP',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'MRP price',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.00),
                ),
              ),
              maxLines: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.00, left: 5.00, bottom: 5.00),
              child: Text(
                'Rent duration',
                style: TextStyle(fontSize: 15.00, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Duration',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.00),
                ),
              ),
              maxLines: 1,
            ),
            Padding(
              padding: EdgeInsets.all(15.00),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0.00,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.00),
                    ),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
