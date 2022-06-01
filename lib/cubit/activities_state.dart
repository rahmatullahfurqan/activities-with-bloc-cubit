part of 'activities_cubit.dart';

@immutable
abstract class ActivitiesState {}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  final List<Activities> acivities;
  ActivitiesLoaded({required this.acivities});
}
