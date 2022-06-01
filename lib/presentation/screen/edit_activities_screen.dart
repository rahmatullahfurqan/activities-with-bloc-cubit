import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_activites/cubit/activities_cubit.dart';
import 'package:mobile_activites/cubit/add_activities_cubit.dart';
import 'package:mobile_activites/cubit/edit_activities_cubit.dart';
import 'package:mobile_activites/cubit/get_time_cubit.dart';
import 'package:mobile_activites/cubit/what_todo_cubit.dart';
import 'package:mobile_activites/data/model/activities.dart';

class EditActivitiesScreen extends StatelessWidget {
  Activities activities;
  EditActivitiesScreen({Key? key, required this.activities}) : super(key: key);
  final _controllerWho = TextEditingController();
  final _controllerWhy = TextEditingController();
  final _controllerDescribe = TextEditingController();
  String dateTime = "Select Date";
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    _controllerWho.text = activities.institution;
    _controllerWhy.text = activities.objective;
    _controllerDescribe.text = activities.remarks;
    dateTime = activities.when;
    selectedValue =
        (activities.activityType.toLowerCase() == "meeting") ? 1 : 2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 21, 140),
          title: const Center(
            child: Text("Edit Activity"),
          ),
        ),
        body: BlocListener<EditActivitiesCubit, EditActivitiesState>(
          listener: (context, state) {
            if (state is ActivityUpdated) {
              Navigator.pop(context);
            } else if (state is EditActivityError) {
              print(state.error);
            }
          },
          child: _body(context),
        ));
  }

  Widget _body(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you want to do ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _whatTodo(context),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Who do you want to meet/call ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _whoTodo(context),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "When do you want to meet/call ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _whenTodo(context),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Why do you want to meet/call ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _whyTodo(context),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Could you describet it more details ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            _describeMore(context),
            const SizedBox(
              height: 10,
            ),
            _submitBtn(context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _whatTodo(context) {
    return BlocProvider(
      create: (context) => WhatTodoCubit(),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 15),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<WhatTodoCubit, WhatTodoState>(
          builder: (context, state) {
            if (state is WhatTodoChanged) {
              selectedValue = state.value;
            }
            return ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: selectedValue,
                    items: [
                      DropdownMenuItem(
                        child: Text("Meeting"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Phone Call"),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      BlocProvider.of<WhatTodoCubit>(context)
                          .whatTodoChanged(int.parse(value.toString()));
                      print(value);
                    }),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _whoTodo(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: _controllerWho,
              decoration: InputDecoration(
                  hintText: "type here..", border: InputBorder.none),
            ),
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget _whenTodo(context) {
    return BlocProvider(
      create: (context) => GetTimeCubit(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<GetTimeCubit, GetTimeState>(
          builder: (context, state) {
            if (state is TimeLoaded) {
              dateTime = state.getDate;
            }
            return InkWell(
              onTap: () {
                pickDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateTime,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.date_range),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _whyTodo(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: _controllerWhy,
              decoration: InputDecoration(
                  hintText: "type here..", border: InputBorder.none),
            ),
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget _describeMore(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllerDescribe,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
            hintText: "  type here..", border: InputBorder.none),
      ),
    );
  }

  Widget _submitBtn(context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<EditActivitiesCubit>(context).editActivity(Activities(
            activityType: (selectedValue == 1) ? "Meeting" : "Phone Call",
            institution: _controllerWho.text,
            when: dateTime,
            objective: _controllerWhy.text,
            remarks: _controllerDescribe.text,
            id: activities.id));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 32, 193, 173),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: BlocBuilder<EditActivitiesCubit, EditActivitiesState>(
            builder: (context, state) {
              if (state is UpdatingActivity) {
                return CircularProgressIndicator();
              }
              return Text(
                "Submit",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ),
    );
  }

  Future pickDate(context) async {
    final initialDate = DateTime.now();
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    DateTime dateTime;
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    dateTime = DateTime(
        newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
    BlocProvider.of<GetTimeCubit>(context).selectDate(dateTime);
  }
}
