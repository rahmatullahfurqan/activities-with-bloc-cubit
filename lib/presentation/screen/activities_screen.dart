import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_activites/constant/constant.dart';
import 'package:mobile_activites/cubit/activities_cubit.dart';
import 'package:mobile_activites/data/model/activities.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  String lastDate = "";
  bool showIt = false;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActivitiesCubit>(context).fetchActivities();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 21, 140),
        title: const Center(child: Text("Activities")),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TabBar(
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(text: "Open"),
              Tab(text: "Complete"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _listActivities(),
          const Center(
            child: Text("Complete Page"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 21, 140),
        onPressed: () {
          Navigator.pushNamed(context, ADD_ACTIVITIES_ROUTE);
        },
        child: const Icon(Icons.add),
      ), // This trailing,
    );
  }

  Widget _listActivities() {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        if (state is! ActivitiesLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.acivities
                .map((e) => _activitiesTile(e, context))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _activitiesTile(Activities activities, context) {
    String justDate = activities.when.substring(0, activities.when.length - 6);
    if (lastDate != justDate) {
      showIt = true;
    } else {
      showIt = false;
    }
    lastDate = justDate;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, INFO_ACTIViTIES_ROUTE,
            arguments: activities);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.5, color: Colors.grey))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showIt
                    ? Column(
                        children: [
                          Text(
                            justDate,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 5),
                      child: Text(
                        activities.when.substring(
                            activities.when.length - 5, activities.when.length),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 114, 124, 173),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "${activities.activityType} with ${activities.institution}",
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  activitiesSort(List<Activities> activitiesRaw) {
    activitiesRaw.sort(
      (a, b) => a.when.toString().compareTo(b.when.toString()),
    );
    return activitiesRaw;
  }
}
