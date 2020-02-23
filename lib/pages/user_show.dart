import 'package:flutter/material.dart';

class UserShow extends StatefulWidget {
  @override
  _UserShowState createState() => _UserShowState();
}

class _UserShowState extends State<UserShow> {
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'บัญชีผู้ใช้',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      key: GlobalKey<ScaffoldState>(),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  height: _height,
                  // color: Colors.green,
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                AssetImage('assets/images/paper_1.jpg'),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(
                            'MARIO',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('แก้ไขข้อมูล'),
                          trailing: Icon(Icons.more_vert),
                          onTap: () {},
                        ),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            CategoryListTile('ช่วยเหลือ'),
                            CategoryListTile('เงื่อนไขการให้บริการ'),
                            CategoryListTile('นโยบายความเป็นส่วนตัว'),
                            CategoryListTile('ให้คะแนน หรือให้แนะนำ'),
                            CategoryListTile('ตั้งค่า'),
                          ],
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Center(
                              child: Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  ListTile CategoryListTile(String header) {
    return ListTile(
      title: Text(header),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}
