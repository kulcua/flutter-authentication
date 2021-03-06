import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //bool isLoading = false;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  int money = 10000000;
  String phone = '';
  String pin = '0';
  String error = '';
  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Đăng kí',
                  style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Color(0xff5e63b6),
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      )),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Color(0xff5e63b6),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    validator: (val) => val.isEmpty ? 'Nhập email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    validator: (val) =>
                    val.length < 6 ? 'Mật khẩu phải hơn 6 kí tự' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    maxLength: 45,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      labelText: 'Tên của bạn',
                    ),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Số điện thoại',
                    ),
                    onChanged: (val) {
                      setState(() => phone = val);
                    },
                  ),
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 60.0),
                    color: Color(0xff5e63b6),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(
                            context,
                            id,
                            email,
                            password,
                            name,
                            money,
                            phone,
                            pin);
                        if (result == null) {
                          setState(() {
                            error = 'Email không tồn tại';
                          });
                        }
                      }
                    },
                    child: Text(
                      "Đăng kí",
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          )),)
                ),
                FlatButton(
                  child: Text('Đăng nhập',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                            color: Color(0xff142850),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          )),),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ));
  }
}
