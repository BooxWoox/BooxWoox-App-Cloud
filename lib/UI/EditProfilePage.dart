import 'package:flutter/material.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';
import 'package:bookollab/Api/books.dart';
import 'package:bookollab/State/auth.dart';
import 'package:flutter_riverpod/src/provider.dart';


// class EditProfileArguments {
//   String imgurl;
//
//   EditProfileArguments(this.imgurl);
// }


class ProfileEditPage extends StatefulWidget {

  static String id = 'EditProfilePage';

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}



TextEditingController firstNamectrl = TextEditingController() ;
TextEditingController lastNamectrl = TextEditingController() ;
// TextEditingController phoneNumberctrl = TextEditingController() ;
TextEditingController emailIDctrl = TextEditingController() ;

String token = "";
String firstName = firstNamectrl.text;
String lastName = lastNamectrl.text;
String emailId = emailIDctrl.text;
String imageurl = "";


final _formKey = GlobalKey<FormState>();



class _ProfileEditPageState extends State<ProfileEditPage> {

  updateDetails() async {
    final apiprovider = context.read(apiProvider);
    token = apiprovider.token;
    var status = await BooksRepository.UpdateProfile(token, firstName, lastName, emailId, imageurl);
    setState(() {
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map ;
    imageurl = arguments['prfimgurl'] ;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 83.0,
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Color(0xffE5E5E5),
                offset: Offset(0, -8), //(x,y)
                blurRadius: 33,
                spreadRadius: 0,
              )
            ],
          ),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ThemeTextButton(
                label: 'Save',
                onPressed: () {
                  updateDetails();
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Book Name"),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: firstNamectrl,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          validator: (val) {
                            if (val == null || val == '') {
                              return 'Please enter a valid first name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0xffE9E9E9),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            hintText: "First Name",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Name'),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: lastNamectrl,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          validator: (val) {
                            if (val == null || val == '') {
                              return 'Please enter a valid last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0xffE9E9E9),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            hintText: "Last Name",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text('Phone Number'),
                //         SizedBox(
                //           height: 15,
                //         ),
                //         TextFormField(
                //           controller: phoneNumberctrl,
                //           validator: (val){
                //             if ( val == null || val == ' '){
                //               return 'Please enter a valid phone number' ;
                //             }
                //             return null ;
                //           },
                //           style: TextStyle(
                //             fontSize: 14,
                //           ),
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(5),
                //                 borderSide: BorderSide.none),
                //             filled: true,
                //             fillColor: Color(0xffE9E9E9),
                //             contentPadding: EdgeInsets.symmetric(
                //                 vertical: 10, horizontal: 15),
                //             hintText: "Last Name",
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email ID'),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailIDctrl,
                          validator: (val){
                            if ( val == null || val == ' '){
                              return 'Please enter a valid email' ;
                            }
                            return null ;
                          },
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0xffE9E9E9),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            hintText: "Email ID",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


