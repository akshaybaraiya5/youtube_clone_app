

import 'package:get/get.dart';
import 'package:y_tube/data/response/api_response.dart';
import 'package:y_tube/model/video_model.dart';

import '../data/response/status.dart';
import '../repository/video_repository.dart';

class VideoController extends GetxController {

  final _api = VideoRepository();


  final requestStatus = Status.LOADING.obs;

  final userList = VideoModel().obs;

  RxString error = ''.obs;
  
  
  


  void setRequestStatus(Status _value) => requestStatus.value = _value;

  void setUserList(VideoModel _value) => userList.value = _value;

  void setError(String _value) => error.value = _value;


  void userListApi() {
    //  setRxRequestStatus(Status.LOADING);

    _api.videoList('science').then((value) {
      setRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error.toString());
      setRequestStatus(Status.ERROR);
    });
  }
  //
  void refreshApi(String query) {
    setRequestStatus(Status.LOADING);

    _api.videoList(query).then((value) {
      setRequestStatus(Status.COMPLETED);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRequestStatus(Status.ERROR);
    });
  }
}