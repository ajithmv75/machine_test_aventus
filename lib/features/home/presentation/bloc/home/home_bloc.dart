import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> _wishlist = [];
  final List<String> _cart = [];

  HomeBloc() : super(HomeInitial()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final products = await _fetchProducts();
        emit(HomeLoaded(
          products: products,
          wishlist: _wishlist,
          cart: _cart,
          selectedIndex: 0,
          filteredProducts: products,
        ));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });

    on<ToggleWishlistEvent>((event, emit) {
      if (_wishlist.contains(event.productId)) {
        _wishlist.remove(event.productId);
      } else {
        _wishlist.add(event.productId);
      }
      emit(_updateHomeLoaded(emit));
    });

    on<ToggleCartEvent>((event, emit) {
      if (_cart.contains(event.productId)) {
        _cart.remove(event.productId);
      } else {
        _cart.add(event.productId);
      }
      emit(_updateHomeLoaded(emit));
    });

    on<ChangeBottomNavEvent>((event, emit) {
      final currentState = state;
      if (currentState is HomeLoaded) {
        emit(HomeLoaded(
          products: currentState.products,
          wishlist: currentState.wishlist,
          cart: currentState.cart,
          selectedIndex: event.index,
          filteredProducts: currentState.filteredProducts,
        ));
      }
    });

    on<SearchProductsEvent>((event, emit) {
      final currentState = state;
      if (currentState is HomeLoaded) {
        final filteredProducts = currentState.products.where((product) {
          return product['name'].toLowerCase().contains(event.query.toLowerCase());
        }).toList();

        emit(HomeLoaded(
          products: currentState.products,
          wishlist: currentState.wishlist,
          cart: currentState.cart,
          selectedIndex: currentState.selectedIndex,
          filteredProducts: filteredProducts,
        ));
      }
    });


  }

  Future<List<dynamic>> _fetchProducts() async {
    final snapshot = await FirebaseFirestore.instance.collection('product').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Explicit cast
      data['id'] = doc.id; // Add the document ID to the data map
      return data;
    }).toList();
  }

  HomeLoaded _updateHomeLoaded(Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      return HomeLoaded(
        products: currentState.products,
        wishlist: _wishlist,
        cart: _cart,
        selectedIndex: currentState.selectedIndex,
        filteredProducts: currentState.filteredProducts,
      );
    }
    return HomeLoaded(products: [], wishlist: _wishlist, cart: _cart, selectedIndex: 0, filteredProducts: []);
  }
}
