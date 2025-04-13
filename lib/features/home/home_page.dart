import 'package:autoswift/core/components/custom_text.dart';
import 'package:autoswift/features/admin/admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/components/custom_container.dart';
import 'car_details.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String? selectedBrand;
  final List<String> brands = ['All', 'Bmw', 'Lamborghini', 'Audi' , 'Shelby' , 'Dodge' , 'Mercedes'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.grey.shade300,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrxWd_qyeMG-05UoSEmiNlEcKzWnIpoXdl_A&s",
                  ),
                ),
                const CustomText(
                  text: "Boston , NewYork",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => AdminPageView())),
                    child: const Icon(CupertinoIcons.circle_grid_3x3)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CustomText(text: "Hello, ", fontSize: 35, color: Colors.grey.shade400),
                const CustomText(text: "Rich Sonic", fontSize: 35),
              ],
            ),
            const CustomText(
              text: "Choose your Ideal Car",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands.map((brand) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBrand = brand == 'All' ? null : brand;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: CustomContainer(
                        color: selectedBrand == brand ? Colors.blue : Colors.white,
                        radius: 20,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: CustomText(text: brand, color: selectedBrand == brand ? Colors.white : Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: selectedBrand == null
                    ? FirebaseFirestore.instance.collection('cars').snapshots()
                    : FirebaseFirestore.instance.collection('cars').where('brand', isEqualTo: selectedBrand).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No cars available"));
                  }
                  var cars = snapshot.data!.docs;
                  return GridView.builder(
                    itemCount: cars.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 2,
                      childAspectRatio: 1 / 1.03,
                    ),
                    itemBuilder: (context, index) {
                      var car = cars[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => CarDetails(carData: car))),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(car['image'],  fit: BoxFit.cover),
                                CustomText(text: car['model'], fontSize: 14, fontWeight: FontWeight.w400,maxLines: 1),
                                CustomText(text: car['brand'], fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "\$${car['price']}", fontSize: 16, fontWeight: FontWeight.bold),
                                    const Icon(Icons.arrow_circle_right_rounded, color: Colors.blue),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
