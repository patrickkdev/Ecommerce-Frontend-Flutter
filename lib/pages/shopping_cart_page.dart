import 'dart:convert';

import 'package:e_commerce_universal/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../repository/cart_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class CartProduct {
  Product product;
  int quantity;

  CartProduct(this.product, this.quantity);
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<CartProduct> cartItems = [];
  double purchaseTotal = 0;

  double totalValue() {
    double total = 0;
    for (Product item in itemsInCart) {
      total += item.newPrice;
    }
    return total;
  }

  Future<String> createMPItem(double totalPrice, List<CartProduct> cartProducts) async {
    int externalReference = DateTime.now().millisecondsSinceEpoch;

    List<Map<String, Object>> mappedProducts = cartProducts
        .map((cartProduct) => {
              'title': cartProduct.product.name,
              'quantity': cartProduct.quantity,
              'currency_id': 'BRL',
              'unit_price': cartProduct.product.newPrice,
              'picture_url': cartProduct.product.photoLink,
            })
        .toList();

    Map<String, Object> body = {
      'notification_url': 'https://patrickanywhere.pythonanywhere.com/webhook',
      'external_reference': externalReference.toString(),
      'items': mappedProducts
    };

    print(json.encode(body));

    Response r = await post(
      Uri.parse(
          'https://api.mercadopago.com/checkout/preferences?access_token=TEST-8275282535268600-062615-73f2c867d47c674f101605ada8c4ad7d-205053078'),
      body: json.encode(body),
    );

    String initPoint = jsonDecode(r.body)['sandbox_init_point'];

    canLaunchUrl(Uri.parse(initPoint)).then((value) => {
          if (value == true) {launchUrl(Uri.parse(initPoint))}
        });

    return r.body;
  }

  List<CartProduct> assignCartProducts() {
    List<CartProduct> cartProducts = [];
    for (Product item in itemsInCart) {
      if (cartProducts.indexWhere((cartItem) => cartItem.product == item) == -1) {
        cartProducts.add(CartProduct(item, 1));
      } else {
        cartProducts[cartProducts.indexWhere((cartItem) => cartItem.product == item)].quantity += 1;
      }
    }
    return cartProducts;
  }

  @override
  Widget build(BuildContext context) {
    cartItems = assignCartProducts();
    purchaseTotal = totalValue();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Meu carrinho',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text('        ')
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(cartItems.length.toString() + ' items no carrinho', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      boxShadow: const [BoxShadow(blurRadius: 5)],
                                      shape: BoxShape.circle,
                                      image:
                                          DecorationImage(fit: BoxFit.fill, image: NetworkImage(cartItems[index].product.photoLink))),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartItems[index].product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Tamanho 42',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.5))),
                                    Text(
                                        ' R\$ ' +
                                            cartItems[index].product.newPrice.toStringAsFixed(2) +
                                            ' x ' +
                                            cartItems[index].quantity.toString() +
                                            ' = R\$ ' +
                                            (cartItems[index].product.newPrice * cartItems[index].quantity).toStringAsFixed(2),
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Quantidade: ' + cartItems[index].quantity.toString()),
                                IconButton(
                                    onPressed: () => {
                                          itemsInCart
                                              .remove(itemsInCart[itemsInCart.indexWhere((item) => item == cartItems[index].product)]),
                                          setState(() {
                                            cartItems = assignCartProducts();
                                            purchaseTotal = totalValue();
                                          })
                                        },
                                    icon: const Icon(Icons.cancel_outlined)),
                              ],
                            ),
                          ],
                        )),
                  )),
        ),
        const SizedBox(
          height: 15,
        ),
        Text('Total da compra: R\$ ' + purchaseTotal.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        Material(
          color: Colors.green.shade900,
          child: InkWell(
              onTap: () => {if (totalValue() > 0) createMPItem(totalValue(), cartItems)},
              child: Ink(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: const Center(
                  child: Text(
                    'Pagar com Mercado Pago',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
        ),
      ]),
    );
  }
}
