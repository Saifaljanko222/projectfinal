import 'package:finalproject/secrens/addadress.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class address extends StatefulWidget {
  const address({super.key});

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  Position? _currentlocation;
  late bool servicperssmoin = false;
  late LocationPermission permission;
  String _curresnaddress = "";
  Future<Position> _getcurrentlocation() async {
    servicperssmoin = await Geolocator.isLocationServiceEnabled();
    if (!servicperssmoin) {
      print("servic disabol");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }

  //now lates test
  _getaddresscoord() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _currentlocation!.latitude, _currentlocation!.longitude);
      Placemark place = placemark[0];
      setState(() {
        _curresnaddress = "${place.locality} , ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: Text("make address"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: const Color.fromARGB(255, 121, 119, 119),
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => addadress()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("location adress ${_curresnaddress}"),
            SizedBox(
              height: 10,
            ),
            Text("address ${_currentlocation?.latitude}"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  _currentlocation = await _getcurrentlocation();
                  await _getaddresscoord();
                  print("${_currentlocation}");
                  print("${_curresnaddress}");
                },
                child: Text("get loacation"))
          ],
        ),
      ),
    );
  }
}
