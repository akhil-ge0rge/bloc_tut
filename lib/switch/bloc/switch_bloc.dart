import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState()) {
    on<ToggleSwitchEvent>(_toggleSwitch);
    on<SliderEvent>(_slider);
  }

  void _toggleSwitch(ToggleSwitchEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(isEnabled: !state.isEnabled));
  }

  void _slider(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(sliderValue: event.sliderValue));
  }
}
