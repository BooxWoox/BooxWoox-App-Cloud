
import 'package:bookollab/Models/Api/GenreDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenreSelectionpage extends StatefulWidget {

  static String id = 'Genreselectionpage';

  @override
  _GenreSelectionpageState createState() => _GenreSelectionpageState();
}


class _GenreSelectionpageState extends State<GenreSelectionpage> {

  // final List<String> _genrename = ['Genre1','Genre2','Genre3','Genre4','Genre5','Genre5','Genre6','Genre7','Genre8','Genre9','Genre10','Genre11'];
  ColorFilter colr = ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.darken);
  List<int> _selectedgenre = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFBD06),
          elevation: 0,
        ),
        body: FutureBuilder<List<String>>(
          future: GenreDetails.AllGenrename('b0f3778c-d2f8-4978-8c3a-4458d8702af9'),
          builder: (context, snapshot) {
            // print(snapshot.data);
            // return LinearProgressIndicator();
            if (snapshot.connectionState != ConnectionState.done)
              {
                return LinearProgressIndicator();
              }
            else if(snapshot.hasError)
              {
                return Text(snapshot.error);
              }
            // List<String> _genrename = snapshot.data ;
            return Column(
              children: [
                Container(
                  // height: 300.0,
                  width: double.infinity,
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"
                                ),
                                fit: BoxFit.cover,
                                colorFilter: colr,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              // color: Colors.red,
                            ),
                          ),
                        ),
                        Flexible(
                            child: Text(
                              'What are your favourite genres?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '(Choose atleast 3)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      itemCount:  snapshot.data.length ,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // crossAxisSpacing: 20,
                        // mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              // _selectedgenre.add(index);
                              if(_selectedgenre.contains(index))
                                {
                                  _selectedgenre.remove(index);
                                }
                              else
                                {
                                  _selectedgenre.add(index);
                                }
                            });

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"
                                ),
                                fit: BoxFit.cover,
                                colorFilter: _selectedgenre.contains(index)?null:ColorFilter.mode(Colors.black.withOpacity(0.5),BlendMode.darken),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              // color: Colors.red,
                            ),
                            margin: EdgeInsets.all(15.0),
                            // height: 100.0,
                            // width: 100.0,
                            child: Center(
                              child: Text(
                                snapshot.data[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      print('1');
                    },
                    child: Container(
                      height: 50.0,
                        width: MediaQuery.of(context).size.width*0.75,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBD06),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      child: Center(
                        child: Text(
                          'Submit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      );
  }
}
