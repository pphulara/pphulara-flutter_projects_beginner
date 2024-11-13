import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/pages/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return login_page_state();
  }
}

class login_page_state extends State<LoginScreen>{
  double? _deviceheight,_devicewidth;
  bool _obscureText = false;
  final GlobalKey <FormState> _loginFormKey = GlobalKey<FormState>();
  late String _id;
  late String _password;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    _deviceheight=MediaQuery.of(context).size.height;
    _devicewidth=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleText(),
              Container(
                alignment: Alignment.center,
                height: _devicewidth!*0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _loginForm(),
                    _loginButton(),
                  ],
                ),
              ),
              SizedBox(height: _deviceheight!*0.01,)
            ],
          ),
      ),
    );
  }

  Widget _titleText(){
    return Container(
      height: _deviceheight!*0.40,
      width: _devicewidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(150)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'Student Attendance\nApp',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NexaBold',
            fontSize: _devicewidth!*0.10,
          ),
        ),
      ),
    );
  }

  Widget _loginForm(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _devicewidth!*0.05),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _studentid(),
            SizedBox(height: _deviceheight!*0.005,),
            _passwordTextfield(),
          ],
        ),
      ),
    );
  }

  Widget _studentid(){
    return TextFormField(
      onSaved: (_value){setState(() {
        _id=_value!;
      });},
      validator: (_value){
        bool _result = _value!.contains(RegExp(r"^^[A-Za-z]{3}\d+$"));
            return _result? null : "Please enter a valid Student ID";
        },
      decoration: InputDecoration(
        hintText: 'Student ID',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }


  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }  

  Widget _passwordTextfield(){
    return TextFormField(
      obscureText: !_obscureText,
      onSaved: (_value){
        setState(() {
          _password=_value!;
        });
      },
      validator: (_value) {return _value!.length > 6 ? null : "Enter password with more than 6 characters";},
       decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            _obscureText ?  Icons.visibility : Icons.visibility_off,
          ),
          ),
        hintText: 'Password',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _loginButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _devicewidth!*0.05),
      child: MaterialButton(
        onPressed: _loginuser,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: _deviceheight!*0.01),
        child: Center(
          child: Text(
            'Log in',
            style: TextStyle(
              fontSize: _deviceheight!*0.025,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

Future<void> _loginuser() async {
  if (_loginFormKey.currentState!.validate()) {
    _loginFormKey.currentState!.save();
                        String id = _id;
                    String password = _password;
    FocusScope.of(context).unfocus();
    QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("students").where('id', isEqualTo: id).get();

                      try {
                        if(password == snap.docs[0]['password']) {
                          sharedPreferences = await SharedPreferences.getInstance();

                          sharedPreferences.setString('studentId', id).then((_) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => HomeScreen())
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Password is not correct!"),
                          ));
                        }
                      } catch(e) {
                        print(e);
}
}
}
}



