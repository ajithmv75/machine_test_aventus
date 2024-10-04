import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_event.dart';

class WishlistPage extends StatelessWidget {
  final List<String> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wishlist.isEmpty) {
      return const Center(child: Text("No items in wishlist."));
    }

    return ListView.builder(
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        final productId = wishlist[index];

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
              return const Center(child: Text("Error: No data found.")); // Handle no data
            }

            final product = snapshot.data!;
            return ListTile(
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              leading: Image.network(product['image']),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<HomeBloc>().add(ToggleWishlistEvent(productId));
                },
              ),
              onTap: () {
                // Handle tap on the product if needed
              },
            );
          },
        );
      },
    );
  }
}
