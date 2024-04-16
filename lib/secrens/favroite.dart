import 'package:finalproject/model/Cart_Content.dart';
import 'package:finalproject/model/database.dart';
import 'package:finalproject/secrens/ditels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final fave = Provider.of<favecontent>(context);
    final DatabaseHelper dbHelper = DatabaseHelper();
    // final databaseProvider = ValueNotifier<DatabaseHelper>(dbHelper.database);
    // List<Map<String, dynamic>> favorites = await dbHelper.getFavorites();
    int selectedindex = 0;
    bool selected = true;
    return DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.abc),
            backgroundColor: Colors.white,
            title: Text(
              "love",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: 580,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: dbHelper.getFavorites(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final favorites = snapshot.data!;
                        return ListView.builder(
                          itemCount: favorites.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(favorites[index]),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  subtitle:
                                      Text('\$${favorites[index]['price']}'),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(favorites[index]['image']),
                                  ),
                                  title: Text(favorites[index]['name']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      dbHelper.removeFavorite(
                                          favorites[index]['id']);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
