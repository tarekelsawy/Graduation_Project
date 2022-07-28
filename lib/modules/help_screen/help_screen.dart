import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarScreen(),
      appBar: AppBar(
        title: Title(
          child: Text('help'),
          color: colorYellow,
        ),
      ),
    );
  }
}
