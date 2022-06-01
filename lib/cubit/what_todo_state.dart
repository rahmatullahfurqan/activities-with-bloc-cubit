part of 'what_todo_cubit.dart';

@immutable
abstract class WhatTodoState {}

class WhatTodoInitial extends WhatTodoState {}

class WhatTodoChanged extends WhatTodoState {
  int value;
  WhatTodoChanged({required this.value});
}
