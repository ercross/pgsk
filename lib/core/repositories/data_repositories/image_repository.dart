import 'package:flutter/material.dart';

///ImageRepository was not included in EntitiesRepository because 
///the HTTP endpoint to fetch images might be different from that of other entities
///as it is very possible the images are not hosted on the PGSK server
///Also, images can be fetched from the phone cache or over the internet.
///This decision is left to the concrete implementation of ImageRepository
abstract class ImageRepository {

  ///fetchFromUrl fetches a single image from the Url
  ///Note that the fetched image must be given a defined width and height 
  ///to avoid display overflow error
  Image fetchFromUrl (String imageUrl);

  List<Image> fetchFromUrls ();
}