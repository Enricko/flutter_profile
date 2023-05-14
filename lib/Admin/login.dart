import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_profile/Controller/auth.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  submit(){
    var mail = email.text;
    var pass = password.text;

    var data = {
      'email' :mail,
      'password':pass
    };
    if(mail == '' || pass == ''){
      EasyLoading.showError('Please Input Email & Password',dismissOnTap: true);
      return;
    }

    Auth.login(data,context);
  }
  @override
  void initState() {
    if(FirebaseAuth.instance.currentUser != null){
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).pushReplacementNamed("/admin");
      });
      EasyLoading.showSuccess('You already logged',dismissOnTap: true);
      return;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: 500,
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "Your Email",
                    labelText: "Your Email",
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white
                    ),
                    prefixIcon: Padding(
                      padding:  EdgeInsets.all(10),
                      child: Icon(Icons.email),
                    ),
                    prefixIconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "Your Password",
                    labelText: "Your Password",
                    hintStyle: TextStyle(
                      color: Colors.white
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white
                    ),
                    prefixIcon: Padding(
                      padding:  EdgeInsets.all(10),
                      child: Icon(Icons.password),
                    ),
                    prefixIconColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 125,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => submit(),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}