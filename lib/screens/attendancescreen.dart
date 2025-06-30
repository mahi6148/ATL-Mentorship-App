import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/AuthController.dart';
import '../services/attendance_table_amplify_service.dart';

class Attendancescreen extends StatefulWidget {
  const Attendancescreen({super.key});

  @override
  State<Attendancescreen> createState() => _AttendancescreenState();
}

class _AttendancescreenState extends State<Attendancescreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _moduleController = TextEditingController();
  final TextEditingController _boysController = TextEditingController();
  final TextEditingController _girlsController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _topicsController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  Map<String, bool> options = {
    '6': false,
    '7': false,
    '8': false,
    '9': false,
  };
  XFile? _attendanceImage;
  final ImagePicker _picker = ImagePicker();
  final authController = Get.put(AuthController());


  List<String> get selectedClasses =>
      options.entries.where((e) => e.value).map((e) => e.key).toList();


  @override
  void initState() {
    super.initState();
    _fetchLocation();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _startTimeController.addListener(() => setState(() {}));
    _endTimeController.addListener(() => setState(() {}));
    _teacherController.addListener(() => setState(() {}));
    _moduleController.addListener(() => setState(() {}));
    _boysController.addListener(() => setState(() {}));
    _girlsController.addListener(() => setState(() {}));
    _totalController.addListener(() => setState(() {}));
    _mnameController.addListener(() => setState(() {}));
    _topicsController.addListener(() => setState(() {}));
    _remarksController.addListener(() => setState(() {}));
  }

  Future<void> _isFormValid() async {
    if (_startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty ||
        _teacherController.text.isEmpty ||
        _moduleController.value.text.isEmpty ||
        _boysController.value.text.isEmpty ||
        _girlsController.value.text.isEmpty ||
        _totalController.value.text.isEmpty ||
        _mnameController.text.isEmpty ||
        _topicsController.text.isEmpty ||
        _remarksController.text.isEmpty ||
        selectedClasses.isEmpty ||
        _attendanceImage == null) {
      Get.snackbar(
        'Incomplete Form',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    void _clearForm() {
      _startTimeController.clear();
      _endTimeController.clear();
      _teacherController.clear();
      _moduleController.clear();
      _boysController.clear();
      _girlsController.clear();
      _totalController.clear();
      _mnameController.clear();
      _topicsController.clear();
      _remarksController.clear();
      _attendanceImage = null;
      options.updateAll((key, value) => false);
      _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
      _fetchLocation(); // Optional: re-fetch location
      setState(() {});  // Refresh UI
    }

    try {
      // Parse the date correctly from dd/MM/yyyy format
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);

      bool success = await AttendanceTableAmplifyService.saveAttendance(
        start_time: _startTimeController.text,
        end_time: _endTimeController.text,
        teachers: _teacherController.text,
        module_no: int.parse(_moduleController.text),
        no_of_boys: int.parse(_boysController.text),
        no_of_girls: int.parse(_girlsController.text),
        total: int.parse(_totalController.text),
        module_name: _mnameController.text,
        topics_covered: _topicsController.text,
        remarks: _remarksController.text,
        class_attended: selectedClasses,
        longitude: double.parse(_longitudeController.text),
        latitude: double.parse(_latitudeController.text),
        date: parsedDate,
      );

      if (success) {
        _clearForm();
        Get.snackbar(
          'Success',
          'Details saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to save details',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save details: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> _pickAttendanceImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _attendanceImage = image;
      });
    }
  }


  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    // Request permission if not already granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission permanently denied')),
      );
      return;
    }

    // Get the current location
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitudeController.text = position.latitude.toString();
        _longitudeController.text = position.longitude.toString();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch location: $e')),
        );
      }
    }
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffeef1f5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                margin: const EdgeInsets.only(bottom: 30),
                color: Colors.blue,
                child: const Text(
                  'Attendance',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Image.asset('assets/images/AttendanceScreen.png'),

            // Date Field (auto-filled with today)
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Date',
                hintText: 'dd/mm/yyyy',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Start & End Time Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startTimeController,
                    readOnly: true,
                    onTap: () => _pickTime(_startTimeController),
                    decoration: const InputDecoration(
                      labelText: 'Start Time',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _endTimeController,
                    readOnly: true,
                    onTap: () => _pickTime(_endTimeController),
                    decoration: const InputDecoration(
                      labelText: 'End Time',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Latitude Field
            TextField(
              controller: _latitudeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Longitude Field
            TextField(
              controller: _longitudeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _teacherController,
                    onTap: () => {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No. of teachers attended',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _moduleController,
                    onTap: () => {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Module No.',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _boysController,
                    onTap: () => {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No. of Boys',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _girlsController,
                    onTap: () => {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No.of girls',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _totalController,
                    onTap: () => {},
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total students',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _mnameController,
              onTap: () => {},
              decoration: const InputDecoration(
                labelText: 'Module name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _topicsController,
              onTap: () => {},
              decoration: const InputDecoration(
                labelText: 'Topics covered',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _remarksController,
              onTap: () => {},
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
              ),
            ),

            ExpansionTile(
              title: const Text("Select Classes"),
              children: options.keys.map((String key) {
                return CheckboxListTile(
                  title: Text('Class $key'),
                  value: options[key],
                  onChanged: (bool? value) {
                    setState(() {
                      options[key] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              "Selected: ${selectedClasses.join(", ")}",
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),

            SizedBox(height: 20,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Proof of Attendance (Photo)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickAttendanceImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: _attendanceImage != null
                        ? Image.file(
                      File(_attendanceImage!.path),
                      fit: BoxFit.cover,
                    )
                        : const Center(
                      child: Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),


            const SizedBox(height: 20),
            // Submit Button
            SizedBox(
                width: width * 0.3,
                height: 38,
                child: ElevatedButton(
                  onPressed: () async {
                    await _isFormValid(); // Will check form and submit
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                )

            ),
          ],
        ),
      ),
    );
  }
}