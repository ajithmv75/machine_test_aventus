
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_event.dart';
import 'package:machine_test/features/home/presentation/pages/cartDetailPage.dart';

class CartPage extends StatelessWidget {
  final List<String> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (cart.isEmpty) {
      return const Center(child: Text("No items in cart."));
    }

    return ListView.builder(
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final productId = cart[index];

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('product').doc(productId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("No items in cart."));
            }

            final product = snapshot.data!;
            return ListTile(
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              leading: Image.network(product['image']),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<HomeBloc>().add(ToggleCartEvent(productId));
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(productId: productId),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
