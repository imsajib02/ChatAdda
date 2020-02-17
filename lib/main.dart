import 'package:flutter/material.dart';

import 'resources/styles.dart';
import 'resources/strings.dart';
import 'tools/size_config.dart';
import 'widgets/widgets_collection.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

        builder: (context, constraints) {
          return OrientationBuilder(

            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(

                title: Strings.appNameString,
                //theme: AppTheme.lightTheme,
                home: SplashWidget(),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        }
    );
  }

}