import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/home_screen/homepage.dart';
import 'package:pgsk/views/screens/secondary_splash_screen.dart';

import '../../core/data_repositories/image_repository.dart';
import '../../main.dart';

class ImageRepositoryImpl extends ImageRepository {

  static const String prefix = "assets/images/";
  static const List<String> localUrls = [
    prefix + "special_deal.png",
    prefix + "promotions_banner_1.png",
    prefix + "promotions_banner_2.png",
    prefix + "promotions_banner_3.jpg"
  ];

  @override
  Image fetchFromUrl(String imageUrl) {
    return Image.asset(imageUrl, 
      fit: BoxFit.fill,
      height: HomePage.deviceHeight * 0.22, 
      width: HomePage.deviceWidth * HomePage.screenWidthMultiplier);
  }

  @override
  List<Image> fetchFromUrls() {
    final List<Image> images = List<Image>();
    localUrls.forEach((imageUrl) => images.add(fetchFromUrl(imageUrl)));
    return images;
  }

}