// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'switch_bloc.dart';

sealed class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

class ToggleSwitchEvent extends SwitchEvent {}

class SliderEvent extends SwitchEvent {
  final double sliderValue;

  const SliderEvent({required this.sliderValue});
  @override
  List<Object> get props => [
        sliderValue,
      ];
}
