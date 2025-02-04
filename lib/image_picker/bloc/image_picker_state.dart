part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {
  final XFile? image;

  const ImagePickerState({this.image});

  ImagePickerState copyWith({XFile? image}) {
    return ImagePickerState(
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [image];
}
