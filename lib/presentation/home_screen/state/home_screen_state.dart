import 'package:fakestore_shopping_application/model/product_model.dart';

class HomeScreenState {
  bool isLoading;
  List<ProductModel> products;
  String? errorMsg;

  HomeScreenState({
    required this.isLoading,
    required this.products,
    this.errorMsg,
  });

  HomeScreenState copyWith({
    bool? isLoading,
    List<ProductModel>? items,
    String? errorMsg,
  }) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      products: items ?? this.products,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
