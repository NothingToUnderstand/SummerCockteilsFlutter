import '../models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/CardListItem.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = context.watch<CartDataProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Корзинка счастья'),
        ),
        body: cartData.cartItems.isEmpty
            ? Card(
                elevation: 5.0,
                margin: const EdgeInsets.all(30.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Корзинка пустая ;(',
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Стоимость: ${cartData.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      MaterialButton(
                        onPressed: () {
                          cartData.clear();
                        },
                        color: Theme.of(context).primaryColor,
                        child: const Text('Купить'),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(child: CardItemList(cartData: cartData)),
                ],
              ));
  }
}
