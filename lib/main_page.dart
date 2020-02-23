import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rookkie_app_v2/bloc/status/status_bloc.dart';
import 'package:rookkie_app_v2/pages/home_pages.dart';
import 'package:rookkie_app_v2/pages/message_box.dart';
import 'package:rookkie_app_v2/pages/order_show.dart';
import 'package:rookkie_app_v2/pages/user_show.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  int index_page;

  @override
  MainPage(this.index_page);

  _MainPageState createState() => _MainPageState(this.index_page);
}

class _MainPageState extends State<MainPage> {
  _MainPageState(this.index_page);
  int index_page;
  int currentIndex = 0;
  List pages = [
    HomePage(),
    OrderShow(),
    MessageBox(),
    UserShow(),
  ];

  StatusBloc _statusBloc;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final notifications = FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future initialFCM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print(message);
        print("onMessage: $message");
        print("status = " + message["data"]["status"]);
        prefs.setString('status', message["data"]["status"]);
        // _statusBloc.add(SaveStatus(message["data"]["status"]));
        if (message["data"]["status"] == "assigned") {
          print("fucking success");
          _statusBloc.add(SaveStatus("assigned")); // ตรงนี้
          Navigator.pushNamedAndRemoveUntil(
              context, '/homeTwo', ModalRoute.withName('/hometwo'));
        }
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future onSelectNotification(String payload) {
    print("onselect");
    // debugPrint("payload : $payload");
    // showDialog(
    //   context: context,
    //   builder: (_) => new AlertDialog(
    //     title: new Text('Notification'),
    //     content: new Text('$payload'),
    //   ),
    // );
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => ConfirmPage(order_id)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("open main page");
    currentIndex = index_page;
    initialFCM();
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text('หน้าหลัก')),
        BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text('รายการ')),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline), title: Text('ข้อความ')),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), title: Text('บัญชี')),
      ],
    );
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
