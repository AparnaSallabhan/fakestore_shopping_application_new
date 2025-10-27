import 'package:fakestore_shopping_application/presentation/cart_screen/view/cart_screen.dart';
import 'package:fakestore_shopping_application/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:fakestore_shopping_application/presentation/product_detail_screen/view/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenState = ref.watch(homeScreenProvider);

    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        forceMaterialTransparency: true,
        title: Text(
          'FakeStore',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xff464646),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_bag_outlined, size: 30),
          ),

          SizedBox(width: 10),
        ],
      ),
      body: homeScreenState.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xffa5b490)))
          : homeScreenState.errorMsg != null
          ? Center(child: Text(homeScreenState.errorMsg ?? ''))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 280,
                      ),
                      itemCount: homeScreenState.products.length,
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final product = homeScreenState.products[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(product.id),
                              ),
                            );
                          },
                          overlayColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xFFC5C4C4)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.only(
                                    topLeft: Radius.circular(19),
                                    topRight: Radius.circular(19),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.cover,
                                      height: 180,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: TextStyle(
                                          color: Color(0xFF5C5B5B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      SizedBox(height: 5),

                                      Text(
                                        product.category,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF606D51),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      SizedBox(height: 5),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${product.price}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF3D3D3D),
                                            ),
                                          ),

                                          product.rating?.rate != null
                                              ? Text(
                                                  'Rating: ${product.rating!.rate}',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF959267),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
