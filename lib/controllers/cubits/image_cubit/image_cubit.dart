import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/repositories/data_repositories/image_repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImageRepository imageRepository;

  ImageCubit(this.imageRepository) : super(ImageInitial());
}
