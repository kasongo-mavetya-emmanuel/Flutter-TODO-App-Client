import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_nodejs/models/task_model.dart';
import 'package:todo_list_flutter_nodejs/provider/todo_provider.dart';

TextEditingController titleController= TextEditingController();
TextEditingController descriptionController= TextEditingController();
addDataWidget(BuildContext context, TaskModel taskModel){
      titleController.text= taskModel.title==''?'': taskModel.title;
      descriptionController.text= taskModel.description==''?'':taskModel.description;

    return showModalBottomSheet(
        context: context,
        builder:(context){
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText:'Add title'
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        hintText:'Add description'
                    ),
                  ),
                  ElevatedButton(
                      onPressed: taskModel.title==''?(){
                        if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
                          Provider.of<TodoProvider>(context, listen: false)
                              .addData({
                            "name": titleController.text,
                            "description":descriptionController.text
                          }).whenComplete(() {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task added')));
                          });
                        }
                        else{

                        }
                      }:(){
                        context.read<TodoProvider>().updateData(taskModel.id, {
                          "name": titleController.text,
                          "description":descriptionController.text}).whenComplete((){
                            Navigator.pop(context);
                        });
                      },
                      child: taskModel.title==''?Text('Submit'):Text('update')
                  ),
                ],
              ),
            ),
          );
        });


}