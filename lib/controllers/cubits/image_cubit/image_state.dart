part of 'image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class HomePageTVImages extends ImageState {
  final List<Image> images;

  const HomePageTVImages(this.images);

  @override
  List<Object> get props => [images];
}
