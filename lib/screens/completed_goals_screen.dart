import 'package:flutter/material.dart';

class CompletedGoalsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> completedGoals;
  final Function (int) onDeleteCompletedGoal;

  const CompletedGoalsScreen({
    required this.completedGoals,
    required this.onDeleteCompletedGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Goals'),
      ),
      body: ListView.builder(
        itemCount: completedGoals.length,
        itemBuilder: (context, index) {
          final goal = completedGoals[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              title: Text(
                goal['goal'],
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created: ${goal['createdTime'].toString()}'),
                  if (goal['completedTime'] != null)
                    Text('Completed: ${goal['completedTime'].toString()}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete_rounded),
                    onPressed: () {
                      onDeleteCompletedGoal(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
