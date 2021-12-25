import 'package:flutter/material.dart';

class StoryBodyWigdet extends StatelessWidget {
  const StoryBodyWigdet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (index == 0)
                SizedBox(
                  width: 5,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your Story",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
