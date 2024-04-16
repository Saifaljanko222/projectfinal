import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/secrens/ditelsall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartContent>(context);
    int selectedindex = 0;
    bool selected = true;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.abc),
          backgroundColor: Colors.white,
          title: Text(
            "Cart",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.select_all_rounded,
                size: 30,
                color: Color.fromARGB(255, 91, 91, 91),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Color.fromARGB(255, 91, 91, 91),
              ),
              onPressed: () {
                if (selected && cart.selectedProduct.isNotEmpty) {
                  // Call the removeSelected method to remove the selected product
                  cart.remove(cart.selectedProduct[selectedindex]);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 580,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cart.selectedProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedindex = index;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Detailsall(cart.selectedProduct[index]),
                              ),
                            );
                          },
                          child: ListTile(
                            // leading: Checkbox(
                            //   value: selected,
                            //   onChanged: (bool? value) {
                            //     setState(() {
                            //       selected = value ?? false;
                            //     });
                            //   },
                            // ),
                            subtitle: Row(
                              children: [
                                Text(
                                  "\$${cart.selectedProduct[index].price.toString()}",
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Quantity: ${cart.selectedProduct[index].quantity.toString()}",
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cart.incrementQuantity(
                                        cart.selectedProduct[index]);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cart.decrementQuantity(
                                        cart.selectedProduct[index]);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Consumer<CartContent>(
                                  builder: (context, cart, _) => Checkbox(
                                    value: cart.selectedProduct
                                        .contains(cart.selectedProduct[index]),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value != null && value) {
                                          cart.add(cart.selectedProduct[index]);
                                        } else {
                                          cart.remove(
                                              cart.selectedProduct[index]);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(cart.selectedProduct[index].image),
                            ),
                            title: Text(
                              cart.selectedProduct[index].name,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 233, 236, 238),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "\$${cart.price.toString()}",
                  style: TextStyle(fontSize: 25),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 204, 212, 220)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(left: 30, right: 30)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                  ),
                  child: Text(
                    "الانتقال الي الدفع  (${cart.selectedProduct.length.toString()})",
                    style: TextStyle(fontSize: 19, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
