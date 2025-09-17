// file: frame_data_models.dart
import 'dart:convert';

class ApiService {
  Future<FrameDataResponse> fetchFrameData() async {
    // const String apiUrl = 'http://192.168.1.12:5000/api/frame-data-list/25/1/6';
    // const String bearerToken = '27|UIcpM1TLITp97kYuGyX3G8EbY4sRN0Iu85uxXtvTb026de7b';
    //
    // final response = await http.get(
    //   Uri.parse(apiUrl),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'bearerToken': bearerToken,
    //   },
    // );
    //
    // if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return FrameDataResponse.fromJson( {
        "id": 25,
        "type_id": 1,
        "height": "1080",
        "image": "http://172.20.10.3:2000/admin-uploads/image/Post-Personal-Footer-design-02.png",
        "background_image": "Post-Personal-Footer-design2.png",
        "width": "1080",
        "status": "1",
        "created_at": "2023-10-18T17:26:20.000000Z",
        "updated_at": "2023-10-18T17:26:20.000000Z",
        "backgroundImage": "http://172.20.10.3:2000/admin-uploads/backgroundimage",
        "attr": [
          {
            "Logo": [
              {
                "id": 421,
                "frame_id": 25,
                "attribute_id": 369,
                "isText": "0",
                "imagePath": "http://172.20.10.3:2000/user-uploads/personal-details",
                "imageColor": "FFFFFF",
                "text": null,
                "textSize": null,
                "width": "120",
                "height": "120",
                "offsetX": "50",
                "offsetY": "50",
                "fontColor": null,
                "fontStyle": null,
                "fontFamily": null,
                "created_at": "2023-10-18T17:26:20.000000Z",
                "updated_at": "2023-10-18T17:26:20.000000Z"
              }
            ]
          },
          {
            "Name": [
              {
                "id": 422,
                "frame_id": 25,
                "attribute_id": 370,
                "isText": "1",
                "imagePath": null,
                "imageColor": null,
                "text": "narpat",
                "textSize": "25",
                "width": "138.2813",
                "height": "29.125",
                "offsetX": "246.5234",
                "offsetY": "981.9902",
                "fontColor": "282828",
                "fontStyle": "Bold",
                "fontFamily": "http://172.20.10.3:2000/admin-uploads/font/Calibri-Bold.ttf",
                "created_at": "2023-10-18T17:26:20.000000Z",
                "updated_at": "2023-10-18T17:26:20.000000Z"
              },
              {
                "id": 423,
                "frame_id": 25,
                "attribute_id": 370,
                "isText": "0",
                "imagePath": null,
                "imageColor": "282828",
                "text": null,
                "textSize": null,
                "width": "38.3789",
                "height": "42.221",
                "offsetX": "188.8652",
                "offsetY": "974.6586",
                "fontColor": null,
                "fontStyle": null,
                "fontFamily": null,
                "created_at": "2023-10-18T17:26:21.000000Z",
                "updated_at": "2023-10-18T17:26:21.000000Z"
              }
            ]
          },
          {
            "Contact": [
              {
                "id": 424,
                "frame_id": 25,
                "attribute_id": 371,
                "isText": "1",
                "imagePath": null,
                "imageColor": null,
                "text": "9725565993",
                "textSize": "25",
                "width": "181.458",
                "height": "29.127",
                "offsetX": "706.7549",
                "offsetY": "981.9902",
                "fontColor": "282828",
                "fontStyle": "Bold",
                "fontFamily": "http://172.20.10.3:2000/admin-uploads/font/Calibri-Bold.ttf",
                "created_at": "2023-10-18T17:26:21.000000Z",
                "updated_at": "2023-10-18T17:26:21.000000Z"
              },
              {
                "id": 425,
                "frame_id": 25,
                "attribute_id": 371,
                "isText": "0",
                "imagePath": null,
                "imageColor": "282828",
                "text": null,
                "textSize": null,
                "width": "34.5401",
                "height": "38.4215",
                "offsetX": "654.7691",
                "offsetY": "976.7177",
                "fontColor": null,
                "fontStyle": null,
                "fontFamily": null,
                "created_at": "2023-10-18T17:26:21.000000Z",
                "updated_at": "2023-10-18T17:26:21.000000Z"
              }
            ]
          }
        ]
      });
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // throw an exception.
    //   throw Exception('Failed to load frame data: ${response.statusCode}');
    // }
  }
}

class FrameDataResponse {
  final int id;
  final double height;
  final double width;
  final String image;
  final String backgroundImage;
  // This is a List of Maps, where each Map has a dynamic key ("Logo", "Name", etc.)
  final List<Map<String, List<AttributeDetail>>> attr;

  FrameDataResponse({
    required this.id,
    required this.height,
    required this.width,
    required this.image,
    required this.backgroundImage,
    required this.attr,
  });

  factory FrameDataResponse.fromJson(Map<String, dynamic> json) {
    // The 'attr' field is a list of single-key maps. We'll parse it carefully.
    List<Map<String, List<AttributeDetail>>> parsedAttr = [];
    if (json['attr'] != null) {
      for (var item in (json['attr'] as List)) {
        var mapItem = item as Map<String, dynamic>;
        var key = mapItem.keys.first;
        var value = mapItem[key] as List;
        List<AttributeDetail> details = value.map((i) => AttributeDetail.fromJson(i as Map<String,dynamic>)).toList();
        parsedAttr.add({key: details});
      }
    }

    return FrameDataResponse(
      id: int.tryParse(json["id"].toString()) ?? 0,
      // API provides height/width as String, so we must parse them.
      height: double.tryParse(json["height"].toString()) ?? 0,
      width: double.tryParse(json["width"].toString()) ?? 0,
      image: json["image"].toString(),
      backgroundImage: json["background_image"].toString(),
      attr: parsedAttr,
    );
  }
}

class AttributeDetail {
  final int id;
  final String isText; // "1" for text, "0" for image/icon
  final String? imagePath;
  final String? text;
  final double? textSize;
  final double width;
  final double height;
  final double offsetX;
  final double offsetY;
  final String? fontColor; // Hex string like "282828"
  final String? fontFamily; // URL to a font file

  AttributeDetail({
    required this.id,
    required this.isText,
    this.imagePath,
    this.text,
    this.textSize,
    required this.width,
    required this.height,
    required this.offsetX,
    required this.offsetY,
    this.fontColor,
    this.fontFamily,
  });

  factory AttributeDetail.fromJson(Map<String, dynamic> json) {
    return AttributeDetail(
      id: int.tryParse(json["id"].toString()) ?? 0,
      isText: json["isText"].toString(),
      imagePath: json["imagePath"] as String?,
      text: json["text"] as String?,
      // Parse values from String to double, providing defaults
      textSize: double.tryParse(json["textSize"].toString()) ?? 14,
      height: double.tryParse(json["height"].toString()) ?? 0,
      width: double.tryParse(json["width"].toString()) ?? 0,
      offsetX: double.tryParse(json["offsetX"].toString()) ?? 0,
      offsetY: double.tryParse(json["offsetY"].toString()) ?? 0,
      fontColor: json["fontColor"] as String?,
      fontFamily: json["fontFamily"] as String?,
    );
  }
}

class DataTransformer {

  /// Converts a hex color string (e.g., "FFFFFF" or "282828")
  /// to the integer format required by Flutter (0xAARRGGBB).
  int _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return 0xFF000000; // Default to black
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Add full opacity
    }
    return int.parse(hexColor, radix: 16);
  }

  /// Extracts the font name from a URL.
  /// Example: "http://.../Calibri-Bold.ttf" becomes "Calibri-Bold"
  /// **IMPORTANT**: You must have this font registered in your pubspec.yaml
  String _parseFontFamily(String? fontUrl) {
    if (fontUrl == null || fontUrl.isEmpty) {
      return "Roboto"; // Default font
    }
    // Get the last part of the URL
    String fileName = fontUrl.split('/').last;
    // Remove the extension (.ttf, .otf)
    return fileName.split('.').first;
  }

  /// The main transformation function.
  Map<String, dynamic> transformApiDataToEditorMap(FrameDataResponse apiResponse) {
    List<Map<String, dynamic>> layers = [];

    // Iterate through the 'attr' list from the API response
    for (var attrMap in apiResponse.attr) {
      // Each item is a map with one key, so we get its value (which is a list)
      for (var detail in attrMap.values.first) {

        // We only create a layer for text items as per the requirement
        if (detail.isText == "1" && detail.text != null) {
          final layer = {
            "type": "text",
            "text": detail.text,
            "x": detail.offsetX,
            "y": detail.offsetY,
            "rotation": 0.0,
            "scale": 1.0,
            "flipX": false,
            "flipY": false,
            "style": {
              // Important: You must have these fonts available in your app
              "fontFamily": _parseFontFamily(detail.fontFamily),
              "fontSize": detail.textSize ?? 18.0,
            },
            "color": _parseColor(detail.fontColor),
            "background": 0, // 0 means transparent
            "colorMode": "onlyColor",
            "align": "left", // You might want to make this dynamic if the API provides it
          };
          layers.add(layer);
        }
        // You could add logic here for image layers if needed (isText == "0")
        /*
        else if (detail.isText == "0" && detail.imagePath != null) {
            final layer = {
                "type": "image",
                "image": detail.imagePath, // The editor needs to handle network images
                "x": detail.offsetX,
                "y": detail.offsetY,
                // ... other image properties
            };
            layers.add(layer);
        }
        */
      }
    }

    // Construct the final map in the required format
    final editorMap = {
      "position": 0,
      "imgSize": {"width": apiResponse.width, "height": apiResponse.height},
      "history": [
        {
          "listPosition": 0,
          "layers": layers,
          "filters": []
        }
      ]
    };

    return editorMap;
  }
}