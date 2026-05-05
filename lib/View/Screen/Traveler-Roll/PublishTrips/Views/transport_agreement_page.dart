import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'trip_published_page.dart';
import 'transport_agreement_success_page.dart';

class TransportAgreementPage extends StatefulWidget {
  final bool isDarkMode;
  final bool fromProfile;
  const TransportAgreementPage({super.key, required this.isDarkMode, this.fromProfile = false});

  @override
  State<TransportAgreementPage> createState() => _TransportAgreementPageState();
}

class _TransportAgreementPageState extends State<TransportAgreementPage> {
  String selectedValidity = "Valid for 6 Months";
  bool isTypeMode = true;
  bool isAgreed = false;
  final TextEditingController signatureController = TextEditingController();
  List<Offset?> signaturePoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Transport Agreement",
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    "4. Digital agreements and legal acceptance",
                    "By signing this document, the Transporter acknowledges that digital signatures are legally binding and equivalent to handwritten signatures. You agree to be bound by the terms of this digital agreement and the platform's overall policies.",
                  ),
                  _buildTermItem(
                    "5. Commission Structure",
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

            // Signature Card
            _buildSectionCard(
              title: "Signature",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: widget.isDarkMode
                          ? Colors.white.withOpacity(0.05)
                          : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildToggleButton("Type", isTypeMode),
                        ),
                        Expanded(
                          child: _buildToggleButton("Draw", !isTypeMode),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    isTypeMode ? "Type your name" : "Draw your signature",
                    style: GoogleFonts.manrope(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: widget.isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 120.h,
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
                            style: GoogleFonts.manrope(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: widget.isDarkMode ? Colors.white : Colors.black,
                            ),
                          )
                        : GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                signaturePoints.add(details.localPosition);
                              });
                            },
                            onPanEnd: (details) {
                              signaturePoints.add(null);
                            },
                            child: Stack(
                              children: [
                                CustomPaint(
                                  painter: SignaturePainter(signaturePoints, widget.isDarkMode),
                                  size: Size.infinite,
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        signaturePoints.clear();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        size: 14.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                if (signaturePoints.isEmpty)
                                  const Center(
                                    child: Text(
                                      "Draw Signature Here",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Legal Acceptance Checkbox
            Row(
              children: [
                SizedBox(
                  height: 24.w,
                  width: 24.w,
                  child: Checkbox(
                    value: isAgreed,
                    onChanged: (val) => setState(() => isAgreed = val ?? false),
                    activeColor: const Color(0xFF4A80F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "I have read and agree to the Transport Agreement",
                    style: GoogleFonts.manrope(
                      fontSize: 13.sp,
                      color: widget.isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: (isAgreed &&
                        (isTypeMode
                            ? signatureController.text.isNotEmpty
                            : signaturePoints.isNotEmpty))
                    ? () {
                        if (widget.fromProfile) {
                          Get.to(() => TransportAgreementSuccessPage(isDarkMode: widget.isDarkMode));
                        } else {
                          Get.to(() => TripPublishedPage(isDarkMode: widget.isDarkMode));
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A80F0),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Confirm & Publish",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    ),
  );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTermItem(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: widget.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            content,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              color: widget.isDarkMode ? Colors.white70 : Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidityOption(String title) {
    bool isSelected = selectedValidity == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedValidity = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A80F0).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4A80F0)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF4A80F0) : Colors.grey,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF4A80F0)
                    : (widget.isDarkMode ? Colors.white70 : Colors.black87),
              ),
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
            style: GoogleFonts.manrope(
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

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final bool isDarkMode;

  SignaturePainter(this.points, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isDarkMode ? Colors.white : Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
