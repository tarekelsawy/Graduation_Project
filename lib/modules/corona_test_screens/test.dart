import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF3D657),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 210,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
                color: Color(0xFF1C1C1C),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  ' what is your tempreture?',
                  style: TextStyle(
                    color: Color(0xFFF3D657),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Slider(
              value: 30,
              onChanged: (newValue) {},
              min: 20,
              max: 40,
            ),
          ],
        ),
      ),
    );
  }
}
