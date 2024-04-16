import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/compontes/listdrawer.dart';
import 'package:finalproject/drawer/header.dart';
import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/model/database.dart';
import 'package:finalproject/model/viwehome.dart';
import 'package:finalproject/secrens/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenstate();
}

class _HomeScreenstate extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController pageController;
  late TabController _tabController;
  List<String> cate = ["قطع غيار", "اكسسورات", "المحرك", "كمبيو"];
  int selectedindex = 0;
  List<CollectionReference> productCollections = [
    FirebaseFirestore.instance.collection('prodect'),
    FirebaseFirestore.instance.collection('prodectfour'),
    FirebaseFirestore.instance.collection('prodecttree'),
    FirebaseFirestore.instance.collection('prodecttwo'),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartContent>(context);
    final fave = Provider.of<favecontent>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        elevation: 0, // تغيير ظل الدراور
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // تغيير عرض الدراور
          decoration: BoxDecoration(
            color: Colors.white, // تغيير لون الدراور
            borderRadius: BorderRadius.only(
              topRight:
                  Radius.circular(20), // تغيير شكل الزوايا العلوية للدراور
              bottomRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [myheader(), Mydrwelist()],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: const Color.fromARGB(255, 121, 119, 119),
            size: 30,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          'ًWERSHA',
          style: TextStyle(
            color: const Color.fromARGB(255, 121, 119, 119),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat_bubble,
              color: const Color.fromARGB(255, 121, 119, 119),
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => chating()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: const Color.fromARGB(255, 121, 119, 119),
              size: 30,
            ),
            onPressed: () {
              // Perform settings actions
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "ٍSection",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: const Color.fromARGB(255, 121, 119, 119)),
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ccx, child) {
                      return child!;
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 121, 119, 119),
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage(Listimage[index]),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 110, left: 25, right: 145),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => listpage[index],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation:
                                    4, // Adjust the elevation value to control the shadow intensity
                                shadowColor: Colors.grey,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'SHOP NOW',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tap categrois",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: const Color.fromARGB(255, 121, 119, 119)),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: cate.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                              });
                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                color: selectedindex == index
                                    ? const Color.fromARGB(255, 121, 119, 119)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  cate[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedindex == index
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: productCollections[selectedindex].snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return SingleChildScrollView(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (100 / 140),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final document = snapshot.data!.docs[index];
                              final imageUrl = document['imageurl'];
                              final name = document['name'];
                              final price = document['price'];

                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 2),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: const Color.fromARGB(
                                              255, 121, 119, 119),
                                          size: 25,
                                        ),
                                        onPressed: () async {
                                          final favorite = {
                                            'name': name,
                                            'price': price,
                                            'image': imageUrl,
                                          };

                                          final dbHelper = DatabaseHelper();
                                          final insertedId = await dbHelper
                                              .insertFavorite(favorite);
                                          if (insertedId > 0) {
                                            // Product inserted successfully
                                            print(
                                                'Product inserted as a favorite.');
                                          } else {
                                            // Product already inserted as a favorite
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Image.network(imageUrl),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                bottom: 8.0),
                                            child: Text(
                                              'Price: $price',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: const Color.fromARGB(
                                                  255, 121, 119, 119),
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              final favorite = {
                                                'name': name,
                                                'price': price,
                                                'image': imageUrl,
                                              };
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
