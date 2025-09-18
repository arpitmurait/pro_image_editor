// file: frame_data_models.dart
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class ApiService {
  Future<List<AttributeModel>> fetchFrameData() async {
    const String apiUrl = 'http://192.168.1.24:1000/api/frame-data-list/25/1/6';
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
      log("response.data ${response.data}");
      // If the server returns a 200 OK response, parse the JSON.
      return parseAllAttributes(response.data['ResponseData'] as  Map<String,dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load frame data: ${response.statusCode}');
    }
  }
}

List<AttributeModel> parseAllAttributes(Map<String, dynamic> decodedJson) {

  // 2. Get the top-level list associated with the "attr" key.
  final List<dynamic> attrList = decodedJson['attr'] as List;

  // 3. Create an empty list to hold the final, flattened results.
  final List<AttributeModel> allAttributes = [];

  // 4. Loop through each item in the 'attrList' (e.g., {"Logo": [...]}, {"Name": [...]}).
  for (var item in attrList) {
    // 'item' is a Map like {"Name": [...]}. We don't care about the key "Name",
    // we just want its value, which is the list of attributes.
    // 'item.values.first' safely gets that inner list.
    final List<dynamic> innerList = item.values.first as List;

    // 5. Loop through each attribute object in the inner list.
    for (var attributeJson in innerList) {
      // 6. Convert the JSON map to an AttributeModel object and add it to our final list.
      allAttributes.add(AttributeModel.fromJson(attributeJson as Map<String, dynamic>));
    }
  }

  return allAttributes;
}

class AttributeModel {
  final int id;
  final bool isText;
  final String imagePath;
  final Color? imageColor;
  final String? text;
  final double? textSize;
  final double width;
  final double height;
  final double offsetX;
  final double offsetY;
  final Color? fontColor;
  final FontWeight? fontStyle;
  final String? fontFamily;

  AttributeModel({
    required this.id,
    required this.isText,
    required this.imagePath,
    this.imageColor,
    this.text,
    this.textSize,
    required this.width,
    required this.height,
    required this.offsetX,
    required this.offsetY,
    this.fontColor,
    this.fontStyle,
    this.fontFamily,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) {
    // Helper function to parse color hex string
    Color? getColorFromHex(String? hexColor) {
      // 1. Handle null or empty inputs immediately.
      if (hexColor == null || hexColor.isEmpty) {
        return null;
      }
      // 2. Use a try-catch block to prevent crashes from bad data.
      try {
        hexColor = hexColor.toUpperCase().replaceAll("#", "");
        if (hexColor.length == 6) {
          hexColor = "FF" + hexColor; // Add full opacity
        }
        // Ensure the final string is a valid 8-character hex code before parsing
        if (hexColor.length == 8) {
          return Color(int.parse(hexColor, radix: 16));
        }
      } catch (e) {
        // If parsing fails for any reason, print an error and fall through to return null.
        print('Error parsing color: $hexColor. Error: $e');
      }
      // 3. Return null if the input was not a valid 6 or 8 character hex string.
      return null;
    }
    // Helper function to parse font weight
    FontWeight? getFontWeight(String? style) {
      if (style == null) return null;
      switch (style.toLowerCase()) {
        case 'bold':
          return FontWeight.bold;
      // Add other cases like 'normal', 'italic'
        default:
          return FontWeight.normal;
      }
    }

    return AttributeModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      isText: json['isText'] == '1',
      imagePath: json['imagePath']?.toString() ?? "",
      imageColor: getColorFromHex(json['imageColor'].toString()),
      text: json['text'].toString(),
      textSize: double.tryParse(json['textSize'].toString()),
      width: double.tryParse(json['width'].toString()) ?? 0.0,
      height: double.tryParse(json['height'].toString()) ?? 0.0,
      offsetX: double.tryParse(json['offsetX'].toString()) ?? 0.0,
      offsetY: double.tryParse(json['offsetY'].toString()) ?? 0.0,
      fontColor: getColorFromHex(json['fontColor'].toString()),
      fontStyle: getFontWeight(json['fontStyle'].toString()),
      fontFamily: json['fontFamily'].toString(),
    );
  }
}