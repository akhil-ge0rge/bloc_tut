import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/image_picker_bloc.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ImagePickerBloc, ImagePickerState>(
            builder: (context, state) {
              return state.image == null
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          context.read<ImagePickerBloc>().add(GalleryPicker());
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 50,
                        ),
                      ),
                    )
                  : Center(
                      child: Image.file(
                        File(
                          state.image!.path.toString(),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
