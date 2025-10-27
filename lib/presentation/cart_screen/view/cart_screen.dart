import 'package:fakestore_shopping_application/presentation/cart_screen/controller/cart_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartScreenState = ref.watch(cartProvider);

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
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xff464646),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: cartScreenState.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xffa5b490)))
          : cartScreenState.items.isEmpty
          ? Center(
              child: Text(
                'No items found in cart!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = cartScreenState.items[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Image.network(item.image ?? "", height: 100, width: 100),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? "",
                              style: TextStyle(
                                color: Color(0xFF5C5B5B),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              '\$${item.price}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffb1c09f),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SizedBox(height: 5),

                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .decreaseQuantity(item);
                                  },
                                  overlayColor: WidgetStatePropertyAll(
                                    Colors.transparent,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF77885F),
                                    radius: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Icon(
                                        Icons.minimize_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),

                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF77885F),
                                  ),
                                ),

                                SizedBox(width: 10),

                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .increaseQuantity(item);
                                  },
                                  overlayColor: WidgetStatePropertyAll(
                                    Colors.transparent,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF77885F),
                                    radius: 15,
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                                Spacer(),

                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .removeFromCart(item);
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: cartScreenState.items.length,
            ),
    );
  }
}
