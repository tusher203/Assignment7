import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(centerTitle: true)),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<int> counts = List.filled(20, 0);

  void _increment(int index) {
    setState(() {
      counts[index]++;

      if (counts[index] >= 5) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Congratualtions! '),
              content: Text('You \'ve bought 5 Product$index !'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _navigateToCartPageWithAllData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(dataList: counts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: counts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Product$index'),
                  subtitle: const Text('\$20.00'),
                  trailing: FittedBox(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Counter "),
                            Text(counts[index].toString()),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _increment(index);
                          },
                          child: const Text('BuyNow'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pass all the data to the CartPage
          _navigateToCartPageWithAllData();
        },
        child: const Icon(Icons.shopping_cart_sharp),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<int> dataList; // Define the data list parameter
  const CartPage({required this.dataList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the total count from the dataList
    int totalCount = dataList.fold(0, (sum, count) => sum + count);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Count: $totalCount'),
          ],
        ),
      ),
    );
  }
}

