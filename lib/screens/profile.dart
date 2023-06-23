import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  String name = 'John Doe';
  int age = 30;
  String gender = 'Male';

  void updateProfile(String newName, int newAge, String newGender) {
    setState(() {
      name = newName;
      age = newAge;
      gender = newGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Age: $age',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Gender: $gender',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Medical Report 1'),
                  subtitle: Text('Date: 01/01/2022'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Add functionality to view medical report
                  },
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Medical Report 2'),
                  subtitle: Text('Date: 02/01/2022'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Add functionality to view medical report
                  },
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _showUpdateDialog();
                },
                child: Text('Update Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = name;
        int newAge = age;
        String newGender = gender;

        return AlertDialog(
          title: Text('Update Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  newName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  newAge = int.tryParse(value) ?? age;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Gender'),
                onChanged: (value) {
                  newGender = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateProfile(newName, newAge, newGender);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}