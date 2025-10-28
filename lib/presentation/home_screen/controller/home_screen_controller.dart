import 'dart:convert';

import 'package:fakestore_shopping_application/model/product_model.dart';
import 'package:fakestore_shopping_application/presentation/home_screen/state/home_screen_state.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

final homeScreenProvider =
    StateNotifierProvider<HomeScreenStateNotifier, HomeScreenState>((ref) {
      return HomeScreenStateNotifier();
    });

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
        var data = jsonDecode(response.body);
        List<ProductModel> product = [];
        for (var item in data) {
          final x = ProductModel.fromJson(item);
          product.add(x);
        }

        state = state.copyWith(isLoading: false, items: product);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMsg: e.toString());
    }
  }
}
