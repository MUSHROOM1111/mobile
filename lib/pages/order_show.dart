import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rookkie_app_v2/bloc/notifications_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderShow extends StatefulWidget {
  @override
  _OrderShowState createState() => _OrderShowState();
}

class _OrderShowState extends State<OrderShow> {
  Stream<LocalNotification> _notificationsStream;
  List statusForm = [
    StatusModel(
      statusSend: "assigned",
      statusText: "กำลังเดินทางไปร้านอาหาร",
      color: Colors.orange,
    ),
    StatusModel(
      statusSend: "waiting",
      statusText: "สั่งอาหารแล้ว",
      color: Colors.grey[300],
    ),
    StatusModel(
      statusSend: "shipping",
      statusText: "รับอาหารแล้ว",
      color: Colors.grey[300],
    ),
    StatusModel(
      statusSend: "shipped",
      statusText: "กำลังไปส่งอาหาร",
      color: Colors.grey[300],
    ),
  ];
  List colorStatus;

  Future getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = prefs.getString('status');
    print(status);
  }

  changeColorStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = prefs.getString('status');
    if (status == "assigned") {
      setState(() {
        colorStatus = [
          Colors.orange,
          Colors.grey[300],
          Colors.grey[300],
          Colors.grey[300],
        ];
      });
      return colorStatus;
    }
    if (status == "waiting") {
      setState(() {
        colorStatus = [
          Colors.orange,
          Colors.orange,
          Colors.grey[300],
          Colors.grey[300],
        ];
      });
      return colorStatus;
    }
    if (status == "shipping") {
      setState(() {
        colorStatus = [
          Colors.orange,
          Colors.orange,
          Colors.orange,
          Colors.grey[300],
        ];
      });
      return colorStatus;
    }
    if (status == "shipping") {
      setState(() {
        colorStatus = [
          Colors.orange,
          Colors.orange,
          Colors.orange,
          Colors.orange,
        ];
      });
      return colorStatus;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
    changeColorStatus();
    // _notificationsStream = NotificationsBloc.instance.notificationsStream;
    // _notificationsStream.listen((notification) {
    //   // TODO: Implement your logic here
    //   print('Notification: $notification');
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'รายงาน',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Colors.white,
            onPressed: () {},
            child: new Icon(FontAwesomeIcons.history),
          )
        ],
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          int count = index + 1;
          return Material(
            color: Colors.white,
            child: new Stack(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: new Container(
                    margin: new EdgeInsets.all(8.0),
                    child: new Container(
                      width: double.infinity,
                      height: 50.0,
                      // color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        statusForm[index].statusText,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                new Positioned(
                  top: 15.0,
                  left: 15.0,
                  child: new Container(
                    height: 40.0,
                    width: 40.0,
                    child: new Container(
                      margin: new EdgeInsets.all(8.0),
                      height: 30.0,
                      width: 30.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: colorStatus[index] == null
                              ? Colors.grey
                              : colorStatus[index]),
                      child: Center(
                        child: Text(
                          "$count",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 4,
      ),
      // body: SingleChildScrollView(
      //   // child: Column(
      //   //   children: <Widget>[
      //   //     Container(
      //   //       // color: Colors.red,
      //   //       child: Stepper(
      //   //         steps: _mySteps(),
      //   //         currentStep: this._currentStep,
      //   //         onStepTapped: (step) {
      //   //           setState(() {
      //   //             this._currentStep = step;
      //   //           });
      //   //         },
      //   //         onStepContinue: () {
      //   //           setState(() {
      //   //             if (this._currentStep < this._mySteps().length - 1) {
      //   //               this._currentStep = this._currentStep + 1;
      //   //             } else {
      //   //               //Logic to check if everything is completed
      //   //               print('Completed, check fields.');
      //   //             }
      //   //           });
      //   //         },
      //   //         onStepCancel: () {
      //   //           setState(() {
      //   //             if (this._currentStep > 0) {
      //   //               this._currentStep = this._currentStep - 1;
      //   //             } else {
      //   //               this._currentStep = 0;
      //   //             }
      //   //           });
      //   //         },
      //   //       ),
      //   //     ),
      //   //     SizedBox(height: 600)
      //   //   ],
      //   // ),
      //   child: Row(
      //     children: <Widget>[
      //       Container(
      //         child: null,
      //       ),
      //       Container(
      //         child: null,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class StatusModel {
  const StatusModel({
    @required this.statusSend,
    @required this.statusText,
    @required this.color,
  });
  final String statusSend;
  final String statusText;
  final Color color;
}
