import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rookkie_app_v2/bloc/flow_bloc_delegate.dart';
import 'package:rookkie_app_v2/bloc/notifications_bloc.dart';
import 'package:rookkie_app_v2/bloc/status/status_bloc.dart';
import 'package:rookkie_app_v2/main_page.dart';
import 'package:rookkie_app_v2/pages/food_page.dart';
import 'package:rookkie_app_v2/pages/login_page.dart';
import 'package:rookkie_app_v2/provider/cart_bloc.dart';
import 'package:rookkie_app_v2/provider/counter_provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  BlocSupervisor.delegate = FlowBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StatusBloc>(
          create: (BuildContext context) => StatusBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<CartBloc>(
            builder: (context) => CartBloc(),
          ),
          ChangeNotifierProvider(
            builder: (context) => CounterProvider(counter: 0),
          ),
          ChangeNotifierProvider<LocalNotification>(
            builder: (context) => LocalNotification(null, null),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(primaryColor: Colors.orange),
          debugShowCheckedModeBanner: false,
          title: 'ROOKKIE',
          home: LoginPage(),
          routes: <String, WidgetBuilder>{
            // '/pagethree': (BuildContext context) => PageThree(),
            '/foodPage': (BuildContext context) => FoodPage(),
            '/homeOne': (BuildContext context) => MainPage(0),
            '/homeTwo': (BuildContext context) => MainPage(1),
            '/homeThree': (BuildContext context) => MainPage(2),
            '/homeFour': (BuildContext context) => MainPage(3),
          },
        ),
      ),
    );
  }
}
