import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:y_tube/controller/video_controller.dart';
import 'package:y_tube/data/response/status.dart';
import 'package:y_tube/view/video_player.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final videoController = Get.put(VideoController());
  bool search = false;
  String query = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoController.userListApi();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,

        title: Image.asset('assets/images/youtube_logo.png',height: 20,),
        actions: [
      search?  Row(
        children: [
          SizedBox(
              width: 60.w,
              height: 4.h,
              child: TextFormField(

                  onFieldSubmitted:(value){


                      videoController.refreshApi(value);
                      setState(() {
                        query = value;
                      });

                  },
                onEditingComplete: (){
                  setState(() {
                    search = false;
                  });
                },
                decoration: InputDecoration(

                 contentPadding: EdgeInsets.only(left: 20,bottom: 1.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              )),
          SizedBox(width: 5.w,),

        ],
      ): Row(children: [
         Icon(Icons.connected_tv,size: 25,),
         SizedBox(width: 5.w,),
         Icon(Icons.notifications_none,size:25,),
         SizedBox(width: 5.w,),
         GestureDetector(
             onTap: (){
               setState(() {
                 search = true;
               });
             },
             child: Icon(Icons.search,size: 25)),
         SizedBox(width: 5.w,),
       ],)


        ],
      ),
      body:Obx((){
        switch(videoController.requestStatus.value){

          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
          case Status.COMPLETED:
            return ListView.builder(
              itemCount: videoController.userList.value.items!.length,
              itemBuilder: (context, index) {
                final video = videoController.userList.value.items![index];
                return Container(
                  color: Colors.white,
                  height: 40.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: 30.h,
                          child: GestureDetector(
                              onTap: () {

                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            VideoPlayer(
                                              video: video,)));
                              },
                              child: Image.network(
                                video.snippet!.thumbnails!.medium!.url!
                                    .toString(),
                                fit: BoxFit.cover,))),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 1.h,right: 3.w),
                        child: Text(
                          video.snippet!.title.toString(), maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp
                          ),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:3.w,right: 3.w),
                        child: Text('${video.snippet!.channelTitle
                            .toString()}  ・${video.snippet!.publishTime
                            .toString()}', maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors
                              .grey,
                            fontSize: 14.sp,

                          ),),
                      )
                    ],
                  ),
                );
              },
            );
          case Status.ERROR:
            return Center(child: Text("error"));

        }
      }) ,
    );
  }
}
