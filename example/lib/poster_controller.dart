import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'frame_response.dart';

class PosterController extends GetxController {
  List frames = [];
  List<AttributeModel> attributes = [];
  List stickerSubCategories = [];
  List stickers = [];
  String frameUrl = "";
  RxBool frameUpdating = false.obs;
  int selectedIndex = 0;

  @override
  void onInit() {
    getFrames();
    getStickerCategoryList();
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

  getStickerCategoryList() async {
    String apiUrl = 'http://192.168.1.24:1000/api/sticker-subcategory/1';

    final res = await dio.Dio().get(apiUrl,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        )
    );

    if (res.statusCode == 200) {
      stickerSubCategories = res.data['ResponseData'] as List;
      fetchStickers(frames[0]['id'].toString());
      update();
    } else {
    }
  }

  updateCategory(int index){
    selectedIndex = index;
    fetchStickers(stickerSubCategories[index]['id'].toString());
    update();
  }

  fetchStickers(String id) async {
    String apiUrl = 'http://192.168.1.24:1000/api/sticker-subcategory-image/$id';

    final res = await dio.Dio().get(apiUrl,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        )
    );

    if (res.statusCode == 200) {
      stickers = res.data['ResponseData'] as List;
      update();
    } else {
    }
  }

}