 
import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';

import 'create_product.dart';
import 'list_product.dart';

class ProductAdmin extends StatelessWidget {

  MainModel model;
  ProductAdmin(this.model);
   
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/product_home');
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('Create Product'),
                icon: Icon(Icons.create),
              ),
              Tab(
                child: Text('List Products'),
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CreateProduct(),
            ListProduct(model),
          ],
        ),
      ),
    );
  }
}
