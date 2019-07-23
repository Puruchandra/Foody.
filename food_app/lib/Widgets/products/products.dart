import 'package:first_app/models/product_model.dart';
import 'package:first_app/scoped-model/main_model.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Product_card.dart';

class Product extends StatelessWidget {
  //final Function deleteProduct;
 

  Widget _buildProductList(List<ProductModel> products) {
    return products.length > 0
        ? ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                ProductCard(products[index], index),
            itemCount: products.length,
          )
        : Center(
            child: Text('No products found!'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return _buildProductList(model.displayProducts);
    }); 
  }
}
