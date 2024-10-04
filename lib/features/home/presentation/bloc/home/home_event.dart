// home_event.dart
abstract class HomeEvent {}

class LoadProductsEvent extends HomeEvent {}

class ToggleWishlistEvent extends HomeEvent {
  final String productId;
  ToggleWishlistEvent(this.productId);
}

class ToggleCartEvent extends HomeEvent {
  final String productId;
  ToggleCartEvent(this.productId);
}

class ChangeBottomNavEvent extends HomeEvent {
  final int index;
  ChangeBottomNavEvent(this.index);
}

class SearchProductsEvent extends HomeEvent {
  final String query;
  SearchProductsEvent(this.query);
}

class SignInEvent extends HomeEvent {}

class SignOutEvent extends HomeEvent {}
