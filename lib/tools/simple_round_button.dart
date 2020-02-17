import 'package:flutter/material.dart';

import 'package:chatadda/tools/size_config.dart';

class SimpleRoundButton extends StatelessWidget {

  final double buttonHeight;
  final double defaultButtonHeight = 45.0;
  final double buttonWidth;
  final double defaultButtonWidth = 110.0;
  final Color backgroundColor;
  final Color defaultBackgroundColor = Colors.blueGrey;
  final Text text;
  final Color textColor;
  final double textSize;
  static final double _defaultTextSize = 1.87 * SizeConfig.textSizeMultiplier;
  final Color defaultTextColor = Colors.white;
  final Function onPressed;
  final Function defaultOnPressed = () {};
  final double padding;
  static final double _defaultPadding = _defaultTextSize;
  final double borderRadius;
  final double defaultBorderRadius = 1.6 * _defaultPadding;
  final double elevation;
  final Brightness brightness;
  final Color borderColor;
  final Color defaultBorderColor = Colors.transparent;
  final double borderWidth;
  final double defaultBorderWidth = 1.0;
  final FontWeight fontWeight;
  final FontWeight defaultFontWeight = FontWeight.normal;
  final FontStyle fontStyle;
  final FontStyle defaultFontStyle = FontStyle.normal;

  SimpleRoundButton(

    this.text, {
        this.backgroundColor,
        this.buttonHeight,
        this.buttonWidth,
        this.textColor,
        this.textSize,
        this.onPressed,
        this.borderRadius,
        this.elevation,
        this.brightness,
        this.padding,
        this.borderColor,
        this.borderWidth,
        this.fontWeight,
        this.fontStyle,

  }) : assert( text != null, 'A not null Text must be provided');

  @override
  Widget build(BuildContext context) {
    return Container(

        height: buttonHeight ?? defaultButtonHeight,
        width: buttonWidth ?? defaultButtonWidth,
        child: RaisedButton(

            child: Text(text.data.toUpperCase(),
              style: TextStyle(

                fontSize: textSize ?? _defaultTextSize,
                fontWeight: fontWeight ?? defaultFontWeight,
                fontStyle: fontStyle ?? defaultFontStyle,
              ),
            ),
            textColor: textColor ?? defaultTextColor,
            elevation: elevation,
            padding: EdgeInsets.all(padding ?? _defaultPadding),
            colorBrightness: brightness,
            color: backgroundColor ?? defaultBackgroundColor,
            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
                side: BorderSide(

                    color: borderColor ?? defaultBorderColor,
                    width: borderWidth ?? defaultBorderWidth,
                )
            ),
            onPressed: onPressed ?? defaultOnPressed)
    );
  }
}