import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rookkie_app_v2/bloc/status/status_bloc.dart';
import 'package:rookkie_app_v2/model/popupModel.dart';
import 'package:rookkie_app_v2/model/restaurantModel.dart';
import 'package:rookkie_app_v2/pages/map_page.dart';
import 'package:rookkie_app_v2/widgets/custom_shape.dart';
import 'package:rookkie_app_v2/widgets/dialog_popup.dart';
import 'package:rookkie_app_v2/widgets/mainui_customcard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isExpanded = false;
  double _height;
  double _width;
  // List<Restaurant> listRestaurant;

  void _showPopUp(BuildContext context) {
    Navigator.of(context).push(PopUpModel());
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  StatusBloc _statusBloc;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _statusBloc = BlocProvider.of<StatusBloc>(context);

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: _height,
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              expandList(),
              Divider(),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Trending", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(TRENDING_UI);
                          print('Showing all');
                        },
                        child: Text(
                          'Show all',
                          style: TextStyle(
                            color: Colors.orange[300],
                          ),
                        ))
                  ],
                ),
              ),
              BlocBuilder(
                  bloc: _statusBloc,
                  builder: (BuildContext context, StatusState state) {
                    if (state is LoadedStatusState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              state.status.toString(),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("status", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }),
              // trendingProducts(),
              // trendingProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: _width,
              height: 150,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10.0),
                  //color: Colors.black,
                  image: new DecorationImage(
                image: AssetImage('assets/images/header_1.jpg'),
                fit: BoxFit.cover,
              )),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 40, right: 40, top: _height / 5.55),
          child: Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 8,
            child: Container(
                // margin: EdgeInsets.all(10.0),
                width: 400,
                height: 50,
                child: Center(
                    child: Text(
                  'ROOKKIE',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ),
        Container(
          //color: Colors.blue,
          margin: EdgeInsets.only(left: 20, right: 20, top: _height / 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState.openDrawer();
                      },
                      child: Image.asset(
                        'assets/images/menubutton.png',
                        height: _height / 40,
                      )),
                ),
              ),
              Flexible(
                child: Container(
                  height: _height / 20,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('Editing location');
                        },
                        child: Icon(
                          Icons.edit_location,
                          color: Colors.white,
                          size: _height / 40,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text('Noida',
                            style: TextStyle(
                                color: Colors.white, fontSize: _height / 50),
                            // overflow: TextOverflow.fade,
                            softWrap: false),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: _height / 30,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget expandList() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed('/foodpage');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
                  print('Routing to Electronics item list');
                },
                child: Image.asset(
                  'assets/images/food_delivery_1.png',
                  height: _height / 15,
                  width: _width / 5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Text(
                  "สั่งอาหาร",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(PROPERTIES_ITEM_LIST);
                    print('วิน');
                    _statusBloc.add(SaveStatus("assigned"));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogPopUp(
                          context: context,
                          title: "ไม่สามารถทำรายการได้",
                          content: "เปิดให้บริการเร็วๆนี้",
                        );
                      },
                    );

                    // DialogPopUp();
                    // _showDialog();
                    // _showPopUp(context);
                    //         onPressed: () => ,
                    // child: Text('Show Overlay'),
                  },
                  child: Image.asset(
                    'assets/images/bike.png',
                    height: _height / 15,
                    width: _width / 5,
                  )),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Text(
                  "วินมอเตอร์ไซค์",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(JOBS_ITEM_LIST);
                    print('ส่งของ');
                    _statusBloc.add(SaveStatus("waiting"));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogPopUp(
                          context: context,
                          title: "ไม่สามารถทำรายการได้",
                          content: "เปิดให้บริการเร็วๆนี้",
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    'assets/images/bike_2.png',
                    height: _height / 15,
                    width: _width / 5,
                  )),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Text(
                  "ส่งของ",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(FURNITURE_ITEM_LIST);
                    print('บัญชี');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogPopUp(
                          context: context,
                          title: "ไม่สามารถทำรายการได้",
                          content: "เปิดให้บริการเร็วๆนี้",
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    'assets/images/wallet_1.png',
                    height: _height / 15,
                    width: _width / 5,
                  )),
              SizedBox(
                height: 5,
              ),
              Flexible(
                child: Text(
                  "บัญชี",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
