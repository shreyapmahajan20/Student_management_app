import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddElectiveScreen extends StatefulWidget {
  @override
  _AddElectiveScreenState createState() => _AddElectiveScreenState();
}

class _AddElectiveScreenState extends State<AddElectiveScreen> {
  final _formKey = GlobalKey<FormState>();
  String _subjectName = '';
  String _subjectCode = '';

  Future<void> addElective() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/electives'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'subject_name': _subjectName,
        'subject_code': _subjectCode,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Elective added successfully')));
      Navigator.pop(context); // Go back after successful add
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add elective')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Elective')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subject name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _subjectName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subject code';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _subjectCode = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addElective();
                  }
                },
                child: Text('Add Elective'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
