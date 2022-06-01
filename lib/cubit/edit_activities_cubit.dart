import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_activites/data/model/activities.dart';

import '../data/repository.dart';

part 'edit_activities_state.dart';

class EditActivitiesCubit extends Cubit<EditActivitiesState> {
  final Repository? repository;
  EditActivitiesCubit({required this.repository})
      : super(EditActivitiesInitial());

  void editActivity(Activities activities) {
    if (activities == null) {
      emit(EditActivityError(error: "error when update"));
      return;
    }
    emit(UpdatingActivity());
    Timer(Duration(seconds: 2), () {
      repository?.updateActivity(activities).then((isUpdated) {
        if (isUpdated) {
          emit(ActivityUpdated(activities: activities));
        }
      });
    });
  }
}
