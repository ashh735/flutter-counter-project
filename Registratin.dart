
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _status = '';
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Status:'),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Radio(
                        value: 'active',
                        groupValue: _status,
                        onChanged: (value) {
                          setState(() {
                            _status = value as String;
                            _isActive = true;
                          });
                        },
                      ),
                      Text('Active'),
                      SizedBox(width: 16),
                      Radio(
                        value: 'inactive',
                        groupValue: _status,
                        onChanged: (value) {
                          setState(() {
                            _status = value as String;
                            _isActive = false;
                          });
                        },
                      ),
                      Text('Inactive'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile(_email, _password, _status, _isActive)),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyProfile extends StatelessWidget {
  final String _email;
  final String _password;
  final String _status;
  final bool _isActive;

  MyProfile(this._email, this._password, this._status, this._isActive);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Email: $_email'),
            Text('Password: $_password'),
            Text('Status: $_status'),
            Text('Active: ${_isActive ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
