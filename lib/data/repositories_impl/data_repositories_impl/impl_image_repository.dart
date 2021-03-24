import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../../../core/functionalities/custom_exceptions/no_internet_connection_exception.dart';
import '../../../core/repositories/data_repositories/image_repository.dart';
import '../../../views/screens/home_screen/homepage.dart';


class ImageRepositoryImpl extends ImageRepository {

  @override
  Future<Image> fetchFromUrl({
    @required String imageUrl, 
    @required double displayWidth, 
    @required double displayHeight
    }) async {
      //TODO:
    //if (!(await DataConnectionChecker().hasConnection)) throw NoInternetConnectionException();
    try {
      return Future.value(Image.asset(imageUrl, 
          fit: BoxFit.fill, width: displayWidth, height: displayHeight));
    }
    catch (error) {throw error;}
  }

  @override
  Future<List<Image>> fetchFromUrls({
    @required List<String> imagesUrls,
    @required double displayWidth, 
    @required double displayHeight
  }) async {
    //TODO:
    //if (!(await DataConnectionChecker().hasConnection)) throw NoInternetConnectionException();
    final List<Image> images = List<Image>();

    ///I avoided using fetchfromUrl to save time with wasted in checking for active connection each time it's invoked
    try {
      imagesUrls.forEach((imageUrl) async => images.add(
        await Future.value(Image.asset(imageUrl, 
          fit: BoxFit.fill, width: displayWidth, height: displayHeight))
      ));
    }
    catch(error) { throw error; } 
    
    return Future.value(images);
  }

}