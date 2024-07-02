import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  void register() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }else{
      print("Mistake");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"), centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                onSaved: (value){
                  email = value!;
                },
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                onSaved: (value){
                  password = value!;
                },
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Enter your Stupid Password!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: register,
                  child: Text("Register"))
            ],
          ),
        ),
      )
    );
  }
}