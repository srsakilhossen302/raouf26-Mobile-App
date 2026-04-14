import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'trip_published_page.dart';

class TransportAgreementPage extends StatefulWidget {
  final bool isDarkMode;
  const TransportAgreementPage({super.key, required this.isDarkMode});

  @override
  State<TransportAgreementPage> createState() => _TransportAgreementPageState();
}

class _TransportAgreementPageState extends State<TransportAgreementPage> {
  String selectedValidity = "Valid for 6 Months";
  bool isTypeMode = true;
  final TextEditingController signatureController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Transport Agreement",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Agreement Terms Card
            _buildSectionCard(
              title: "Transport Agreement Terms",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTermItem(
                    "1. Introduction",
                    "This Transport Agreement (\"Agreement\") is entered into between the carrier (\"Transporter\") and the platform (\"Service Provider\") for the purpose of facilitating parcel delivery services.",
                  ),
                  _buildTermItem(
                    "2. Scope of Services",
                    "The Transporter agrees to transport parcels from designated pickup locations to delivery destinations as specified by senders through the platform. All deliveries must be completed in a timely and professional manner.",
                  ),
                  _buildTermItem(
                    "3. Responsibilities",
                    "The Transporter is responsible for:\n• Safe handling and transport of all accepted parcels.\n• Timely pickup and delivery as per agreed schedules.\n• Maintaining proper documentation and proof of delivery.\n• Communicating any delays or issues promptly.\n• Ensuring parcels are not damaged, lost, or tampered with.",
                  ),
                  _buildTermItem(
                    "4. Commission Structure",
                    "A commission will be deducted from both the traveler (sender) and transporter per completed delivery. The commission rates are as follows:\n• Sender commission: 5% of the agreed delivery price\n• Transporter commission: 5% of the agreed delivery price",
                  ),
                  _buildTermItem(
                    "7. Prohibited Items",
                    "Transporters must not accept parcels containing illegal substances, weapons, hazardous materials, or any items prohibited by law.",
                  ),
                  _buildTermItem(
                    "8. Liability and Insurance",
                    "The Transporter acknowledges that they are responsible for obtaining appropriate insurance coverage for transported goods. The platform is not liable for any damages, losses, or claims arising from transportation.",
                  ),
                  _buildTermItem(
                    "10. Governing Law",
                    "This Agreement shall be governed by and construed in accordance with the laws of the jurisdiction in which the platform operates.",
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Contract Validity Card
            _buildSectionCard(
              title: "Select Contract Validity",
              child: Column(
                children: [
                  _buildValidityOption("Valid for One Trip"),
                  SizedBox(height: 12.h),
                  _buildValidityOption("Valid for 6 Months"),
                  SizedBox(height: 12.h),
                  _buildValidityOption("Valid for 1 Year"),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Signature Confirmation Card
            _buildSectionCard(
              title: "Signature Confirmation",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Type or draw your signature to confirm and authorize this agreement.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Toggle Button
                  Container(
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? Colors.white10
                          : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _buildToggleButton("Type", isTypeMode)),
                        Expanded(
                          child: _buildToggleButton("Draw", !isTypeMode),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    isTypeMode ? "Type Your Signature" : "Draw Your Signature",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: isTypeMode
                        ? TextField(
                            controller: signatureController,
                            decoration: InputDecoration(
                              hintText: "Type here",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.w),
                            ),
                            style: GoogleFonts.plusJakartaSans(fontSize: 16.sp),
                          )
                        : const Center(
                            child: Text(
                              "Draw Area",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Sign & Activate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => TripPublishedPage(isDarkMode: widget.isDarkMode),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Sign & Activate",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? Colors.white.withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          if (!widget.isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTermItem(String title, String desc) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            desc,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidityOption(String label) {
    bool isSelected = selectedValidity == label;
    return GestureDetector(
      onTap: () => setState(() => selectedValidity = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : Colors.grey.withOpacity(0.2),
          ),
          color: isSelected
              ? const Color(0xFF4A80F0).withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4A80F0)
                      : Colors.grey.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => isTypeMode = (label == "Type")),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4A80F0) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
