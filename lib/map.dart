
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'map/kakaomap.dart';

double lat = 0.0;
double lng = 0.0;

class MapView extends StatefulWidget{
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  WebViewController? controller;
  int _selectedItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //현재위치
    // LocationPermission permission = await Geolocator.requestPermission();
    // Position position = await Geolocator.
    // getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);

    lat = 37.49452670524463;
    lng = 126.91566392370709;
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("map"),
        backgroundColor: Colors.blue[900],
      ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(accountName: Text("dd"), accountEmail: Text("ss"))
            ],
          ),
        ),
        body: Column(children: [
          getPage()
        ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem,
        onTap: (idx){
          setState(() {
            _selectedItem = idx;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "위치"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "정보"),
        ],
      ),
    );
  }
  Widget getPage(){
    if(_selectedItem == 0){
      return Container(height: 600,child:Kakaomap(controller, lat, lng));
    }else if(_selectedItem == 1){
      return const Center(
          child: Text("111")
      );
    }
    return Container();
  }
}

class Kakaomap extends StatefulWidget {
  Set<JavascriptChannel>? channel;
  WebViewController? controller;

  Kakaomap(this.controller, double lat, double lng, {Key? key}) : super(key: key){
    channel = {JavascriptChannel(
        name: 'onClickMarker', onMessageReceived: (message){
     // Navigator.of(con)
    })
    };
  }

  @override
  State<Kakaomap> createState() => _KakaomapState();
}

class _KakaomapState extends State<Kakaomap> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return KakaoMapView(
        width: size.width,
        height: size.height,
        kakaoMapKey: "b21a9f6578bc8489a203c560f0cf0dfc",
        lat: lat,
        lng: lng,
        showMapTypeControl: true,
        showZoomControl: true,
        onClick: (message) async {
          showToast(message.message);
        },
        onTapMarker: (message) async {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Marker is clicked')));

          //await _openKakaoMapScreen(context);
        });
  }
}

void showToast(String message){
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey[900],
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM
  );
}