import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:y_tube/model/video_model.dart';
import 'package:y_tube/res/routes/routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controller/video_controller.dart';
import '../data/response/status.dart';
import '../res/routes/routes_name.dart';


class VideoPlayer extends StatefulWidget {
  Items video;

  VideoPlayer({super.key, required this.video});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

String videoId = "";

class _VideoPlayerState extends State<VideoPlayer> {

  late YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoId,);

  final VideoController videoController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoId = widget.video.id!.videoId.toString();
    });
    print("video id is $videoId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: OrientationBuilder(builder: (ctx, ori) {
        return ori == Orientation.portrait ? SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 33.h,
                  child: YoutubePlayer(

                    controller: _controller,

                    showVideoProgressIndicator: true,


                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Obx(() {
                        switch (videoController.requestStatus.value) {
                          case Status.LOADING:
                            return Center(child: CircularProgressIndicator());
                          case Status.COMPLETED:
                            return Container(
                              height: 63.h,
                              child: ListView.builder(


                                itemCount: videoController.userList.value.items!
                                    .length,
                                itemBuilder: (context, index) {
                                  final video = videoController.userList.value
                                      .items![index];
                                  if (index == 0) {
                                    return Container(
                                      padding: EdgeInsets.all(10),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(widget.video.snippet!.title
                                              .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp
                                              )),
                                          Text('${widget.video.snippet!
                                              .channelTitle
                                              .toString()}  ・${widget.video
                                              .snippet!.publishTime
                                              .toString()}', maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors
                                                  .grey,
                                              fontSize: 14.sp,

                                            ),),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    color: Colors.white,
                                    height: 39.h,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(
                                            width: double.infinity,
                                            height: 30.h,
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.off(
                                                      VideoPlayer(
                                                          video: video));
                                                },
                                                child: Image.network(
                                                  video.snippet!.thumbnails!
                                                      .medium!.url!
                                                      .toString(),
                                                  fit: BoxFit.cover,))),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 3.w, top: 1.h, right: 3.w),
                                          child: Text(
                                            video.snippet!.title.toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp
                                            ),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 3.w, right: 3.w),
                                          child: Text(
                                            '${video.snippet!.channelTitle
                                                .toString()}  ・${video.snippet!
                                                .publishTime
                                                .toString()}', maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors
                                                  .grey,
                                              fontSize: 14.sp,

                                            ),),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          case Status.ERROR:
                            return Center(child: Text("error"));
                        }
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ) : YoutubePlayer(

          controller: _controller,

          showVideoProgressIndicator: true,


        );
      }),
    );
  }
}
