import 'package:bookollab/State/auth.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';

class GenreSelectionpage extends StatefulWidget {
  static String id = 'Genreselectionpage';

  @override
  _GenreSelectionpageState createState() => _GenreSelectionpageState();
}

class _GenreSelectionpageState extends State<GenreSelectionpage> {
  // final List<String> _genrename = ['Genre1','Genre2','Genre3','Genre4','Genre5','Genre5','Genre6','Genre7','Genre8','Genre9','Genre10','Genre11'];
  final List<String> _genreimages = [
    'assets/images/action.png',
    'assets/images/fantasy.png',
    'assets/images/science fiction.png',
    'assets/images/dystopian.png',
    'assets/images/action and adventure.png',
    'assets/images/mystery.png',
    'assets/images/horror.png',
    'assets/images/thriller and suspense.png',
    'assets/images/historical fiction.png',
    'assets/images/romance.png',
    'assets/images/women\'s fiction.png',
    'assets/images/LGBTQ+.png',
    'assets/images/contemporary fiction.png',
    'assets/images/literary fiction.png',
    'assets/images/magical realism.png',
    'assets/images/graphic novel.png',
    'assets/images/short story.png',
    'assets/images/young adult.png',
    'assets/images/new adult.png',
    'assets/images/children\'s.png',
    'assets/images/autobiography.png',
    'assets/images/biography.png',
    'assets/images/art ad photography.png',
    'assets/images/travel.png',
    'assets/images/history.png',
    'assets/images/true crime.png',
    'assets/images/humor.png',
    'assets/images/essays.png',
    'assets/images/religion.png',
    'assets/images/humanities and social sciences.png',
    'assets/images/parenting and families.png',
  ];
  ColorFilter colr =
      ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken);
  String name;
  // String nameofimage = genres.data.value[index];
  List<int> _selectedgenre = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFBD06),
        elevation: 0,
      ),
      body: Consumer(builder: (context, watch, child) {
        final genres = watch(allGenres);
        if (genres.data == null) {
          return LinearProgressIndicator();
        }
        return Column(
          children: [
            Center(
              child: Container(
                // height: 300.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.12,
                          width: MediaQuery.of(context).size.width*0.20,
                          // height: 100.0,
                          // width: 100.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/genres.png'),
                              fit: BoxFit.cover,
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
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              '(Choose atleast 3)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  itemCount: genres.data.value.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 20,
                    // mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // _selectedgenre.add(index);
                          if (_selectedgenre.contains(index)) {
                            _selectedgenre.remove(index);
                          } else {
                            _selectedgenre.add(index);
                          }
                          name = genres.data.value[index];
                          // print(name);
                          // print(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    // image: AssetImage('UIAssets/genre/adventure.webp'),
                                    image: AssetImage(_genreimages[index]),
                                    fit: BoxFit.contain,
                                    // colorFilter: _selectedgenre.contains(index)
                                    //     ? null
                                    //     : ColorFilter.mode(
                                    //         Colors.black.withOpacity(0.2),
                                    //         BlendMode.darken),

                                    colorFilter: _selectedgenre.contains(index)
                                        ? ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken)
                                        : null,

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  // color: Colors.red,
                                ),
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                // child: FittedBox(
                                //   child: Image.asset(_genreimages[index]),
                                //   fit: BoxFit.fill,
                                // ),
                                // height: 100.0,
                                // width: 100.0,
                                // child: Center(
                                //   child: Text(
                                //     genres.data.value[index],
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 17.0,
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                genres.data.value[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ThemeButton(
                  label: 'Submit',
                  width: MediaQuery.of(context).size.width * 0.75,
                  onPressed: () {

                    //Here we will give error message if the number of genres selected is less than 3.
                    if (_selectedgenre.length < 3) {
                      // return showDialog(
                      //     context: context,
                      //     builder: (context)
                      //     {
                      //       Future.delayed(Duration(seconds: 2), () {
                      //         Navigator.of(context).pop(true);
                      //       });
                      //       return AlertDialog(
                      //         title: Text(
                      //           'Please choose atleast 3 genres.',
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       );
                      //     });
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(
                            'Please choose atleast 3 genres.',
                            textAlign: TextAlign.center,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          actions: [
                            Center(
                              child: ThemeButton(
                                label: 'OK',
                                onPressed: () => Navigator.pop(context,false),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    //If number of genres selected is more than 3, no error.
                    else {
                      Navigator.of(context).pushReplacementNamed(Homepage.id);
                    }
                  },
              ),
            )
          ],
        );
      }),
    );
  }
}
