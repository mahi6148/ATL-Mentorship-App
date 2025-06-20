import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfileState();
}

class _ProfileState extends State<Profilescreen> {
  bool _isEditing = false;
  File? _profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedBranch='CSE';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    collegeController.dispose();
    universityController.dispose();
    rollNoController.dispose();
    branchController.dispose();
    //addressController.dispose();
    districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _isEditing ? _pickImage : null,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/icons/Checklist.png') as ImageProvider,
                child: _isEditing
                    ? Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.black),
                    ),
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Edit Profile',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField("Full Name", nameController),
            _buildTextField("Mail ID", emailController),
            _buildGenderDropdown(),
            _buildTextField("Ph.no", phoneController),
            _buildTextField("College", collegeController),
            _buildTextField("University", universityController),
            _buildTextField("Roll No", rollNoController),
            _buildBranchDropdown(),
            _buildTextField("District", districtController),
            const SizedBox(height: 20),
            Row(
              children: [

                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isEditing) {
                        setState(() {
                          _isEditing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile saved successfully!")),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(_isEditing ? "Save" : "Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        readOnly: !_isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedGender,
            isExpanded: true,
            items: ['Male', 'Female', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: _isEditing
                ? (String? newValue) {
              setState(() {
                _selectedGender = newValue!;
              });
            }
                : null,
          ),
        ),
      ),
    );
  }
  Widget _buildBranchDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Branch',
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedBranch,
            isExpanded: true,
            items: ['CSE', 'EEE', 'Other'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: _isEditing
                ? (String? newValue) {
              setState(() {
                _selectedBranch = newValue!;
              });
            }
                : null,
          ),
        ),
      ),
    );
  }


}