import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton();

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  static final List<Color> _colors = [Colors.grey, Colors.red];
  static final List<Icon> _icons = [
    Icon(Icons.favorite_outline_rounded, color:_colors[0]),
    Icon(Icons.favorite_rounded, color: _colors[1])
  ];
  static int _currentIndex = 0;
  Icon _currentIcon = _icons[_currentIndex];

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
                onTap: () => setState(() {
                  if (_currentIndex == 0) {
                    _currentIndex = 1;
                    _currentIcon = _icons[_currentIndex];
                  } 
                  else if (_currentIndex == 1) {
                    _currentIndex = 0;
                    _currentIcon = _icons[_currentIndex];
                  } 
                }) ,
                child: _currentIcon);
  }
}