import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class addadress extends StatefulWidget {
  const addadress({super.key});

  @override
  State<addadress> createState() => _addadressState();
}

class _addadressState extends State<addadress> {
  List<dynamic> State = [];
  String? StateID;

  //////
  List<dynamic> StreetMaster = [];
  List<dynamic> Street = [];
  String? StreetId;
////
  @override
  void initState() {
    super.initState();
    this.State.add({"id": 1, "name": "jazor"});
    this.State.add({"id": 2, "name": "angela"});

    this.StreetMaster = [
      {"ID": 1, "Name": "strre", "ParentId": 1},
      {"ID": 2, "Name": "strre2", "ParentId": 1},
      {"ID": 3, "Name": "stree3", "ParentId": 1},
      {"ID": 4, "Name": "stree4", "ParentId": 1},
      {"ID": 1, "Name": "strr4", "ParentId": 2},
      {"ID": 2, "Name": "strre5", "ParentId": 2},
      {"ID": 3, "Name": "stree6", "ParentId": 2},
      {"ID": 4, "Name": "stree3", "ParentId": 2},
    ];
  }

  final TextEditingController strate = TextEditingController();
  final TextEditingController note = TextEditingController();
  String dropvalue = "one";
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
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة عنوان"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormHelper.dropDownWidgetWithLabel(
              context,
              "المدينة",
              "select satet",
              this.StateID,
              this.State,
              (onchange) {
                this.StateID = onchange;
                print("$onchange");
                this.Street = this
                    .StreetMaster
                    .where((StateItem) =>
                        StateItem["ParentID"].toString() == onchange.toString())
                    .toList();
                this.StreetId = null;
              },
              (onvalid) {
                if (onvalid == null) {
                  return "select";
                }
                return null;
              },
              borderColor: Colors.black,
              borderFocusColor: Colors.grey,
              borderRadius: 10,
            ),
            SizedBox(
              height: 10,
            ),
            FormHelper.dropDownWidgetWithLabel(
              context,
              "الشارع",
              "select Street",
              this.StreetId,
              this.Street,
              (onchanged) {
                this.StreetId = onchanged;
                print("$onchanged");
              },
              (onvalue) {
                return null;
              },
              borderColor: Colors.black,
              borderFocusColor: Colors.grey,
              borderRadius: 10,
              optionLabel: 'Name',
              optionValue: 'ID',
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: strate,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_callback),
                    label: Text(
                      ' وصف عن مكان المحل ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 121, 119, 119),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("location adress ${_curresnaddress}"),
            TextField(
              controller: note,
              decoration: InputDecoration(
                labelText: 'عنوان محل',
              ),
            ),
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
