import 'package:first_app/Widgets/products/products.dart';
import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductHome extends StatefulWidget {
  MainModel model;
  ProductHome(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductHomeState();
  }
}

class _ProductHomeState extends State<ProductHome> {
  _buildProductWidget() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Products Found'));

        if (model.displayProducts.length > 0 && !model.isLoading) {
          return content = Product();
        } else if (model.isLoading) {
          return content = Center(child: CircularProgressIndicator());
        }

        return content;
      },
    );
  }

  @override
  void initState() {
    widget.model.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Choose'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Product'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/admin',
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget widget, MainModel model) {
              return IconButton(
                color: Colors.white,
                icon: Icon(model.getToogleStatus
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toogleDisplayModeStatus();
                },
              );
            },
          )
        ],
        title: Text('Easy List'),
      ),
      body: _buildProductWidget(),
    );
  }
}
