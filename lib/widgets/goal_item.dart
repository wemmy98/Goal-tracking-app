import 'package:flutter/material.dart';

class GoalItem extends StatelessWidget {
  final String goal;
  final DateTime? deadline;
  final bool isCompleted;
  final DateTime createdTime;
  final DateTime? completedTime;
  final Function(String, DateTime?) onEdit;
  final Function onDelete;
  final Function onToggleCompletion;

  const GoalItem({
    required this.goal,
    required this.deadline,
    required this.isCompleted,
    required this.createdTime,
    this.completedTime,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleCompletion,
  });

  void _showEditDialog(BuildContext context) {
    final TextEditingController _goalController = TextEditingController(text: goal);
    DateTime? _selectedDate = deadline;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Edit Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _goalController,
                decoration: InputDecoration(labelText: 'Goal'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Deadline: ${_selectedDate.toString()}',
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      ).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        _selectedDate = pickedDate;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                onEdit(_goalController.text, _selectedDate);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        title: Text(
          goal,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deadline != null) Text('Deadline: ${deadline.toString()}'),
            Text('Created: ${createdTime.toString()}'),
            if (completedTime != null) Text('Completed: ${completedTime.toString()}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete();
              },
            ),
            IconButton(
              icon: Icon(
                isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                color: isCompleted ? Colors.green : null,
              ),
              onPressed: () {
                onToggleCompletion();
              },
            ),
          ],
        ),
      ),
    );
  }
}
