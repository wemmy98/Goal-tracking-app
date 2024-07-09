import 'package:flutter/material.dart';
import 'package:goal_track/widgets/goal_item.dart';

class GoalList extends StatelessWidget {
  final List<Map<String, dynamic>> goals;
  final Function(int, String, DateTime?) onEditGoal;
  final Function(int) onDeleteGoal;
  final Function(int) onToggleCompletion;

  const GoalList({
    required this.goals,
    required this.onEditGoal,
    required this.onDeleteGoal,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return GoalItem(
          goal: goals[index]['goal'],
          deadline: goals[index]['deadline'],
          isCompleted: goals[index]['isCompleted'],
          createdTime: goals[index]['createdTime'],
          completedTime: goals[index]['completedTime'],
          onEdit: (newGoal, newDeadline) => onEditGoal(index, newGoal, newDeadline),
          onDelete: () => onDeleteGoal(index),
          onToggleCompletion: () => onToggleCompletion(index),
        );
      },
    );
  }
}
