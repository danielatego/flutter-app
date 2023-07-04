import 'package:flutter/widgets.dart';
import 'package:two_a/helpers/loading/loading_screen_controller.dart';

class LoadingScreen{
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen()=>_shared;

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }){
    if (controller?.update(text) ?? false){
      return;
    }else{
      controller 
    }
  }

}