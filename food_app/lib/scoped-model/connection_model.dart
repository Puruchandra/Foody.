import 'package:first_app/models/product_model.dart';
import 'package:first_app/models/product_model.dart';
import 'package:first_app/models/user-model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectionModel extends Model {
  List<ProductModel> _products = [];
  UserModel _authenticatedUser;

  int _selProductIndex;
  bool isLoading = false;

  void addProducts(
      String title, String description, String price, String imgUrl) {
        isLoading = true;
    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'imgUrl':
          'https://image.shutterstock.com/image-photo/milk-chocolate-pieces-isolated-on-260nw-728366752.jpg',
      'price': price,
      'email': _authenticatedUser.email,
      'userId': _authenticatedUser.userId
    };

    http
        .post('https://flutter-food-app.firebaseio.com/.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      ProductModel newProduct = ProductModel(
          id: responseData['name'],
          title: title,
          description: description,
          price: double.parse(price),
          imgUrl: imgUrl,
          email: _authenticatedUser.email,
          userId: _authenticatedUser.userId);


      _products.add(newProduct);
      isLoading = false;
      notifyListeners();
    });
    _selProductIndex = null;
  }

  void fetchData() {
    isLoading = true;
    http
        .get('https://flutter-food-app.firebaseio.com/.json')
        .then((http.Response response) {
      final List<ProductModel> fetchedProductList = [];
      Map<String, dynamic> productListData = json.decode(response.body);
      productListData.forEach((String productId, dynamic productData) {
        final ProductModel product = ProductModel(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: double.parse(productData['price']),
          imgUrl: productData['imgUrl'],
          email: productData['email'],
          userId: productData['userId'],
        );
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      isLoading = false;
      notifyListeners();
    });
  }
}

class ProductScopedModel extends ConnectionModel {
  bool _showFavorites = false;

  List<ProductModel> get allProducts {
    return List.from(_products);
  }

  //used to retrieve  the index of the current product
  int get selectedProductIndex {
    return _selProductIndex;
  }

  ProductModel get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  bool get getToogleStatus {
    return _showFavorites;
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
  }

  void updateProduct(
      String title, String description, String price, String imgUrl) {
    ProductModel updatedProduct = ProductModel(
      title: title,
      description: description,
      price: double.parse(price),
      imgUrl: imgUrl,
      email: _authenticatedUser.email,
      userId: _authenticatedUser.userId,
    );

    _products[selectedProductIndex] = updatedProduct;
  }

  void toogleFavoriteProductStatus() {
    bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    bool newFavoriteStatus = !isCurrentlyFavorite;
    final ProductModel updatedProduct = ProductModel(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        imgUrl: selectedProduct.imgUrl,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updatedProduct;

    notifyListeners();
  }

  List<ProductModel> get displayProducts {
    if (_showFavorites) {
      return _products
          .where((ProductModel product) => product.isFavorite)
          .toList();
    }
    return List.from(_products);
  }

  void selectProduct(int index) {
    _selProductIndex = index;
  }

  void toogleDisplayModeStatus() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

class UserScopedModel extends ConnectionModel {
  void login(String email, String password) {
    _authenticatedUser =
        UserModel(userId: 'xy1ys', email: email, password: password);
  }
}
  