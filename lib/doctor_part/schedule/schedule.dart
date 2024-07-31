import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorAvailabilityForm extends StatefulWidget {
  const DoctorAvailabilityForm({super.key});

  @override
  _DoctorAvailabilityFormState createState() => _DoctorAvailabilityFormState();
}

class _DoctorAvailabilityFormState extends State<DoctorAvailabilityForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final RxList<dynamic> _selectedDays = [].obs;

  final TextEditingController _timeSlotController = TextEditingController();
  final List<String> _timeSlots = [
    '10 min',
    '15 min',
    '20 min',
    '25 min',
    '30 min',
    '35 min',
    '40 min',
    '45 min',
    '50 min',
    '55 min',
    '60 min'
  ];

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save the selected values
      List selectedDays = _selectedDays.toList();
      String selectedStartTime =
      _selectedStartTime != null ? _selectedStartTime!.format(context) : '';
      String selectedEndTime =
      _selectedEndTime != null ? _selectedEndTime!.format(context) : '';
      String selectedTimeSlot = _timeSlotController.text;

      // Perform any necessary actions with the selected values
      print('Selected Days: $selectedDays');
      print('Selected Start Date: $_selectedStartDate');
      print('Selected End Date: $_selectedEndDate');
      print('Selected Start Time: $selectedStartTime');
      print('Selected End Time: $selectedEndTime');
      print('Selected Time Slot: $selectedTimeSlot');
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timeSlotController.text =
    _timeSlots[0]; // Set initial value to the first item in the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Availability Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Working Days:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: _daysOfWeek.map((day) {
                  return Obx(
                        () => FilterChip(
                      label: Text(day),
                      selected: _selectedDays.contains(day),
                      onSelected: (selected) {
                        if (selected) {
                          _selectedDays.add(day);
                        } else {
                          _selectedDays.remove(day);
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Start Date:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () => _selectStartDate(context),
                          child: Text(
                            ' ${_selectedStartDate != null ? DateFormat('yyyy-MM-dd').format(_selectedStartDate!) : 'Not Selected'}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select End Date:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () => _selectEndDate(context),
                          child: Text(
                            ' ${_selectedEndDate != null ? DateFormat('yyyy-MM-dd').format(_selectedEndDate!) : 'Not Selected'}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Start Time:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () => _selectStartTime(context),
                          child: Text(_selectedStartTime != null
                              ? _selectedStartTime!.format(context)
                              : 'Select Start Time'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select End Time:',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () => _selectEndTime(context),
                          child: Text(_selectedEndTime != null
                              ? _selectedEndTime!.format(context)
                              : 'Select End Time'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 16.0),
              const Text(
                'Select Time Slot:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: _timeSlotController.text,
                decoration: const InputDecoration(
                  hintText: 'Select Time Slot',
                ),
                items: _timeSlots.map((slot) {
                  return DropdownMenuItem<String>(
                    value: slot,
                    child: Text(slot),
                  );
                }).toList(),
                onChanged: (value) {
                  _timeSlotController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a time slot';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
