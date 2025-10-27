import 'package:fakestore_shopping_application/model/cart_item_model.dart';

class CartScreenState {
  bool isLoading;
  List<CartModel> items = [];
  CartScreenState({required this.items, required this.isLoading});

  CartScreenState copyWith({List<CartModel>? items, bool? isLoading}) {
    return CartScreenState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
