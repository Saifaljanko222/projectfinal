import 'package:finalproject/model/viwehome.dart';
import 'package:flutter/material.dart';

class GMCPAGE extends StatefulWidget {
  const GMCPAGE({super.key});

  @override
  State<GMCPAGE> createState() => _GMCPAGEState();
}

class _GMCPAGEState extends State<GMCPAGE> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GMC',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.messenger,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () {
              // Perform chat actions
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tap categrois",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ]),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (100 / 140),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10 // Aspect ratio of each grid item
                    ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => gmcpage[index],
                        ),
                      );
                    },
                    child: Container(
                      // margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width / 2,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),

                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              width: 130,
                              child: Image.asset(
                                gmccar[index],
                                // fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              "NAME CAR",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
