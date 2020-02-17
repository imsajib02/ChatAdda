import 'package:flutter/material.dart';

import 'package:chatadda/resources/styles.dart';
import 'package:chatadda/resources/strings.dart';
import 'package:chatadda/tools/size_config.dart';
import 'package:chatadda/widgets/widgets_collection.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appNameString),
      ),
      body: SafeArea(
          child: LoginWidget())
    );
  }

}