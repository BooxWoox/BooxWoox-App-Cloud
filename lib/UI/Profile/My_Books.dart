import 'package:flutter/material.dart';

class Mybookspage extends StatefulWidget {

  static String id = 'Mybookspage';

  @override
  _MybookspageState createState() => _MybookspageState();
}

class _MybookspageState extends State<Mybookspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFBD06),
          title: Text(
            'My Books',
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Mainpage(),
      );
  }
}

class Mainpage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 70.0,
          decoration: BoxDecoration(
            color: Color(0xffFFBD06),
          ),
          child: DefaultTabController(
            length: 2,
            child: TabBar(
              unselectedLabelColor: Color(0x80000000),
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    'Approved',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 5,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 40.0),
          child: SingleChildScrollView(
            // clipBehavior: Clip.none,
            child: Column(
              children: [
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  height: 0.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
                Divider(
                  color: Color(0xffeeeeee),
                  thickness: 5.0,
                  height: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                bookdata(
                  imgs: Image.asset('images/pic.jpg'),
                  name: 'Prescient - D.S. Murphy',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class bookdata extends StatelessWidget {

  bookdata({@required this.imgs, @required this.name}) ;

  final Image imgs ;
  final String name ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(17.0)
            ),
            child: Container(
              child: imgs,
              height: 70.0,
              width: 70.0,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Uploaded on dd/mm/yy',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: (){},
              icon: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
