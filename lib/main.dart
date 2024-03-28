import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  List<String> resumeItems = [
    'Education',
    'Experience',
    'Skills',
  ];
  final TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = resumeItems.removeAt(oldIndex);
            resumeItems.insert(newIndex, item);
          });
        },
        children: List.generate(
          resumeItems.length,
          (index) {
            return ListTile(
              key: Key('$index'),
              title: Text(resumeItems[index]),
            );
          },
        ),
      ),
    );
  }
}
