import 'package:flutter/material.dart';

abstract class ImageRepository {

  ///fetchFromUrl fetches a single image from the Url
  ///Note that the fetched image must be given a defined width and height 
  ///to avoid display overflow error
  Image fetchFromUrl (String imageUrl);

  List<Image> fetchFromUrls ();
}