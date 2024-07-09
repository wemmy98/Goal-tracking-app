import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GoalInput extends StatefulWidget {
  final Function(String, DateTime?) onAddGoal;

  const GoalInput({required this.onAddGoal});

  @override
  _GoalInputState createState() => _GoalInputState();
}

class _GoalInputState extends State<GoalInput> {
  final TextEditingController _goalController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _goalController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.task, color: Colors.white),
            hintText: 'Enter Your Goal',
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white24,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              _selectedDate == null
                  ? 'No deadline set'
                  : 'Deadline: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  style: TextStyle(color: Colors.white),
                  
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.white,
              onPressed: _pickDate,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _addGoal,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading ? CircularProgressIndicator() : Text('Add Goal', style: GoogleFonts.pacifico(
            fontSize: 15,
            color: Colors.black)),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      widget.onAddGoal(_goalController.text, _selectedDate);
      _goalController.clear();
      setState(() {
        _selectedDate = null;
      });
    }
  }
}
