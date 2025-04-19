import 'package:flutter/material.dart';
import 'add_student.dart';
import 'edit_student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _students = [];

  // Fetch students from API
  Future<void> fetchStudents() async {
    final response = await http.get(
      Uri.parse(
        'http://localhost:5000/students',
      ), // Replace with your correct endpoint
    );

    if (response.statusCode == 200) {
      setState(() {
        _students = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load students')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudents(); // Fetch students when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Elective System'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome to the Student Elective System',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),

            // Buttons with improved design in a row
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                leading: Icon(Icons.add, color: Colors.green),
                title: Text('Add Student', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddStudentScreen()),
                  );
                },
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Edit Student', style: TextStyle(fontSize: 18)),
                onTap: () {
                  if (_students.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => EditStudentScreen(
                              studentId:
                                  _students[0]['student_id'], // Pass the dynamic studentId
                            ),
                      ),
                    );
                  }
                },
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                leading: Icon(Icons.view_list, color: Colors.orange),
                title: Text('View Students', style: TextStyle(fontSize: 18)),
                onTap: () {
                  _showStudentList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStudentList() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Student List'),
            content:
                _students.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                          _students.map<Widget>((student) {
                            return ListTile(
                              title: Text(student['name']),
                              subtitle: Text(student['email']),
                              trailing: Text(student['password']),
                            );
                          }).toList(),
                    ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }
}
