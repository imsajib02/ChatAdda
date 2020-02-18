import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chatadda/resources/styles.dart';
import 'package:chatadda/resources/strings.dart';
import 'package:chatadda/resources/images.dart';
import 'package:chatadda/tools/size_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:chatadda/pages/login.dart';
import 'package:chatadda/tools/simple_round_button.dart';
import 'package:chatadda/tools/bounce_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatadda/widgets/helper_class.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:chatadda/pages/chat_screen.dart';

class SplashWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen(
          seconds: (3.5).toInt(),
          image: Image.asset(Images.splashGif),
          photoSize: 25 * SizeConfig.imageSizeMultiplier,
          title: Text(
            Strings.appNameString,
            style: TextStyle(
                fontSize: 3 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.bold
            ),
          ),
          loaderColor: Colors.lightBlueAccent,
          navigateAfterSeconds: Login(),
        )
    );
  }

}


class LoginWidget extends StatefulWidget {

  @override
  State createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(Strings.loginPageString,
                  style: TextStyle(fontSize: 3.75 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        color: Colors.black12
                      ),
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Colors.black12
                      ),
                    ],
                  ),
                ),
              ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(4 * SizeConfig.heightSizeMultiplier),
                child: SizedBox(
                  width: 30 * SizeConfig.widthSizeMultiplier,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(Images.googleLogo,
                    ),
                  ),
          ),
              )),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,

                child: BounceAnimation(
                  childWidget: SimpleRoundButton(

                    Text("sign-in with google"),
                    backgroundColor: Colors.lightGreen,
                    buttonHeight: 6.5 * SizeConfig.heightSizeMultiplier,
                    buttonWidth: 60 * SizeConfig.widthSizeMultiplier,
                    textColor: Colors.white,
                    textSize: 2.25 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w600,
                    borderRadius: 3.12 * SizeConfig.heightSizeMultiplier,
                    elevation: 5.0,
                    padding: 1.875 * SizeConfig.heightSizeMultiplier,
                    onPressed: () {
                      BounceState.scaleAnimationController.forward();
                      MyClass.GoogleLogin(context);
                      },
                  ),
                ),
              ),
          )
        ],
      )
    );
  }
}


class ChatWidget extends StatefulWidget {

  @override
  ChatWidgetState createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> with TickerProviderStateMixin {

  final TextEditingController _textController = new TextEditingController();
  final int _textInputLimit = 250;

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),

      child: Align(

        child: Column(

          children: <Widget>[
            Divider(height: 5.0, color: Colors.lightBlue,),
            Container(

              height: 6.8 * SizeConfig.heightSizeMultiplier,
              child: Row(

                children: <Widget>[
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.add_photo_alternate),
                        iconSize: 6.7 * SizeConfig.imageSizeMultiplier,
                        color: Colors.lightBlueAccent,
                        onPressed: () {}),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      inputFormatters: [ LengthLimitingTextInputFormatter(_textInputLimit) ],
                      decoration: InputDecoration.collapsed(
                          hintText: "Send a message",)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),

                    child: IconButton(
                        icon: Icon(Icons.send),
                        iconSize: 6.7 * SizeConfig.imageSizeMultiplier,
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          _handleSubmitted(_textController.text);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {

    _textController.clear();

    ChatScreen.of(context).onMessageSubmitted(text);

//    ChatMessage message = new ChatMessage(
//      text: text,
//    );

    //ChatState().UpdateUi(message);

//    setState(() {
//      MyClass.messages.insert(0, message);
//    });
  }

  @override
  Widget build(BuildContext context) {

    return _buildTextComposer();
  }
}


class ChatMessage extends StatelessWidget {

  final String text;
  final AnimationController animationController;

  ChatMessage( {
    this.text,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {

    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,

      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),

        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: <Widget>[
                Container(
                    child: Text(MyClass.loggeduser.userName, style: Theme.of(context).textTheme.caption),
                    //child: Text("Sajib", style: Theme.of(context).textTheme.caption),
                  margin: const EdgeInsets.only(right: 5, top: 5),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                      child: Text(text,
                        style: TextStyle(color: Colors.white, height: 1.2, fontSize: 15, letterSpacing: .2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 6.0, left: 12.0),

              child: CircleAvatar(
                backgroundImage: NetworkImage(MyClass.loggeduser.photoUrl)),
                  //child: Icon(Icons.account_circle, color: Colors.lightBlueAccent,)),
            ),
          ],
        ),
      ),
    );
  }
}


class ReceivedMessage extends StatelessWidget {

  final String text;
  final AnimationController animationController;

  ReceivedMessage( {
    this.text,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1.5, 0.0), end: Offset.zero,
      ).animate(CurvedAnimation(parent: animationController, curve: Curves.elasticInOut,)),

      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),

        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[

            Container(
              margin: const EdgeInsets.only(right: 12.0, left: 6.0),

              child: CircleAvatar(
                //backgroundImage: NetworkImage(MyClass.loggeduser.photoUrl)),
                  child: Icon(Icons.account_circle, color: Colors.lightBlueAccent,)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                //Text(MyClass.loggeduser.userName, style: Theme.of(context).textTheme.subhead),
                Container(
                  child: Text("Her", style: Theme.of(context).textTheme.caption),
                  margin: const EdgeInsets.only(left: 5, top: 5),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      color: Colors.lightBlueAccent,
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                      child: Text(text,
                        style: TextStyle(color: Colors.white, height: 1.2, fontSize: 15, letterSpacing: .2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}