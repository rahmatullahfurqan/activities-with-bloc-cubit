part of 'get_time_cubit.dart';

@immutable
abstract class GetTimeState {}

class GetTimeInitial extends GetTimeState {}

class TimeLoaded extends GetTimeState {
  String getDate;
  TimeLoaded({required this.getDate});
}
