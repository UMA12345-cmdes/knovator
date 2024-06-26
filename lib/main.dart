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
    'Ram',
    'Sita',
    'Gita',
  ];
  final TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
              trailing: Wrap(
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _updateItem(index);
                      }),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        resumeItems.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: TextField(
            controller: itemController,
            decoration: const InputDecoration(hintText: 'Enter item name'),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  resumeItems.add(itemController.text);
                });
                Navigator.of(context).pop();
                itemController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _updateItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Item'),
          content: TextField(
            controller: itemController,
            decoration: const InputDecoration(hintText: 'Enter item name'),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  resumeItems[index] = itemController.text;
                });
                Navigator.of(context).pop();
                itemController.clear();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
