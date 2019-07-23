import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Pages/authentication.dart';
import 'Pages/product_admin.dart';
import 'Pages/product_details.dart';
import 'Pages/product_home.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();

    return ScopedModel<MainModel>(
      //Creating a instance of our ProjectScopeModel in the main class so that we can pass it down to entire widget tree attached to it.
      model: model,
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.lime,
            accentColor: Colors.lightBlue,
            brightness: Brightness.light),
        home: Authentication(),
        routes: {
          '/product_home': (BuildContext context) => ProductHome(model),
          '/admin': (BuildContext context) => ProductAdmin(),
        },
        onGenerateRoute: (RouteSettings settings) {
          List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);

            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductsDetails(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settngs) {
          MaterialPageRoute(
            builder: (BuildContext context) => ProductHome(model),
          );
        },
      ),
    );
  }
}
