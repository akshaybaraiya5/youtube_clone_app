

import 'package:get/get.dart';

import 'package:y_tube/model/video_model.dart';
import 'package:y_tube/res/routes/routes_name.dart';
import 'package:y_tube/view/home_screen.dart';
import 'package:y_tube/view/video_player.dart';

class AppRoutes {

  static appRoutes() => [
    // GetPage(
    //   name: RouteName.splashScreen,
    //   page: () => SplashScreen() ,
    //   transitionDuration: Duration(milliseconds: 250),
    //   transition: Transition.leftToRightWithFade ,
    // ) ,
    // GetPage(
    //   name: RouteName.videoView,
    //   page: () => VideoPlayer(video: ) ,
    //   transitionDuration: Duration(milliseconds: 250),
    //   transition: Transition.leftToRightWithFade ,
    // ) ,
    GetPage(
      name: RouteName.homeView,
      page: () => HomeScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    ) ,
  ];

}