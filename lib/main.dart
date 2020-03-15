import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
  // MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  // @override
  // _MyHomePageState createState() => _MyHomePageState();
}

class TodoListState extends State<TodoList> {
  List<String> todoItems = [];
  void _addTodoItem(String task){

    if(task.length > 0) {
    setState(() => todoItems.add(task));
    }
  }
  void _removeTodoItem(int index) {
  setState(() => todoItems.removeAt(index));
  }
void _deleteTodoList(){
  int i = 0;
    while(i<todoItems.length+1){
      setState((){
       todoItems.removeLast();
      });
      i++;  
    }
  }
void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Mark "${todoItems[index]}" as done?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
}
  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index){
        if(index < todoItems.length){
          return _buildTodoItem(todoItems[index], index);
        }
      },
    );
  }
  Widget _buildTodoItem(String todoText, int index){
    return new ListTile(
      title :new Text(todoText),
      onTap: ()=> _promptRemoveTodoItem(index)
    );
  }
  @override
  Widget build(BuildContext context) {
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('Todo List'),
      ),
      
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child:new Icon(Icons.add)
      ),
      drawer: Container(
        width: 150.0,
        color: Colors.blueGrey,
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: new FloatingActionButton.extended(
                  onPressed: _deleteTodoList,
                  label: Text('Delete All'),
                  icon: Icon(Icons.delete),
                )
              ),
            ],
          ),
         )

       ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _pushAddTodoScreen() {
  // Push this page onto the stack
    Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task to Your List')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                hintText: 'Enter your Todo Item...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }
}