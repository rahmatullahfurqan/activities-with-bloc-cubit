import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'what_todo_state.dart';

class WhatTodoCubit extends Cubit<WhatTodoState> {
  WhatTodoCubit() : super(WhatTodoInitial());
  void whatTodoChanged(int value) {
    emit(WhatTodoChanged(value: value));
  }
}
