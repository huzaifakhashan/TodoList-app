import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final String name;
   const Welcome({super.key,required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "أهلاً بك $name",
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image(
                  image: AssetImage("assets/icons/emoji2.webp"),
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
          CircleAvatar(
            child: Image(image: AssetImage("assets/icons/emoji.webp")),
          ),
        ],
      ),
    );
  }
}
