import 'package:flutter/material.dart';

import 'package:chatadda/resources/strings.dart';
import 'package:chatadda/widgets/widgets_collection.dart';
import 'package:chatadda/widgets/helper_class.dart';

class ChatScreen extends StatefulWidget {

  static ChatState of(BuildContext context) => context.findAncestorStateOfType<ChatState>();

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatScreen> with TickerProviderStateMixin {

  static const int _logout = 303;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(Strings.appNameString),
        actions: <Widget>[

          //IconButton(icon: Icon(Icons.add), onPressed: () {}),

          PopupMenuButton<int>(

            icon: Icon(Icons.more_vert),
            elevation: 10,
            //padding: EdgeInsets.all(5),
            offset: Offset(0, 100),
            itemBuilder: (BuildContext context) => [

              PopupMenuItem(height: 30, child: Text("Logout"), value: _logout,),
              //PopupMenuDivider(height: 5,),
            ],
            onSelected: (value) {

              switch(value) {

                case _logout: {

                  MyClass.SignOutofGoogle();
                  dispose();
                } break;

                default: break;
              }
            },
          ),
        ],
      ),
      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
//        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[

          Flexible(child: ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => MyClass.messages[index],
              itemCount: MyClass.messages.length)),
          Container(
              child: ChatWidget()),
        ],
      ),
    );
  }

  void onMessageSubmitted(String text) {

    if(text.isNotEmpty) {

      ReceivedMessage message = ReceivedMessage(
        text: text,
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );

      setState(() {
        MyClass.messages.insert(0, message);
      });

      message.animationController.forward();

      ChatMessage message1 = ChatMessage(
        text: text,
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );

      setState(() {
        MyClass.messages.insert(0, message1);
      });

      message1.animationController.forward();
    }
  }

  @override
  void dispose() {

    for (ReceivedMessage message in MyClass.messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

}

