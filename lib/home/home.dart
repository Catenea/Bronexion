import 'package:bronexion/home/Chat/Chat.dart';
import 'package:bronexion/home/Posts/posts_feed.dart';
import 'package:bronexion/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  int widgetIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PostsHome(),
    Chat(),
  ];

  void _changeWidget(int index) async {
    print(index);
    if (index > 1) {
      await _auth.signOut();
    } else {
      setState(() {
        widgetIndex = index;
        _selectedIndex = index;
      });
    }
  }

  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "Home",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 232, 131), fontSize: 20.0),
        )),
      ),
      body: _widgetOptions.elementAt(widgetIndex),
      bottomNavigationBar: SizedBox(
        height: 70.0,
        child: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 255, 232, 131),
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_enhance), title: Text("")),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline), title: Text("")),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              title: Text("Exit"),
            ),
          ],
          onTap: _changeWidget,
          currentIndex: _selectedIndex,
        ),
      ),
    ));
  }
}
