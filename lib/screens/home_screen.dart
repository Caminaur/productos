import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productService = Provider.of<ProductsServices>(context);
    if (productService.isLoading) return LoadingScreen();
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        leading: IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {
            authService.logOut();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productService.selectedProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productService.products[index]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'profile');
              },
              heroTag: null,
            ),
            SizedBox(height: 600),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                productService.selectedProduct =
                    Product(available: true, name: '', price: 0);
                Navigator.pushNamed(context, 'product');
              },
            ),
          ],
        ),
      ),
    );
  }
}
