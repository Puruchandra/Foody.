import 'package:first_app/Pages/create_product.dart';
import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ListProduct extends StatefulWidget {

  final MainModel model;
  ListProduct(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ListProductState();
  }
 }

class _ListProductState extends State<ListProduct> {

  @override
  initState(){
    widget.model.fetchData();
    super.initState();
  }

  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.create),
      onPressed: () {
        model.selectProduct(index);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return CreateProduct();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

 
    return ScopedModelDescendant<MainModel>(builder:
        (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                }

                // else if(direction == DismissDirection.startToEnd)
              },
              key: Key(model.allProducts[index].title),
              background: Container(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/food.jpg'),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle:
                        Text('\$' + model.allProducts[index].price.toString()),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ));
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
