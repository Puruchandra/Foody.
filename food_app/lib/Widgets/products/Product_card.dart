import 'package:first_app/Widgets/products/price_tag.dart';
import 'package:first_app/models/product_model.dart';
import 'package:first_app/scoped-model/main_model.dart';
import 'package:first_app/ui_elements/address_tag.dart';
import 'package:first_app/ui_elements/title_default.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel products;
  final int index;

  ProductCard(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(products.imgUrl),
          Container(
            padding: EdgeInsets.only(top: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleDefault(products.title),
                PriceTag(products.price.toString())
              ],
            ),
          ),
          AddressTag(),
          
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.info),
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + index.toString()),
              ),
              ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child,
                    MainModel model) {
                  return IconButton(
                    color: Colors.red,
                    icon: Icon(model.allProducts[index].isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      model.selectProduct(index);
                      model.toogleFavoriteProductStatus();
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
