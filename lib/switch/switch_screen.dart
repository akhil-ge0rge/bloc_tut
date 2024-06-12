import 'package:bloc_tut/switch/bloc/switch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications"),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous, current) =>
                      previous.isEnabled != current.isEnabled,
                  builder: (context, state) {
                    print("Switch");
                    return Switch.adaptive(
                      value: state.isEnabled,
                      onChanged: (value) {
                        context.read<SwitchBloc>().add(ToggleSwitchEvent());
                      },
                    );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) =>
                  previous.sliderValue != current.sliderValue,
              builder: (context, state) {
                print("Container");
                return Container(
                  height: 80,
                  width: double.maxFinite,
                  color: Colors.blueAccent.withOpacity(state.sliderValue),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) =>
                  previous.sliderValue != current.sliderValue,
              builder: (context, state) {
                print("Slider");
                return Slider.adaptive(
                  value: state.sliderValue,
                  onChanged: (value) {
                    context
                        .read<SwitchBloc>()
                        .add(SliderEvent(sliderValue: value));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
