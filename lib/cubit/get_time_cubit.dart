import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'get_time_state.dart';

class GetTimeCubit extends Cubit<GetTimeState> {
  GetTimeCubit() : super(GetTimeInitial());
  void selectDate(DateTime date) {
    if (date == null) {
      emit(TimeLoaded(getDate: "Select Date"));
    } else {
      emit(TimeLoaded(getDate: DateFormat('yyyy-MM-dd:HH:mm').format(date)));
    }
  }
}
