import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditStudentScreen extends StatefulWidget {
  final int studentId;

  EditStudentScreen({required this.studentId});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  // Fetch student data to pre-fill the form
  Future<void> fetchStudentData() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/students/${widget.studentId}'),
    );

    if (response.statusCode == 200) {
      final student = jsonDecode(response.body);
      setState(() {
        _name = student['name'];
        _email = student['email'];
        _password = student['password'];
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load student data')));
    }
  }

  // Function to update student data
  Future<void> updateStudent() async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/students/${widget.studentId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': _name, 'email': _email, 'password': _password}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Student updated successfully')));
      Navigator.pop(context); // Go back to previous screen
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update student')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentData(); // Fetch student data when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _password,
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (value) => _password = value,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateStudent();
                  }
                },
                child: Text('Update Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
