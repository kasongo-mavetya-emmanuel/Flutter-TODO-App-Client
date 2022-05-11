import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_nodejs/provider/todo_provider.dart';
import 'package:todo_list_flutter_nodejs/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodoProvider>(create: (_)=>TodoProvider()),
      ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: HomeView(),
        ),
       );
  }
}


