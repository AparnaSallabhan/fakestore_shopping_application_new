import 'package:fakestore_shopping_application/model/product_model.dart';

class ProductDetailScreenState {
  bool isLoading;
  ProductModel? product;
  ProductDetailScreenState({required this.isLoading, this.product});

  ProductDetailScreenState copyWith({bool? isLoading, ProductModel? product}) {
    return ProductDetailScreenState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
    );
  }
}
