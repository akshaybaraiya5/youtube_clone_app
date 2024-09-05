



import 'package:y_tube/model/video_model.dart';

import '../data/network/network_api_services.dart';
import '../res/app_url/app_urls.dart';

class VideoRepository {

  final _apiService  = NetworkApiServices() ;

  Future<VideoModel> videoList(String query) async{
    final header = {
      "X-RapidAPI-Key":
      AppUrl.api_key,
      "X-RapidAPI-Host": AppUrl.api_host
    };
    dynamic response = await _apiService.getApi(AppUrl.searchUrl+query,header);
    print(AppUrl.searchUrl+query.toString());
    print(response.toString());
    return VideoModel.fromJson(response) ;
  }


}