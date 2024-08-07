import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/constants/constants.dart';

class AppSlider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;
  final String? skipBtn;  // Make skipBtn nullable

  AppSlider({
    required this.sliderImageUrl,
    required this.sliderHeading,
    required this.sliderSubHeading,
    this.skipBtn,
  });
}

final sliderArrayList = [
  AppSlider(
    sliderImageUrl: 'assets/images/slider_img_1.jpeg',
    sliderHeading: Constants.SLIDER_HEADING_1,
    sliderSubHeading: Constants.SLIDER_DESC_1,
  ),
  
  AppSlider(
    sliderImageUrl: 'assets/images/slider_img_2.jpg',
    sliderHeading: Constants.SLIDER_HEADING_2,
    sliderSubHeading: Constants.SLIDER_DESC_2,
  ),

  AppSlider(
    sliderImageUrl: 'assets/images/slider_img_3.jpg',
    sliderHeading: Constants.SLIDER_HEADING_3,
    sliderSubHeading: Constants.SLIDER_DESC_3,
    skipBtn: "hello",
  ),
];
