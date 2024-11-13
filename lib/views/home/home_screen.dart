import 'package:flutter/material.dart';
import 'package:our_faridpur/views/home/list_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final categories = ['Hospital', 'Hotel', 'Ambulance', 'Police']; // You can fetch this dynamically if needed

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Faridpur City'),
        backgroundColor: Colors.blue, // Replace with your color
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the ListScreen when a category is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListScreen(category: category),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



