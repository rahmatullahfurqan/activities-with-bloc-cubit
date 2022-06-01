part of 'edit_activities_cubit.dart';

@immutable
abstract class EditActivitiesState {}

class EditActivitiesInitial extends EditActivitiesState {}

class ActivityUpdated extends EditActivitiesState {
  Activities activities;
  ActivityUpdated({required this.activities});
}

class UpdatingActivity extends EditActivitiesState {}

class EditActivityError extends EditActivitiesState {
  final String error;
  EditActivityError({required this.error});
}
