import 'package:flutter/material.dart';
import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: true));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text.isEmpty) return;

    setState(() {
      widget.items.add(Item(
        title: newTaskCtrl.text,
        done: false,
      ));
      newTaskCtrl.text = "";
    });
  }

  void remove(int index) {
    widget.items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          decoration: InputDecoration(
              labelText: 'Nova Tarefa',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title ?? ""),
              onChanged: (bool value) {
                setState(() {
                  item.done = value;
                });
              },
              value: item.done,
            ),
            key: Key(item.title),
            onDismissed: (direction) {
              remove(index);
            },
            background: Container(
              color: Theme.of(context).primaryColorLight,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
