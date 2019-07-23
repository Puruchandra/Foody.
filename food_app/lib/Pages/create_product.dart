import 'package:first_app/models/product_model.dart';
import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import '../Widgets/helpers/ensure_visible.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateStateProduct();
  }
}

class _CreateStateProduct extends State<CreateProduct> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'imgUrl': 'assets/food.jpg'
  };
//the key holds the internal states of all widgets in the form
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _descNode = FocusNode();
  final FocusNode _priceNode = FocusNode();

  Widget _buildTitleTextField(ProductModel product) {
    return EnsureVisibleWhenFocused(
        focusNode: _titleNode,
        child: Container(
          child: TextFormField(
            focusNode: _titleNode,
            initialValue: product != null ? product.title : '',
            validator: (String value) {
              if (value.isEmpty || value.length < 5) {
                return 'Title is empty or less than 5 characters';
              }
            },
            onSaved: (String value) {
              _formData['title'] = value;
            },
            decoration: InputDecoration(labelText: 'Enter Product Name'),
          ),
          margin: EdgeInsets.all(4.0),
        ));
  }

  Widget _buildDescriptionTextField(ProductModel product) {
    return EnsureVisibleWhenFocused(
        focusNode: _descNode,
        child: Container(
          child: TextFormField(
            focusNode: _descNode,
            initialValue: product != null ? product.description : '',
            validator: (String value) {
              if (value.isEmpty || value.length < 10) {
                return 'Description is empty or less than 10 charactes';
              }
            },
            onSaved: (String value) {
              _formData['description'] = value;
            },
            decoration: InputDecoration(labelText: 'Enter Description'),
            maxLines: 4,
          ),
          margin: EdgeInsets.all(4.0),
        ));
  }

  Widget _buildPriceTextField(ProductModel product) {
    return EnsureVisibleWhenFocused(
        focusNode: _priceNode,
        child: Container(
          child: TextFormField(
            focusNode: _priceNode,
            keyboardType: TextInputType.number,
            initialValue: product != null ? product.price.toString() : '',
            validator: (String value) {
              if (value.isEmpty ||
                  !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                return 'Price is empty';
              }
            },
            onSaved: (String value) {
              _formData['price'] = double.parse(value);
            },
            decoration: InputDecoration(labelText: 'Enter Price'),
          ),
          margin: EdgeInsets.all(4.0),
        ));
  }

  Widget _buildSaveBtn(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () => _submitDetails(
                      model.addProducts,
                      model.updateProduct,
                      model.selectedProductIndex,
                      model.selectProduct),
                  child: Text('Save'),
                ),
              );
      },
    );
  }

  void _submitDetails(Function addProduct, Function updateProduct,
      int selectedProductIndex, Function setSelectedIndex) {
    //this is will only return true if all validates
    if (!_formKey.currentState.validate()) {
      return;
    }

    // this will call all the onSaved of TextFormInput

    _formKey.currentState.save();
    if (selectedProductIndex == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['price'].toString(),
        _formData['imgUrl'],
      ).then((_) {
        Navigator.pushReplacementNamed(context, '/product_home')
            .then((_) => setSelectedIndex(null));
      });
    } else
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['price'].toString(),
        _formData['imgUrl'],
      ).then((_) {
        Navigator.pushReplacementNamed(context, '/product_home')
            .then((_) => setSelectedIndex(null));
      });
  }

  Widget _buildFormContent(BuildContext context, ProductModel selectedProduct) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
        onTap: () {
          //basically we passing empty focus node to so that on tap it hides the keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          // width: targetWidth,
          padding: EdgeInsets.all(4.0),
          child: Form(
            //a key used to access a widget from other parts of the app
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildTitleTextField(selectedProduct),
                _buildDescriptionTextField(selectedProduct),
                _buildPriceTextField(selectedProduct),
                SizedBox(
                  height: 10.0,
                ),
                _buildSaveBtn(context),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget formContent =
            _buildFormContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? formContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: formContent,
              );
      },
    );
  }
}
