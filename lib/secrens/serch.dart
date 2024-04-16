import 'package:finalproject/shared/contents.dart';
import 'package:finalproject/tabesserch/Offers.dart';
import 'package:finalproject/tabesserch/best.dart';
import 'package:finalproject/tabesserch/new.dart';
import 'package:flutter/material.dart';

class Searching extends StatefulWidget {
  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // bool isSearchIconClicked = false;
  // bool onclick = false;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.abc),
          title: SizedBox(
            height: 35,
            child: TextField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 221, 221, 221),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color.fromARGB(255, 122, 122, 122),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          backgroundColor: appbarcolor,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Row(
                children: [
                  Icon(Icons.bento_sharp),
                  Text(
                    'الاقضل',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.local_offer_sharp),
                  Text(
                    'العروض',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.fiber_new),
                  Text(
                    'وصل حديثا',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
            labelColor: const Color.fromARGB(255, 121, 119, 119),
            indicatorColor: const Color.fromARGB(255, 121, 119, 119),
            indicatorWeight: 4.0,
            unselectedLabelStyle: TextStyle(fontSize: 16),
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            bestpage(),
            offerspage(),
            newpage(),
          ],
        ),
      ),
    );
  }
}
