import 'dart:convert';

import 'package:fakestore_shopping_application/model/product_model.dart';
import 'package:fakestore_shopping_application/presentation/home_screen/state/home_screen_state.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart ' as http;

final homeScreenProvider = StateNotifierProvider(
  (ref) => HomeScreenStateNotifier(),
);

class HomeScreenStateNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenStateNotifier()
    : super(HomeScreenState(isLoading: false, products: [])) {
    fetchProducts();
  }

  fetchProducts() async {
    try {
      state = state.copyWith(isLoading: true);

      final url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final products = (data as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();

        state = state.copyWith(
          isLoading: false,
          products: products,
          errorMsg: null,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, products: [], errorMsg: null);
      print('ERROR FETCHING PRODUCTS : $e');
    }
  }
}
