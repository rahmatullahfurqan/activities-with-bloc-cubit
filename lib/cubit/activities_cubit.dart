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
        emit(ActivitiesLoaded(acivities: activitiesRaw));
      });
    });
  }

  void addActivity(Activities activities) {
    final currentState = state;
    if (currentState is ActivitiesLoaded) {
      final activitiesList = currentState.acivities;
      activitiesList.add(activities);
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
      emit(ActivitiesLoaded(acivities: activitiesList));
    }
  }

  void sort(List<Activities> activities) {
    emit(ActivitiesLoaded(acivities: activitiesSort(activities)));
  }

  // void sortList() {
  //   final currentState = state;
  //   print(state);
  //   if (currentState is ActivitiesLoaded) {
  //     emit(ActivitiesLoaded(acivities: activitiesSort(currentState.acivities)));
  //   }
  // }

  activitiesSort(List<Activities> activitiesRaw) {
    return activitiesRaw.sort(
      (a, b) => a.when.compareTo(b.when),
    );
  }
}
