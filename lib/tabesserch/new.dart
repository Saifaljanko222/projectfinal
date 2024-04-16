import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/model/database.dart';
import 'package:finalproject/model/viwehome.dart';
import 'package:finalproject/secrens/ditelsall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class newpage extends StatefulWidget {
  const newpage({super.key});

  @override
  State<newpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<newpage>
    with SingleTickerProviderStateMixin {
  late final PageController pageController;

  int selectedindex = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartContent>(context);
    final fave = Provider.of<favecontent>(context);
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Tap categrois",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: const Color.fromARGB(255, 121, 119, 119)),
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
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: product.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailsall(
                                    productall[selectedindex][index])));
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
                              onPressed: () async {
                                final selectedProduct = product[index];
                                final favorite = {
                                  'name': selectedProduct.name,
                                  'price': selectedProduct.price,
                                  'image': selectedProduct.image,
                                };

                                final dbHelper = DatabaseHelper();
                                final insertedId =
                                    await dbHelper.insertFavorite(favorite);
                                print(insertedId);
                                // fave.add(product[index]);
                              },
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      product[index].image,
                                    ),
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product[index].name,
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
                                    "\$${product[index].price}",
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
                                    cart.add(product[index]);
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
        )),
      ),
    );
  }
}
