import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_activites/data/model/activities.dart';

import '../data/repository.dart';

part 'add_activities_state.dart';

class AddActivitiesCubit extends Cubit<AddActivitiesState> {
  final Repository? repository;
  AddActivitiesCubit({required this.repository})
      : super(AddActivitiesInitial());
  void addActivity(Activities activities) {
    if (activities == null) {
      emit(AddActivityError(error: "activity is empty"));
      return;
    }
    emit(AddingActivity());
    Timer(Duration(seconds: 2), () {
      repository?.addActivity(activities).then((activity) {
        if (activity != null) {
          emit(ActivityAdded(activities: activity));
        }
      });
    });
  }
}
