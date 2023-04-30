import 'package:brianpharmacy/constraints.dart';
import 'package:flutter/material.dart';

class TitleWithBtn extends StatelessWidget {
  const TitleWithBtn({
    super.key,
    required this.title,
    required this.press,
  });
  final String title;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          Title(text: title),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: press,
            child: const Text("More", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }
}
