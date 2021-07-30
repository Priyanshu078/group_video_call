import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CallPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = new TextEditingController();
  bool textfiendEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Image.asset("assets/agora.jpg")),
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Agora Group video Call",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Channel Name",
                      labelText: "Channel",
                      errorText:
                          textfiendEmpty ? 'Channel name is mandatory' : null,
                    ),
                  ),
                ),
                MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              "Join",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            Icons.forward,
                            color: Colors.white,
                          ),
                        ]),
                    color: Colors.blue,
                    onPressed: () {
                      onJoin();
                      print("Button pressed");
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> onJoin() async {
    setState(() {
      _controller.text.isEmpty ? textfiendEmpty = true : textfiendEmpty = false;
    });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CallPage(
                channelName: _controller.text,
              )),
    );
  }
}
