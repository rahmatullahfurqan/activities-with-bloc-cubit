import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_activites/data/model/activities.dart';
import 'package:mobile_activites/data/repository.dart';
part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final Repository? repository;
  ActivitiesCubit({required this.repository}) : super(ActivitiesInitial());

  void fetchActivities() {
    Timer(const Duration(seconds: 2), () {
      repository?.fetchActivities().then((activitiesRaw) {
        activitiesRaw.sort(
          (a, b) => a.when.compareTo(b.when),
        );
        emit(ActivitiesLoaded(acivities: activitiesRaw));
      });
    });
  }

  void addActivity(Activities activities) {
    final currentState = state;
    if (currentState is ActivitiesLoaded) {
      final activitiesList = currentState.acivities;
      activitiesList.add(activities);
      activitiesList.sort(
        (a, b) => a.when.compareTo(b.when),
      );
      emit(ActivitiesLoaded(acivities: activitiesList));
    }
  }

  void updateActivity(Activities activities) {
    final currentState = state;
    if (currentState is ActivitiesLoaded) {
      final activitiesList = currentState.acivities;
      for (int i = 0; i < activitiesList.length; i++) {
        if (activitiesList[i].id == activities.id) {
          activitiesList[i] = activities;
        }
      }
      activitiesList.sort(
        (a, b) => a.when.compareTo(b.when),
      );
      emit(ActivitiesLoaded(acivities: activitiesList));
    }
  }
}
