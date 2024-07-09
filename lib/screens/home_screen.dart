import 'package:flutter/material.dart';
import 'package:goal_track/screens/auth_screen.dart';
import 'package:goal_track/screens/completed_goals_screen.dart';
import 'package:goal_track/widgets/goal_input.dart';
import 'package:goal_track/widgets/goal_list.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _goals = [];
  List<Map<String, dynamic>> _completedGoals = [];

  void _addGoal(String goal, DateTime? deadline) {
    setState(() {
      _goals.add({
        'goal': goal,
        'deadline': deadline,
        'isCompleted': false,
        'createdTime': DateTime.now(),
        'completedTime': null,
      });
    });
  }

  void _editGoal(int index, String goal, DateTime? deadline) {
    setState(() {
      _goals[index] = {
        'goal': goal,
        'deadline': deadline,
        'isCompleted': _goals[index]['isCompleted'],
        'createdTime': _goals[index]['createdTime'],
        'completedTime': _goals[index]['completedTime'],
      };
    });
  }

  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  void _deleteCompletedGoal(int index) {
    setState(() {
      _completedGoals.removeAt(index);
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _goals[index]['isCompleted'] = !_goals[index]['isCompleted'];
      if (_goals[index]['isCompleted']) {
        _goals[index]['completedTime'] = DateTime.now();
        _completedGoals.add(_goals[index]);
        _goals.removeAt(index);
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Completed'),
          content: Text('Congratulations! You have completed a goal!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.black,
        title: Text('Goal Tracker', style: GoogleFonts.bodoniModa(fontWeight: FontWeight.w400),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GoalInput(onAddGoal: _addGoal),
                Expanded(
                  child: GoalList(
                    goals: _goals,
                    onEditGoal: _editGoal,
                    onDeleteGoal: _deleteGoal,
                    onToggleCompletion: _toggleCompletion,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompletedGoalsScreen(
                          completedGoals: _completedGoals,
                          onDeleteCompletedGoal: _deleteCompletedGoal,
                        ),
                      ),
                    );
                  },
                  child: Text('View Completed Goals', style: GoogleFonts.pacifico(
                    color: Colors.black87
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
