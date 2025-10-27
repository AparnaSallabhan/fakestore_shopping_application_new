import 'dart:convert';

import 'package:fakestore_shopping_application/model/product_model.dart';
import 'package:fakestore_shopping_application/presentation/product_detail_screen/state/product_detail_screen_state.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

final productDetailProvider =
    StateNotifierProvider.family<
      ProductDetailScreentateNotifier,
      ProductDetailScreenState,
      int
    >((ref, id) => ProductDetailScreentateNotifier(id));

class ProductDetailScreentateNotifier
    extends StateNotifier<ProductDetailScreenState> {
  ProductDetailScreentateNotifier(id)
    : super(ProductDetailScreenState(isLoading: false)) {
    fetchproduct(id);
  }

  fetchproduct(id) async {
    try {
      state = state.copyWith(isLoading: true);

      final url = Uri.parse('https://fakestoreapi.com/products/$id');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final product = ProductModel.fromJson(jsonDecode(response.body));

        state = state.copyWith(isLoading: false, product: product);
      }
    } catch (e) {
      print('ERROR FETCHING PRODUCT DETAIL : $e');
      state = state.copyWith(isLoading: false);
    }
  }
}
