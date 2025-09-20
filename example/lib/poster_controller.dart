import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'frame_response.dart';

class PosterController extends GetxController {
  List frames = [];
  List<AttributeModel> attributes = [];
  String frameUrl = "";
  RxBool frameUpdating = false.obs;

  @override
  void onInit() {
    getFrames();
    super.onInit();
  }

  getFrames()async{
    const String apiUrl = 'http://192.168.1.24:1000/api/frames-type/1';
    const String bearerToken = '27|UIcpM1TLITp97kYuGyX3G8EbY4sRN0Iu85uxXtvTb026de7b';

    final response = await dio.Dio().get(apiUrl,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'bearerToken': bearerToken,
          },
        )
    );

    if (response.statusCode == 200) {
      frames =  response.data['ResponseData'] as List;
      update();
      fetchFrameData(frames[0]['id'].toString());
    }
  }

  fetchFrameData(String id) async {
    String apiUrl = 'http://192.168.1.24:1000/api/frame-data-list/$id/1/4';
 
    final res = await dio.Dio().get(apiUrl,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        )
    );

    if (res.statusCode == 200) {
      frameUrl = res.data['ResponseData']['background_image'].toString();
      attributes = parseAllAttributes(res.data['ResponseData'] as  Map<String,dynamic>);
      update();
    } else {
    }
  }
}