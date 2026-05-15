import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raouf26mobileapp/View/Screen/MessagesScreen/chat_view.dart';
import '../controller/transporter_tracking_controller.dart';
import 'widgets/voice_call_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:raouf26mobileapp/Utils/custom_snackbar.dart';

class DeliveryCompletedPage extends StatelessWidget {
  final TrackingPackageModel package;
  
  const DeliveryCompletedPage({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      body: Stack(
        children: [
          // Background: Mock Map/Tracking Visualization
          Positioned.fill(
            child: _buildMockMapBackground(isDarkMode),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                // Custom Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18.sp,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'Delivery Completed',
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.format_list_bulleted_rounded,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Delivery Summary Card
                _buildSummaryCard(context, isDarkMode),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockMapBackground(bool isDarkMode) {
    return Container(
      color: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      child: Stack(
        children: [
          // Scattered Background Icons
          _positionedIcon(top: 0.15, left: 0.2, icon: Icons.navigation_outlined, size: 24.sp, opacity: 0.1, rotation: 0.5),
          _positionedIcon(top: 0.25, right: 0.3, icon: Icons.navigation_outlined, size: 20.sp, opacity: 0.1, rotation: 2.5),
          _positionedIcon(bottom: 0.4, left: 0.25, icon: Icons.navigation_outlined, size: 22.sp, opacity: 0.1, rotation: 1.2),
          _positionedIcon(bottom: 0.3, right: 0.4, icon: Icons.navigation_outlined, size: 18.sp, opacity: 0.1, rotation: 4.0),
          
          // Main Route Visualization
          Center(
            child: CustomPaint(
              size: Size(300.w, 400.h),
              painter: RoutePainter(isDarkMode),
            ),
          ),
          
          // Route Icons
          Positioned(
            top: 0.35.sh,
            left: 0.42.sw,
            child: _buildPointIcon(Icons.navigation_rounded, Colors.black, Colors.white, true),
          ),
          Positioned(
            top: 0.45.sh,
            right: 0.25.sw,
            child: _buildPointIcon(Icons.location_on_rounded, const Color(0xFF4A80F0), Colors.white, false),
          ),
        ],
      ),
    );
  }

  Widget _positionedIcon({double? top, double? left, double? right, double? bottom, required IconData icon, required double size, required double opacity, required double rotation}) {
    return Positioned(
      top: top?.sh,
      left: left?.sw,
      right: right?.sw,
      bottom: bottom?.sh,
      child: Transform.rotate(
        angle: rotation,
        child: Icon(icon, color: const Color(0xFF4A80F0).withOpacity(opacity), size: size),
      ),
    );
  }

  Widget _buildPointIcon(IconData icon, Color bgColor, Color iconColor, bool isShadow) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          if (isShadow)
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          if (!isShadow)
            BoxShadow(
              color: bgColor.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 5,
            ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: 24.sp),
    );
  }

  Widget _buildSummaryCard(BuildContext context, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile & Price
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Icon(Icons.person, color: Colors.blue.shade200, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.userName,
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      package.id,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '€${package.price.toInt()}',
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Action Buttons & Badge
          Row(
            children: [
              _buildSmallActionIcon(Icons.send_rounded, isDarkMode, onTap: () async {
                final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=${package.toCity}');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  CustomSnackbar.error(title: "Error", message: "Could not launch maps");
                }
              }),
              SizedBox(width: 8.w),
              _buildSmallActionIcon(Icons.chat_bubble_rounded, isDarkMode, onTap: () {
                Get.to(() => ChatView(
                  userData: {
                    'name': package.userName,
                    'image': package.userImage,
                    'isSupport': false,
                    'message': 'Hello, regarding package ${package.id}',
                    'from': package.fromCity,
                    'to': package.toCity,
                    'price': '€${package.price.toStringAsFixed(0)}',
                    'weight': package.packageSize,
                  },
                ));
              }),
              SizedBox(width: 8.w),
              _buildSmallActionIcon(Icons.phone_rounded, isDarkMode, onTap: () => showVoiceCallSheet(context, package)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: const Color(0xFF4CAF50), size: 16.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'Drop-off confirmed',
                      style: GoogleFonts.manrope(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Timeline Row with Dotted Line
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimelinePointIcon(Icons.calendar_month_outlined, isDarkMode),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: List.generate(25, (index) => Expanded(
                          child: Container(
                            height: 1.5.h,
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            color: index % 2 == 0 ? const Color(0xFF4A80F0).withOpacity(0.5) : Colors.transparent,
                          ),
                        )),
                      ),
                    ),
                  ),
                  _buildTimelinePointIcon(Icons.location_on_outlined, isDarkMode, isLocation: true),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 10.h),
          
          // Location Names & Date/Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLocationDetails(package.fromCity, "Picked up", "May 16, 09:15", isDarkMode, isEnd: false),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: const Color(0xFF4CAF50), size: 20.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'Delivered',
                        style: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Package successfully delivered',
                    style: GoogleFonts.manrope(
                      fontSize: 10.sp,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _buildLocationDetails(package.toCity, "Delivered", "May 16, 16:42", isDarkMode, isEnd: true),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Proof Section
          Text(
            'Proof of Delivery',
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildProofItem("Delivered Photo", isDarkMode, imageUrl: "https://images.pexels.com/photos/4481258/pexels-photo-4481258.jpeg"),
              SizedBox(width: 10.w),
              _buildProofItem("Recipient QR Scan", isDarkMode, icon: Icons.qr_code_2_rounded),
              SizedBox(width: 10.w),
              _buildProofItem("Signature / Confirmation", isDarkMode, text: "M. Henry"),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Final Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(color: Colors.grey.shade200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: Text(
                    'View Details',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: Text(
                    'View Delivery Proof',
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelinePointIcon(IconData icon, bool isDarkMode, {bool isLocation = false}) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: const Color(0xFF4A80F0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, size: 18.sp, color: const Color(0xFF4A80F0)),
    );
  }

  Widget _buildLocationDetails(String city, String status, String time, bool isDarkMode, {required bool isEnd}) {
    return Column(
      crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: GoogleFonts.manrope(
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          status,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.manrope(
            fontSize: 10.sp,
            color: isDarkMode ? Colors.white54 : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProofItem(String label, bool isDarkMode, {String? imageUrl, IconData? icon, String? text}) {
    return Expanded(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(16.r),
                image: imageUrl != null ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover) : null,
              ),
              child: Stack(
                children: [
                  if (icon != null) Center(child: Icon(icon, size: 32.sp, color: Colors.grey.shade500)),
                  if (text != null) Center(child: Text(text, style: GoogleFonts.dancingScript(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade800))),
                  Positioned(
                    right: 8.w,
                    bottom: 8.h,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.check_circle, color: const Color(0xFF4CAF50), size: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 10.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallActionIcon(IconData icon, bool isDarkMode, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.sp, color: Colors.grey.shade600),
      ),
    );
  }
}

class RoutePainter extends CustomPainter {
  final bool isDarkMode;
  RoutePainter(this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A80F0).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.45, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.6, size.height * 0.4,
      size.width * 0.7, size.height * 0.5,
    );

    // Draw dotted line
    double dashWidth = 5, dashSpace = 5, distance = 0;
    for (var i = 0; i < 20; i++) {
      // Very simple manual dash for demonstration
    }
    
    // For simplicity, just a smooth curve
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
