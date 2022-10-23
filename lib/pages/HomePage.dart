import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_cocktails/models/Product.dart';
import 'package:summer_cocktails/widgets/CardItem.dart';

import '../widgets/BottomBar.dart';
import '../widgets/CatalogListTile.dart';
import '../widgets/ItemCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productData =Provider.of<DataProductProvider>(context);


    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              const ListTile(
                title: Text("Fresh drinks",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold)
                ),
                subtitle: Text("More than 100 cocktails",
                  style: TextStyle(fontSize: 16)
                ),
                trailing: Icon(Icons.panorama_horizontal),
              ),
               Container(
                 padding: const EdgeInsets.all(5.0),
                 height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: productData.items.length,
                    itemBuilder: (context,int index)=>
                        ChangeNotifierProvider.value(value:productData.items[index],
                        child: const CardItem(),
                        )
                ) ,
              ),
              const Padding(padding: EdgeInsets.all(10.0),
                  child:Text("Catalog"),

              ),
              ...productData.items.map((value) {
                return CatalogListTile(imgUrl: value.imgUrl);
              }).toList(),

            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
