import 'package:fakestore_shopping_application/model/cart_item_model.dart';
import 'package:fakestore_shopping_application/model/product_model.dart';
import 'package:fakestore_shopping_application/presentation/cart_screen/state/cart_screen_state.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

final cartProvider =
    StateNotifierProvider<CartScreenStateNotifier, CartScreenState>(
      (ref) => CartScreenStateNotifier(),
    );

class CartScreenStateNotifier extends StateNotifier<CartScreenState> {
  CartScreenStateNotifier()
    : super(CartScreenState(items: [], isLoading: false)) {
    loadCart();
  }

  final cartbBox = Hive.box<CartModel>("cartBox");

  loadCart() {
    state = state.copyWith(isLoading: true);

    final items = cartbBox.values.toList();

    state = state.copyWith(items: items, isLoading: false);
  }

  addToCart(ProductModel product) {
    try {
      final existingIndex = state.items.indexWhere(
        (item) => item.id == product.id,
      );

      if (existingIndex >= 0) {
        final existingItem = state.items[existingIndex];

        existingItem.quantity = (existingItem.quantity ?? 0) + 1;

        cartbBox.putAt(existingIndex, state.items[existingIndex]);
      } else {
        final newItem = CartModel(
          id: product.id,
          description: product.description,
          image: product.image,
          name: product.title,
          price: product.price,
          quantity: 1,
        );

        cartbBox.add(newItem);
      }

      loadCart();
    } catch (e) {
      print('ERROR ADDING ITEM TO CART :$e');
    }
  }

  removeFromCart(CartModel product) {
    int index = state.items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      cartbBox.deleteAt(index);
      loadCart();
    }
  }

  increaseQuantity(CartModel product) {
    final index = state.items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      final currentItem = state.items[index];
      final newQuantity = (currentItem.quantity ?? 0) + 1;

      currentItem.quantity = newQuantity;
      cartbBox.putAt(index, currentItem);

      state = state.copyWith(items: [...state.items]);
    }
  }

  decreaseQuantity(CartModel product) {
    final index = state.items.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      final currentItem = state.items[index];
      final newQuantity = (currentItem.quantity ?? 0) - 1;

      if (newQuantity > 0) {
        currentItem.quantity = newQuantity;
        cartbBox.putAt(index, currentItem);
      } else {
        cartbBox.deleteAt(index);
        loadCart();
      }

      state = state.copyWith(items: [...state.items]);
    }
  }

  // double get totalPrice {
  //   return state.items.fold(
  //     0,
  //     (sum, item) => sum + (item.price! * item.quantity),
  //   );
  // }
}
