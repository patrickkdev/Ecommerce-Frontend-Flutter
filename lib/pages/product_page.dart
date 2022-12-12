import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/product_model.dart';
import '../repository/cart_repository.dart';
import './shopping_cart_page.dart';

class ProductViewPage extends StatefulWidget {
  final Product product;

  ProductViewPage(Product? product, {super.key}) : product = product ?? Product();

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  int numberOfItemsInCart = itemsInCart.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  //  height: MediaQuery.of(context).orientation == Orientation.portrait ? null : MediaQuery.of(context).size.height,

                  alignment: Alignment.center,
                  child: SizedBox(
                    width: min(320, MediaQuery.of(context).size.width),
                    child: Image.network(
                      widget.product.photoLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              BackButton(onPressed: (() => Navigator.pop(context))),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(numberOfItemsInCart.toString()),
                  IconButton(
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingCartPage())).then((value) => {
                                  setState(
                                    () {
                                      numberOfItemsInCart = itemsInCart.length;
                                    },
                                  )
                                })
                          },
                      icon: Icon(Icons.shopping_cart_rounded)),
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.grey.shade200,
                  boxShadow: [BoxShadow(blurRadius: 10)]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          widget.product.name,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        RatingBar(
                            glow: false,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                              full: Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                              ),
                              half: Icon(
                                Icons.star_half,
                                color: Colors.yellow.shade700,
                              ),
                              empty: Icon(
                                Icons.star_border,
                                color: Colors.yellow.shade700,
                              ),
                            ),
                            onRatingUpdate: (rating) => {print(rating)}),
                        const SizedBox(height: 15),
                        Text(
                          'de R\$' + widget.product.oldPrice.toStringAsFixed(2),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18, decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          'por R\$' + widget.product.newPrice.toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(height: 1, color: Colors.grey),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Material(
                color: Colors.blue.shade900,
                child: InkWell(
                    onTap: () => {print(5)},
                    child: Ink(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'Comprar agora',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ),
              Material(
                color: Colors.yellow.shade900,
                child: InkWell(
                    onTap: () => {
                          itemsInCart.add(widget.product),
                          setState(
                            () {
                              numberOfItemsInCart = itemsInCart.length;
                            },
                          )
                        },
                    child: Ink(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'Adicionar ao carrinho',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
