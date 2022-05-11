import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_nodejs/models/task_model.dart';
import 'package:todo_list_flutter_nodejs/provider/todo_provider.dart';

import 'add_todo.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:() async{
         await addDataWidget(context, TaskModel(title: '',description: '', id: ''));
         setState(() {
         });

        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('TODO List',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body:FutureBuilder<List<TaskModel>>(
          future: context.read<TodoProvider>().fetchData(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child:
              Text('Empty'),);
            }
            if(snapshot.data!.isEmpty){
              return Center(child:
                Text('Empty'),);
            }
            if(snapshot.connectionState== ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }

            List<TaskModel> tasks= snapshot.data!;
            return ListView.separated(
              itemCount: tasks.length,
                itemBuilder: (_, index){

                  return ListTile(
                    title: Text(tasks[index].title, style: TextStyle(fontWeight: FontWeight.w500),),
                    subtitle: Text(tasks[index].description),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            context.read<TodoProvider>().deleteData(tasks[index].id);
                            setState(() {

                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task deleted')));
                          }, icon: Icon(Icons.delete)),

                          IconButton( onPressed:() async {
                            await addDataWidget(context, tasks[index]);
                            setState(() {
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task edited')));
                          }, icon: Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (_, int index) =>Divider(),);
          },
        ),

    );
  }
}
