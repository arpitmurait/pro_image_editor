

import 'package:example/poster_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickersPage extends StatelessWidget {
  final Function(String) onStickerClick;
  const StickersPage({super.key, required this.onStickerClick});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosterController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Horizontal Chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.stickerSubCategories.length,
                itemBuilder: (context, index) {
                  final isSelected = controller.selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: ChoiceChip(
                      label: Text(controller.stickerSubCategories[index]['title'].toString()),
                      selected: isSelected,
                      checkmarkColor: Colors.black,
                      onSelected: (_) => controller.updateCategory(index),
                      selectedColor: Colors.yellow,
                      backgroundColor: Colors.grey.shade300,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            // Stickers Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.stickers.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => onStickerClick.call(controller.stickers[index]['image'].toString()),
                    child: Image.network(
                      controller.stickers[index]['image'].toString(),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}