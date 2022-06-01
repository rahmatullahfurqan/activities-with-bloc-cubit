part of 'add_activities_cubit.dart';

@immutable
abstract class AddActivitiesState {}

class AddActivitiesInitial extends AddActivitiesState {}

class AddingActivity extends AddActivitiesState {}

class ActivityAdded extends AddActivitiesState {
  final Activities activities;
  ActivityAdded({required this.activities});
}

class AddActivityError extends AddActivitiesState {
  final String error;
  AddActivityError({required this.error});
}
