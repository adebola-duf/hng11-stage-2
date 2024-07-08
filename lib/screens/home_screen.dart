import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/shoe_inventory.dart';
import 'package:myapp/services/api_services.dart';
import 'package:myapp/widgets/error_container.dart';
import 'package:myapp/widgets/shoe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ShoeInventory> _loadShoeInventoryFuture;
  bool _hasError = false;

  Future<ShoeInventory> loadShoeInventory() async {
    return (await ApiServices().loadShoeInventory());
  }

  @override
  void initState() {
    _loadShoeInventoryFuture = loadShoeInventory();
    super.initState();
  }

  void _tryAgain() {
    setState(() {
      _loadShoeInventoryFuture = loadShoeInventory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _hasError
            ? null
            : [
                IconButton(
                  onPressed: () => setState(() {
                    _loadShoeInventoryFuture = loadShoeInventory();
                  }),
                  icon: const Icon(Icons.refresh),
                ),
              ],
        title: const Text(
          'Nike Run for Office',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<ShoeInventory>(
          future: _loadShoeInventoryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_hasError) {
                  setState(() {
                    _hasError = true;
                  });
                }
              });
              return ErrorContainer(
                error: snapshot.error.toString(),
                onTryAgain: _tryAgain,
              );
            }

            if (_hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _hasError = false;
                });
              });
            }

            final shoeInventory = snapshot.data!.shoeInventory;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: shoeCardWidth / shoeCardHeight,
              ),
              itemCount: shoeInventory.length,
              itemBuilder: (context, index) {
                return ShoeCard(
                  shoe: shoeInventory[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
