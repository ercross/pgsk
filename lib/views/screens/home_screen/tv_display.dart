import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/repositories/data_repositories/image_repository.dart';
import '../../../data/constants.dart';
import 'homepage.dart';

class TVDisplay extends StatefulWidget {
  final ImageRepository imageRepository;
  final double allowedHeight;
  final double allowedWidth;

  const TVDisplay(
      {@required this.imageRepository,
      @required this.allowedHeight,
      @required this.allowedWidth});

  @override
  _TVDisplayState createState() => _TVDisplayState();
}

class _TVDisplayState extends State<TVDisplay> {
  ///indicators are the horizontal line under the display container/TV
  ///It maps index to images as arranged in images list. Order of arrangement doesn't matter
  int _currentlyActiveIndicator = 0;
  List<Image> _images;
  Timer _timer;
  Image _currentlyDisplayedImage;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_currentlyActiveIndicator == _images.length - 1)
        setState(() {
          _currentlyActiveIndicator = 0;
          _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
        });
      else
        setState(() {
          _currentlyActiveIndicator++;
          _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
        });
    });
  }

  @override
  void initState() {
    super.initState();
    widget.imageRepository
        .fetchFromUrls(
            imagesUrls: Constants.homepageTVImagesUrls,
            displayHeight: HomePage.deviceHeight * 0.22,
            displayWidth: HomePage.deviceWidth * HomePage.screenWidthMultiplier)
        .then((fetchedImages) => setState(() => _images = fetchedImages))
        .catchError((error) => setState(() => _images = []));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  ///isTimerStarted is used to prevent the _startTimer from invoking each time setState causes invokation of build()
  static bool _isTimerStarted = false;

  @override
  Widget build(BuildContext context) {
    if (_images == null || _images.isEmpty)
      return SizedBox();
    else if (_isTimerStarted == false) {
      _startTimer();
      _isTimerStarted = true;
    }

    if (_timer == null || !_timer.isActive) _startTimer();

    return Column(
      children: [_buildTV(), _buildIndicatorsButtonBar()],
    );
  }

  Widget _buildTV() {
    return _buildSwipeDetector(
      onChild: Container(
          margin: EdgeInsets.only(top: 12),
          width: widget.allowedWidth,
          height: widget.allowedHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: _currentlyDisplayedImage),
    );
  }

  Widget _buildSwipeDetector({@required Widget onChild}) {
    return GestureDetector(
        onHorizontalDragUpdate: (dragDetails) {
          if (dragDetails.delta.dx > 0) {
            if (_currentlyActiveIndicator == _images.length - 1)
              setState(() {
                _currentlyActiveIndicator = 0;
                _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
              });
            else
              setState(() {
                _currentlyActiveIndicator++;
                _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
              });
          } else if (dragDetails.delta.dx < 0) {
            if (_currentlyActiveIndicator == 0)
              setState(() {
                _currentlyActiveIndicator = _images.length - 1;
                _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
              });
            else
              setState(() {
                _currentlyActiveIndicator--;
                _currentlyDisplayedImage = _images[_currentlyActiveIndicator];
              });
          }
        },
        child: onChild);
  }

  Widget _buildIndicatorsButtonBar() {
    return _images == null || _images.isEmpty
        ? SizedBox()
        : ButtonBar(
            alignment: MainAxisAlignment.center,
            children: _buildIndicatorBars(),
          );
  }

  List<Widget> _buildIndicatorBars() {
    List<Widget> indicatorBars = [];

    for (int i = 0; i < _images.length; i++) {
      indicatorBars.add(_buildIndicatorBar(_currentlyActiveIndicator == i));
    }
    return indicatorBars;
  }

  Widget _buildIndicatorBar(bool isActiveIndicator) => Container(
      height: 3,
      width: 9,
      color: isActiveIndicator ? Theme.of(context).primaryColor : Colors.grey);
}
