import 'package:fakestore_shopping_application/presentation/cart_screen/controller/cart_screen_controller.dart';
import 'package:fakestore_shopping_application/presentation/product_detail_screen/controller/product_detail_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailState = ref.watch(productDetailProvider(id));

    final product = productDetailState.product;

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: productDetailState.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xffa5b490)))
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product?.image ?? "", fit: BoxFit.cover),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?.title ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${product?.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF77885F),
                                  ),
                                ),

                                product?.rating?.rate != null
                                    ? Text(
                                        'Rating: ${product?.rating?.rate}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff929292),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),

                            SizedBox(height: 5),

                            Text(
                              product?.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF5C5A5A),
                              ),
                            ),

                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      ref.read(cartProvider.notifier).addToCart(product!);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.title} added to cart"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF77885F),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
