part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarEvent {}

class ChangeIndexEvent extends NavBarEvent{
  final int index;
  ChangeIndexEvent(this.index);
}