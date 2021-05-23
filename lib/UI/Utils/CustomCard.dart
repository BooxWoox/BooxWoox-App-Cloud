import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Transactions/AllTransactions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class CustomCard extends StatelessWidget {
  final String personName;
  final String PhoneNumber;
  final String designation;
  final String Supporttype;

  CustomCard(this.personName, this.PhoneNumber, this.designation,
      this.Supporttype, this.EmailId, this.ImageUrl);

  final String EmailId;
  final String ImageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: new Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 45,),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(personName,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "LeelawUI",
                                fontWeight: FontWeight.w600,
                              ),),
                            )
                          ],
                        ),
                        Text(designation,
                        style: TextStyle(
                          color: Colors.black45
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone),
                            Text(PhoneNumber),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.email),
                            Text(EmailId),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
            FractionalTranslation(
              translation: Offset(0.0, -0.4),
              child: Align(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(ImageUrl),
                  radius: 45.0,
                ),
                alignment: FractionalOffset(0.5, 0.0),
              ),
            ),

          ],
        ),
      ),
    );
  }
}