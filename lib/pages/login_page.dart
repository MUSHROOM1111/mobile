import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rookkie_app_v2/main_page.dart';

import 'package:http/http.dart' as http;
import 'package:rookkie_app_v2/provider/api_provider.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  bool isLoading = false;

  Future<Null> doLogin() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.post('http://service.rookkie.com/oauth/token', body: {
      'username': ctrlUsername.text,
      'password': ctrlPassword.text,
      'client_id': '2',
      'client_secret': 'tacNc9Ll4lUkD56JMhEKVpdQ9ZVxQCQMhCkPM1Yw',
      'grant_type': 'password'
    });
    print(response.statusCode);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (jsonResponse['token_type'] == 'Bearer') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonResponse['access_token']);
        var user_data = await getUser(jsonResponse['access_token']);
        int user_id = user_data["user"]["id"];
        prefs.setString('user_id', user_id.toString());
        var device_token = await prefs.getString('device_token');
        print("device token = $device_token");
        await updateDeviceToken(device_token, user_id);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage(0)));
      } else {
        //error
        showDialog(
            context: context,
            builder: (BuildContext) {
              return new SimpleDialog(
                title: const Text(
                  'เกิดข้อผิดหลาด',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'การเข้าสู่ระบบผิดพลาด',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  new SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ตกลง',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                  )
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext) {
            return new SimpleDialog(
              title: const Text(
                'ข้อมูลไม่ถูกต้อง',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Username หรือ Password ไม่ถูกต้อง',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                new SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ตกลง',
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                )
              ],
            );
          });
    }
  }

  ApiProvider apiProvider = ApiProvider();
  Future getUser(token) async {
    try {
      var rs = await apiProvider.showUser(token);
      if (rs.statusCode == 200) {
        print("print");
        print(rs.body);
        var jsonRes = json.decode(rs.body);
        // print(jsonRes["user"]["id"]);
        return jsonRes;
      } else {
        print('error!get user');
      }
    } catch (error) {
      print(error);
    }
  }

  Future updateDeviceToken(token, user_id) async {
    try {
      var rs = await apiProvider.updateDeviceToken(token, user_id);
      print("pass provider update device token");
      // print(rs.body);
      if (rs.statusCode == 200) {
        print("print");
        print(rs.body);
      } else {
        var error = rs.body;
        print('error!update device token = $error');
      }
    } catch (error) {
      print(error);
    }
  }

  // void _doLogin() {
  //   print(ctrlUsername.text);
  //   print(ctrlPassword.text);

  //   if (ctrlUsername.text == 'admin' && ctrlPassword.text == 'admin') {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => MainPage()));
  //   }
  // }

  // Future<Null> getToekn() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = await prefs.get('token');
  //   if (token != null) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => PageOne()));
  //   }

  //   print(token);
  // }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final notifications = FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future initialFCM() async {
    //register device token
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("device token = $token");
      await prefs.setString('device_token', token);

      // await storage.write(key: 'device_token', value: token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFCM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.orange,
          ),
          ListView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100.0,
                    ),
                    Image(
                      width: 150.0,
                      height: 150.0,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Form(
                          child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: ctrlUsername,
                            style: TextStyle(fontSize: 15.0),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: ctrlPassword,
                            style: TextStyle(fontSize: 15.0),
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                isLoading ? CircularProgressIndicator() : null,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(30.0)),
                            shadowColor: Colors.orange,
                            elevation: 5.0,
                            child: MaterialButton(
                              minWidth: 290.0,
                              height: 55.0,
                              onPressed: () => doLogin(),
                              color: Colors.orange[300],
                              child: Text(
                                'login',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
