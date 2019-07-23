import 'package:first_app/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Authentication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationState();
  }
}

class _AuthenticationState extends State<Authentication> {
  Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      style: TextStyle(color: Colors.white),
      onSaved: (String value) {
        _formData['email'] = value;
      },
      decoration: InputDecoration(
        labelText: 'Enter Username',
        labelStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
      decoration: InputDecoration(
        labelText: 'Enter Password',
        labelStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  void _onSubmit(Function login) {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushNamed(context, '/product_home');
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
        value: _formData['acceptTerms'],
        onChanged: (bool value) {
          setState(() {
            _formData['acceptTerms'] = value;
          });
        },
        title: Text(
          'Accept Terms',
          style: TextStyle(
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
            image: AssetImage('assets/sign_food_2.jpg'),
          ),
        ),
        padding: EdgeInsets.all(6.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.black.withAlpha(180),
            ),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(4.0),
                        child: _buildEmailTextField(),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        child: _buildPasswordTextField(),
                      ),
                      _buildAcceptSwitch(),
                      SizedBox(height: 10.0),
                      Center(
                        child: ScopedModelDescendant<MainModel>(
                          builder: (BuildContext context, Widget child,
                              MainModel model) {
                            return RaisedButton(
                              color: Theme.of(context).accentColor,
                              onPressed: () => _onSubmit(model.login),
                              child: Text('Login',
                                  style: TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
