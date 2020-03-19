import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chatadda/resources/strings.dart';
import 'package:chatadda/widgets/widgets_collection.dart';
import 'package:chatadda/widgets/helper_class.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ChatScreen extends StatefulWidget {

  static ChatState of(BuildContext context) => context.findAncestorStateOfType<ChatState>();

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<ChatScreen> with TickerProviderStateMixin {

  static const int _logout = 303;
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child(Strings.databaseRootPath);

  //StreamSubscription <Event> onMessageAdded;

  @override
  void initState() {
    super.initState();
//    onMessageAdded = _databaseReference.limitToLast(1).onChildAdded.listen((data) {
//
//      _onEntryAdded(data);
//    });
//    _databaseReference.onChildAdded.listen(_onEntryAdded);
  }

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

                  MyClass.SignOutofGoogle(context);
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

          Flexible(child: FirebaseAnimatedList(
              query: _databaseReference,
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              sort: (a, b) => b.key.compareTo(a.key),
              itemBuilder: (_, DataSnapshot messageSnapshot, Animation<double> animation, length) {

                if (messageSnapshot.value["userName"] == MyClass.loggeduser.userName) {

                  ChatMessage message1 = ChatMessage(
                    name: messageSnapshot.value["userName"],
                    photouri: messageSnapshot.value["photoUri"],
                    text: messageSnapshot.value["message"],
                    animationController: AnimationController(
                      duration: Duration(milliseconds: 700),
                      vsync: this,
                    ),
                  );

                  message1.animationController.forward();

                  return message1;
                }
                else {

                  ReceivedMessage message = ReceivedMessage(
                    name: messageSnapshot.value["userName"],
                    photouri: messageSnapshot.value["photoUri"],
                    text: messageSnapshot.value["message"],
                    animationController: AnimationController(
                      duration: Duration(milliseconds: 700),
                      vsync: this,
                    ),
                  );

                  message.animationController.forward();

                  return message;
                }
              }
          )),

//          Flexible(child: ListView.builder(
//              padding: new EdgeInsets.all(8.0),
//              reverse: true,
//              itemBuilder: (_, int index) => MyClass.messages[index],
//              itemCount: MyClass.messages.length)),
          Container(
              child: ChatWidget()),
        ],
      ),
    );
  }

  void onMessageSubmitted(String text) {

    if(text.isNotEmpty) {

//      ReceivedMessage message = ReceivedMessage(
//        text: text,
//        animationController: AnimationController(
//          duration: Duration(milliseconds: 700),
//          vsync: this,
//        ),
//      );
//
//      setState(() {
//        MyClass.messages.insert(0, message);
//      });
//
//      message.animationController.forward();

      _databaseReference.push().set(toJson(text)).then((value) {

      }).catchError((error) {
        print('Firebase: $error');

        MyClass.snack_msg = 'Message sending failed. Try again.';
        MyClass.DisplayErrorSnack(context, MyClass.snack_msg);
      });

//      ChatMessage message1 = ChatMessage(
//        text: text,
//        animationController: AnimationController(
//          duration: Duration(milliseconds: 700),
//          vsync: this,
//        ),
//      );
//
//      setState(() {
//        MyClass.messages.insert(0, message1);
//      });
//
//      message1.animationController.forward();
    }
  }

  toJson(String msg) {

    return {

      "userName" : MyClass.loggeduser.userName,
      "photoUri" : MyClass.loggeduser.photoUrl,
      "message" : msg,
    };
  }

  _onEntryAdded(Event event) {

    if(event.snapshot.value["userName"] == MyClass.loggeduser.userName) {

      ChatMessage message1 = ChatMessage(
        name: event.snapshot.value["userName"],
        photouri: event.snapshot.value["photoUri"],
        text: event.snapshot.value["message"],
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
    else {

      ReceivedMessage message = ReceivedMessage(
        name: event.snapshot.value["userName"],
        photouri: event.snapshot.value["photoUri"],
        text: event.snapshot.value["message"],
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );

      setState(() {
        MyClass.messages.insert(0, message);
      });

      message.animationController.forward();
    }
  }

  @override
  void dispose() {

    try {
      for (ChatMessage message in MyClass.messages) {

        if(message != null) {
          message.animationController.dispose();
          break;
        }
      }
    } on Exception catch (e) {

      print(e);
    }

    //onMessageAdded.cancel();
    super.dispose();
  }

}

