import 'package:flutter/material.dart';

class cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.track_changes),
          onPressed: () {
            // Add your menu button logic here
            print('Menu button pressed!');
          },
        ),
        title: Row(
          children: [
            Icon(Icons.add_circle),
            SizedBox(width: 8),
            Center(
                child: Text('سلة التسوق',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.green,
                    ))),
          ],
        ),
      ),
      body: Center(child: Text('App Body')),
    );
  }
}
