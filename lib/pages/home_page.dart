import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view/product_grid.dart';
import '../view/header_view.dart';
import '../models/product_model.dart';
import '../themes/current_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Product> products = [
    Product(
        name: 'Nike Shox',
        oldPrice: 799.90,
        newPrice: 599.90,
        photoLink:
            'https://cdn.dooca.store/2452/products/wdqwxzcajejjvovsb7sslu31jw2cwgfimmha_640x640+fill_ffffff.jpg?v=1623876234&webp=0'),
    Product(
        name: 'Nike Air Max SC',
        oldPrice: 499.90,
        newPrice: 399.90,
        photoLink:
            'https://static.netshoes.com.br/produtos/tenis-nike-air-max-lite-masculino/72/2IC-6035-172/2IC-6035-172_zoom1.jpg?ts=1646397764'),
    Product(
        name: 'Nike Vapor Max',
        oldPrice: 519.90,
        newPrice: 379.50,
        photoLink: 'https://cf.shopee.com.br/file/e115910b2df3bc57a9c07a0cd346b481'),
    Product(
        name: 'Adidas Springblade',
        oldPrice: 899.90,
        newPrice: 749.90,
        photoLink:
            'https://static.netshoes.com.br/produtos/tenis-adidas-springblade-pro-feminino/06/D13-5794-206/D13-5794-206_zoom1.jpg?ts=1664380024'),
    Product(
        name: 'Adidas Grand Court',
        oldPrice: 399.90,
        newPrice: 229.90,
        photoLink:
            'https://kallan.vteximg.com.br/arquivos/ids/305229-1140-1140/56020013_002_1-TEN-FEM-STR-GRAND-COURT-W.jpg?v=637885585437730000'),
    Product(
        name: 'Adidas Coreracer',
        oldPrice: 299.90,
        newPrice: 219.90,
        photoLink: 'https://imgs.pontofrio.com.br/1543186116/1xg.jpg?imwidth=292'),
    Product(
        name: 'Mizuno Wave Creation Branco',
        oldPrice: 1059.90,
        newPrice: 829.90,
        photoLink:
            'https://d3ugyf2ht6aenh.cloudfront.net/stores/001/046/624/products/tenis-mizuno-wave-creation-20-101630-411-a28598e2fa08369d9116184159603159-1024-1024.jpg'),
    Product(
        name: 'Mizuno Wave Frontier Cinza',
        oldPrice: 489.90,
        newPrice: 379.90,
        photoLink:
            'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/spacetennis/media/uploads/produtos/foto/b10f5b687bb8c5.jpg'),
    Product(
        name: 'Mizuno Wave Frontier Azul',
        oldPrice: 489.90,
        newPrice: 379.90,
        photoLink:
            'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/spacetennis/media/uploads/produtos/foto/b263af323df441.jpg'),
    Product(
        name: 'Mizuno Wave Frontier Preto',
        oldPrice: 489.90,
        newPrice: 329.90,
        photoLink:
            'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/spacetennis/media/uploads/produtos/foto/bdebff3439ddafro-1.jpg'),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchInput = "";

  final List<NetworkImage> highlightimages = const [
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=1"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=2"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=3"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=4"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=5"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=6"),
    NetworkImage("https://picsum.photos/1200/720/?blur=1?random=7")
  ];
  final List<String> highlights = [
    "Tenis em Oferta",
    "Meias em Oferta",
    "Camisas em Oferta",
    "Blusas em Oferta",
    "Calças em Oferta",
    "Sandálias em Oferta",
    "Bonés em Oferta",
  ];

  @override
  void didChangeDependencies() {
    for (ImageProvider image in highlightimages) {
      precacheImage(image, context);
    }

    super.didChangeDependencies();
  }

  void updateFilteredProducts(String input) {}

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts =
        widget.products.where((product) => product.name.toLowerCase().contains(searchInput.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: 15),
            const Text(
              'Nossos Produtos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: TextField(
                  maxLines: 1,
                  //cursorHeight: 30,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    labelText: 'Pesquise produtos',
                    hintStyle: const TextStyle(color: Colors.black),
                    filled: false,
                    fillColor: theme.secondaryColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.only(bottom: 20),
                  ),
                  onChanged: (value) => setState(() {
                        searchInput = value;
                      })),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      itemCount: highlightimages.length,
                      slideTransform: const BackgroundToForegroundTransform(),
                      initialPage: 0,
                      unlimitedMode: true,
                      enableAutoSlider: true,
                      autoSliderTransitionTime: const Duration(seconds: 1),
                      autoSliderDelay: const Duration(seconds: 5),
                      slideBuilder: (index) => Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(image: highlightimages[index], fit: BoxFit.fitWidth, opacity: 0.8)),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Text(highlights[index],
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32)))),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProductGridView(
                    listaDeProdutos: filteredProducts,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          canLaunchUrl(Uri.parse('https://wa.me/message/JQWZEC2SVMRGE1')).then((value) => {
                if (value == true) {launchUrl(Uri.parse('https://wa.me/message/JQWZEC2SVMRGE1'))}
              })
        },
        tooltip: 'Contato',
        backgroundColor: Colors.green,
        child: const Icon(Icons.whatsapp),
      ),
    );
  }
}
