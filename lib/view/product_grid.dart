import 'dart:math';

import 'package:e_commerce_universal/pages/product_page.dart';

import '../themes/app_theme.dart';
import '../models/product_model.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> listaDeProdutos;
  final AppTheme theme;

  ProductGridView({AppTheme? theme, List<Product>? listaDeProdutos, super.key})
      : listaDeProdutos = listaDeProdutos ?? const [],
        theme = theme ?? AppTheme.lightDefault();

  @override
  Widget build(BuildContext context) {
    int axisCount = min(8, max(2, (MediaQuery.of(context).size.width ~/ 175).toInt()));

    return GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: axisCount, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.65),
        itemCount: listaDeProdutos.length,
        itemBuilder: (context, index) => Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              child: InkWell(
                onTap: (() =>
                    {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductViewPage(listaDeProdutos[index])))}),
                child: Ink(
                  decoration: BoxDecoration(
                    color: theme.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //width: (MediaQuery.of(context).size.width / axisCount) - 0,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        listaDeProdutos[index].photoLink,
                                      ),
                                      fit: BoxFit.fitWidth)),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            left: 5,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow.shade700,
                                ),
                                SizedBox(width: 5),
                                Text((4 + Random().nextDouble()).toStringAsFixed(1)),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 5),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.trending_up, color: Colors.amber.shade900),
                        const SizedBox(width: 5),
                        Text(
                          'Mais Vendido',
                          style: TextStyle(color: Colors.amber.shade900),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      //const SizedBox(height: 5),
                      Text(
                        listaDeProdutos[index].name,
                        style: TextStyle(color: Colors.blue.shade900, decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'de R\$' + listaDeProdutos[index].oldPrice.toStringAsFixed(2),
                        style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'por R\$' + listaDeProdutos[index].newPrice.toStringAsFixed(2),
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ));
  }
}
