import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double width;
  final bool loading;
  const ThemeButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.width,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: loading
              ? CircularProgressIndicator()
              : ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor,
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
    );
  }
}

class ThemeTextButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double width;
  const ThemeTextButton(
      {Key key, @required this.label, @required this.onPressed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            label,
            style: TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: onPressed,
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(
          //   Theme.of(context).primaryColor,
          // ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
