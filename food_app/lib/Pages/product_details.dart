import 'package:first_app/scoped-model/main_model.dart';
import 'package:first_app/ui_elements/address_tag.dart';
import 'package:first_app/ui_elements/title_default.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsDetails extends StatelessWidget {

  final index;
  ProductsDetails(this.index);

  _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('This action cannot be undone'),
          actions: <Widget>[
            FlatButton(
              child: Text('Discard'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder:
            (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Details'),
            ),
            body: Column(
              children: <Widget>[
                Card(child: Image.asset(model.allProducts[index].imgUrl)),
                TitleDefault(model.allProducts[index].title),
                SizedBox(
                  height: 5.0,
                ),
                AddressTag(),
                Text(
                  model.allProducts[index].description,
                  style: TextStyle(fontFamily: 'Oswald', fontSize: 18.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    _showDialog(context);
                    //Navigator.pop(context, true);
                  },
                  child: Text('Delete'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
