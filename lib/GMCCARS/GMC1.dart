import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/model/viwehome.dart';
import 'package:finalproject/secrens/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GMC1 extends StatefulWidget {
  const GMC1({Key? key}) : super(key: key);

  @override
  State<GMC1> createState() => _GMCPAGEState();
}

class _GMCPAGEState extends State<GMC1> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> cate = ["قطع غيار", "كمبيو", "المحرك", "صالة"];
  int selectedindex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartp = Provider.of<CartContent>(context);
    final fave = Provider.of<favecontent>(context);
    bool _isPressed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GMC1',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              backgroundColor: Colors.red,
              label: Text(cartp.selectedProduct.length.toString()),
              largeSize: 20,
              child: Icon(
                Icons.shopping_cart,
                color:
                    _isPressed ? Colors.white : Color.fromARGB(255, 57, 57, 57),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      cart(), // Replace CartPage with your actual cart page widget
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "التصنيفات",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
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
                            ? Colors.blue
                            : Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          cate[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedindex == index
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: products[selectedindex].length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             Details(products[selectedindex][index])));
                      },
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: const Color.fromARGB(255, 121, 119, 119),
                                size: 25,
                              ),
                              onPressed: () {
                                fave.add(productall[selectedindex][index]);
                              },
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      products[selectedindex][index].image,
                                    ),
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                products[selectedindex][index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 8.0),
                                  child: Text(
                                    "\$${products[selectedindex][index].price}",
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
                                    cartp.add(products[selectedindex][index]);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
