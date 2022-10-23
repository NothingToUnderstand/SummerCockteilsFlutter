import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_cocktails/widgets/ItemCard.dart';

import '../models/Cart.dart';


class CardItemList extends StatelessWidget {
  final cartData;
  const CardItemList({super.key, this.cartData});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: cartData.cartItemsCount,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(cartData.cartItems.keys.toList()[index]),
            background: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              padding: const EdgeInsets.only(right: 10.0),
              child: const Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 30.0,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction)
            => Provider.of<CartDataProvider>(context, listen: false)
                .deleteItem(cartData.cartItems.keys.toList()[index]),
            child: ItemCard(
              cartData: cartData,
              index: index,
            ),
          );
        }
    );
  }
}