import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // ৩ সেকেন্ড পর হোম স্ক্রিনে যাবে (যখন হোম পেজ থাকবে)
    /*
    Timer(const Duration(seconds: 3), () {
      // Get.offAll(() => HomePage()); 
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Home.png'),
            fit: BoxFit.cover, // পুরো স্ক্রিন জুড়ে থাকবে
          ),
        ),
        // যদি ইমেজের ওপর কোনো লোডিং বা টেক্সট দিতে চান, এখানে দিতে পারেন
        /*
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        */
      ),
    );
  }
}
