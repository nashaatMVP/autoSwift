import 'package:autoswift/core/components/custom_text.dart';
import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key, required this.carData});
  final Map carData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(carData['image']),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "${carData['model']}",fontSize: 19,fontWeight: FontWeight.w400),
                    CustomText(text: "${carData['price']}\$",fontSize: 20,fontWeight: FontWeight.w600),
                  ],
                ),
                CustomText(text: "${carData['brand']}",fontSize: 17,fontWeight: FontWeight.bold,color: Colors.blue),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Car Engine ${carData['engine']}"),
                    CustomText(text: "Car Speed ${carData['speed']}"),
                    CustomText(text: "Car Seats ${carData['seats']}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
