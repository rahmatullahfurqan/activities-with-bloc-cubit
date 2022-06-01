import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_activites/constant/constant.dart';
import 'package:mobile_activites/cubit/activities_cubit.dart';
import 'package:mobile_activites/cubit/edit_activities_cubit.dart';
import 'package:mobile_activites/data/model/activities.dart';

class InfoActivities extends StatelessWidget {
  Activities activities;
  final _controller = TextEditingController();
  InfoActivities({Key? key, required this.activities}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 21, 140),
        title: const Center(child: Text("Activity Info")),
      ),
      body: BlocListener<EditActivitiesCubit, EditActivitiesState>(
        listener: (context, state) {
          if (state is ActivityUpdated) {
            BlocProvider.of<ActivitiesCubit>(context)
                .updateActivity(state.activities);
            Navigator.pop(context);
          } else if (state is EditActivityError) {
            print(state.error);
          }
        },
        child: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detail(context),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "What is the result ?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          _theResult(context),
          const SizedBox(
            height: 10,
          ),
          _completeBtn(context),
        ],
      ),
    );
  }

  Widget _theResult(context) {
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
        controller: _controller,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
            hintText: "type the result..", border: InputBorder.none),
      ),
    );
  }

  Widget _detail(context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              "${activities.activityType} with ${activities.institution} at ${activities.when} to discuss about ${activities.objective}"),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, EDIT_ACTIViTIES_ROUTE,
                  arguments: activities);
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 21, 140),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Edit Activity",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _completeBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 32, 193, 173),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Complete Activity",
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
