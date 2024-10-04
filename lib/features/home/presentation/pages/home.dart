import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_event.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_state.dart';
import 'package:machine_test/features/home/presentation/pages/detailpage.dart';
import 'cart.dart';
import 'profile.dart';
import 'wishlist.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadProductsEvent()),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is HomeLoaded) {
                return _pages[state.selectedIndex](
                    state.products, state.wishlist, state.cart);
              }
              return Container(); // Fallback
            },
          ),
          bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              int selectedIndex = state is HomeLoaded ? state.selectedIndex : 0;

              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: Colors.black),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite, color: Colors.black),
                      label: 'Wishlist'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart, color: Colors.black),
                      label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: Colors.black),
                      label: 'Profile'),
                ],
                currentIndex: selectedIndex,
                onTap: (index) {
                  context.read<HomeBloc>().add(ChangeBottomNavEvent(index));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget Function(List<dynamic>, List<String>, List<String>)> get _pages =>
      [
        (products, wishlist, cart) => HomePage(products: products),
        (products, wishlist, cart) => WishlistPage(wishlist: wishlist),
        (products, wishlist, cart) => CartPage(cart: cart),
        (products, wishlist, cart) => ProfilePage(),
      ];
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (query) {
          context.read<HomeBloc>().add(SearchProductsEvent(query));
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<dynamic> products;

  const HomePage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final wishlist = state.wishlist;
          final cart = state.cart;
          final filteredProducts = state.filteredProducts.isNotEmpty
              ? state.filteredProducts
              : products;

          return Column(
            children: [
              const SizedBox(
                height: 100,
                child: SearchBar(),
              ),
              Expanded(
                child: filteredProducts.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          final productId = product['id'] ?? '';
                          final isWishlisted = wishlist.contains(productId);
                          final isInCart = cart.contains(productId);

                          return ListTile(
                            title: Text(product['name']),
                            subtitle: Text('\$${product['price']}'),
                            leading: Image.network(product['image']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isWishlisted
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isWishlisted ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomeBloc>()
                                        .add(ToggleWishlistEvent(productId));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    isInCart
                                        ? Icons.remove_shopping_cart
                                        : Icons.add_shopping_cart,
                                    color: isInCart ? Colors.green : null,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<HomeBloc>()
                                        .add(ToggleCartEvent(productId));
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(productId: productId),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No items found',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            ],
          );
        }
        return Container(); // Fallback for loading or error states
      },
    );
  }
}
