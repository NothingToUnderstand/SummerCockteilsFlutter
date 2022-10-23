import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/Cart.dart';
import '../models/Product.dart';
import 'CardPage.dart';

class ItemPage extends StatelessWidget {

  final String productId;

  const ItemPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {

    final data = context.watch<DataProductProvider>()
        .getElementById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title, style: GoogleFonts.marmelad(),),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: data.imgUrl,
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Card(
            elevation: 5.0,
            margin: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Text(data.title, style: const TextStyle(fontSize: 26.0),),
                  const Divider(),
                  Row(
                    children: <Widget>[
                      const Text('Цена: ', style: TextStyle(fontSize: 24.0),),
                      Text('${data.price}', style: const TextStyle(fontSize: 24.0),),
                    ],
                  ),
                  const Divider(),
                  Text(data.description),

                  const SizedBox(
                    height: 20.0,
                  ),

                  //Provider.of<CartDataProvider>(context)
                  context.watch<CartDataProvider>()
                      .cartItems
                      .containsKey(productId)
                      ? Column(
                    children: <Widget>[
                      MaterialButton(
                          color: const Color(0xFFCCFF90),
                          child: const Text('Перейти в корзину'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CardPage(),
                            ));
                          }
                      ),
                      const Text(
                        'Товар уже добавлен в корзину',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blueGrey,
                        ),
                      )
                    ],
                  )
                      : MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: const Text('Добавить в корзину'),
                    onPressed: () {
                      context.read<CartDataProvider>().addItem(
                        productId: data.id,
                        imgUrl: data.imgUrl,
                        title: data.title,
                        price: data.price,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}