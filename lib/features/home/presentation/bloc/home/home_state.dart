// home_state.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<dynamic> products;
  final List<String> wishlist;
  final List<String> cart;
  final int selectedIndex;
  final List<dynamic> filteredProducts;

  HomeLoaded({
    required this.products,
    required this.wishlist,
    required this.cart,
    required this.selectedIndex,
    required this.filteredProducts,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

class AuthState extends HomeState {
  final User? user;

  AuthState({this.user});
}
