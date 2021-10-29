import 'package:bookollab/State/auth.dart';
import 'package:bookollab/UI/Genreselection.dart';
import 'package:bookollab/UI/Homepage.dart';
import 'package:bookollab/UI/Onboarding/GenreTags.dart';
import 'package:bookollab/UI/widgets/ThemeButton.dart';
import 'package:bookollab/repositories/auth_repo.dart';
import 'package:bookollab/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpScreenArguments {
  String phone;

  OtpScreenArguments(this.phone);
}

class OTPverify extends StatefulWidget {
  static String id = 'OTPverify_Screen';

  const OTPverify({
    Key key,
  }) : super(key: key);

  @override
  _OTPverifyState createState() => _OTPverifyState();
}

class _OTPverifyState extends State<OTPverify> {
  String otp = "";
  String tokenpassed = "";
  @override
  Widget build(BuildContext context) {
    OtpScreenArguments args =
        ModalRoute.of(context).settings.arguments as OtpScreenArguments;
    return Consumer(
      builder: (context, watch, child) {
        final apiProv = watch(apiProvider);

        tokenpassed = apiProv.otpToken;
        if (apiProv.token != null) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushReplacementNamed(Homepage.id);
          });
        }
        return child;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset('UIAssets/OtpScreen/secure.png'),
                Text(
                  "Please enter your 6 digit OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Avenir95Black'),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "sent to your mobile number ending with"),
                      TextSpan(
                        text: " ${args.phone.substring(6)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      otp = value;
                    },
                    autoDismissKeyboard: true,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      activeFillColor: Theme.of(context).backgroundColor,
                      inactiveFillColor: Theme.of(context).backgroundColor,
                      selectedFillColor: Theme.of(context).backgroundColor,
                      activeColor: Theme.of(context).backgroundColor,
                      selectedColor: Theme.of(context).primaryColor,
                      inactiveColor: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                ThemeButton(
                  label: "Next",
                  onPressed: () async {
                    // try {
                      await context.read(apiProvider).verifyOtp(otp);
                      Navigator.pushNamed(context, GenreSelectionpage.id,
                      arguments: tokenpassed);
                    // } catch (e) {
                      // logger.e(e);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text("An unexpected error occurred"),
                      //   ),
                      // );
                    // }
                  },
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}