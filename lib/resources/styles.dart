import 'package:flutter/material.dart';

import 'package:chatadda/tools/size_config.dart';

class AppTheme{

  AppTheme._();

  static const Color textColor = const Color(0xFFFFFFFF);

  static final ThemeData lightTheme = ThemeData(

    scaffoldBackgroundColor: Colors.lightBlueAccent,
    brightness: Brightness.light,
    textTheme: lightTextTheme
  );

  static final ThemeData darkTheme = ThemeData(

      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: darkTextTheme
  );

  static final TextTheme lightTextTheme = TextTheme(

    title: _titleLight,
    subtitle: _subTitleLight,
    button: _buttonLight
  );

  static final TextTheme darkTextTheme = TextTheme(

      title: _titleDark,
      subtitle: _subTitleDark,
      button: _buttonDark
  );

  static final TextStyle _titleLight = TextStyle(

    color: textColor,
    fontSize:  28.0
  );

  static final TextStyle _subTitleLight = TextStyle(

      color: textColor,
      fontSize:  18.0,
      height:  1.5
  );

  static final TextStyle _buttonLight = TextStyle(

      color: textColor,
      fontSize:  22.0
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.black);
  static final TextStyle _subTitleDark = _subTitleLight.copyWith(color: Colors.black);
  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);

  static final double smallText = 1.25 * SizeConfig.textSizeMultiplier;
  static final double mediumText = 2.5 * SizeConfig.textSizeMultiplier;
  static final double largeText = 3.75 * SizeConfig.textSizeMultiplier;
}