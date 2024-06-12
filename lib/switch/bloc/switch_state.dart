part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool isEnabled;
  final double sliderValue;
  const SwitchState({
    this.isEnabled = true,
    this.sliderValue = 1.0,
  });

  SwitchState copyWith({bool? isEnabled, double? sliderValue}) {
    return SwitchState(
      isEnabled: isEnabled ?? this.isEnabled,
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }

  @override
  List<Object> get props => [
        isEnabled,
        sliderValue,
      ];
}
