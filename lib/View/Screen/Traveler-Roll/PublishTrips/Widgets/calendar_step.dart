import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Controllers/publish_trip_flow_controller.dart';

class CalendarStep extends StatefulWidget {
  final PublishTripFlowController controller;
  final bool isDarkMode;

  const CalendarStep({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  @override
  State<CalendarStep> createState() => _CalendarStepState();
}

class _CalendarStepState extends State<CalendarStep> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _dragOffset = 0.0;
  late final double _maxDragOffset;

  @override
  void initState() {
    super.initState();
    _maxDragOffset = 450.h;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    final double start = _dragOffset;
    _animationController.stop();
    _animationController.reset();

    final Animation<double> animation = Tween<double>(
      begin: start,
      end: target,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
      });
    });

    _animationController.forward();
  }

  void _animateToDismiss(double target) {
    final double start = _dragOffset;
    _animationController.stop();
    _animationController.reset();

    final Animation<double> animation = Tween<double>(
      begin: start,
      end: target,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    animation.addListener(() {
      setState(() {
        _dragOffset = animation.value;
      });
    });

    _animationController.forward().then((_) {
      widget.controller.clearSelection();
      setState(() {
        _dragOffset = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 250.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Publish Your Trip",
                  style: GoogleFonts.manrope(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "List your journey and accept delivery requests from trusted senders.",
                  style: GoogleFonts.manrope(
                    fontSize: 14.sp,
                    color: widget.isDarkMode
                        ? Colors.white70
                        : const Color(0xFF666666),
                  ),
                ),
                SizedBox(height: 24.h),

                // Calendar Container
                Container(
                  decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Obx(() {
                    return TableCalendar(
                      firstDay: DateTime.now().subtract(
                        const Duration(days: 30),
                      ),
                      lastDay: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      focusedDay: widget.controller.focusedDate.value,
                      currentDay: DateTime.now(),
                      headerVisible: true,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: GoogleFonts.manrope(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        leftChevronVisible: true,
                        rightChevronVisible: true,
                      ),
                      onPageChanged: (focusedDay) {
                        widget.controller.focusedDate.value = focusedDay;
                      },
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                        weekendStyle: GoogleFonts.manrope(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        weekendTextStyle: GoogleFonts.manrope(
                          fontSize: 14.sp,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFF4A80F0),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: const Color(0xFF4A80F0).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(widget.controller.selectedDate.value, day) ||
                            isSameDay(widget.controller.returnDate.value, day);
                      },
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final controller = widget.controller;
                          if (controller.selectedDate.value != null &&
                              controller.returnDate.value != null &&
                              day.isAfter(controller.selectedDate.value!) &&
                              day.isBefore(controller.returnDate.value!)) {
                            // Highlight range between selected departure and return dates
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4A80F0).withOpacity(0.15),
                                shape: BoxShape.rectangle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: GoogleFonts.manrope(
                                  fontSize: 14.sp,
                                  color: widget.isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        final controller = widget.controller;
                        if (controller.selectedDate.value == null) {
                          controller.selectedDate.value = selectedDay;
                          controller.focusedDate.value = focusedDay;
                          _animateTo(0.0);
                        } else if (controller.returnDate.value == null) {
                          if (selectedDay.isAfter(controller.selectedDate.value!)) {
                            controller.returnDate.value = selectedDay;
                            controller.focusedDate.value = focusedDay;
                            _animateTo(0.0);
                          } else {
                            controller.selectedDate.value = selectedDay;
                            controller.focusedDate.value = focusedDay;
                          }
                        } else {
                          if (isSameDay(controller.returnDate.value, selectedDay)) {
                            controller.returnDate.value = null;
                          } else if (isSameDay(controller.selectedDate.value, selectedDay)) {
                            controller.selectedDate.value = null;
                            controller.returnDate.value = null;
                          } else if (selectedDay.isAfter(controller.selectedDate.value!)) {
                            controller.returnDate.value = selectedDay;
                            controller.focusedDate.value = focusedDay;
                            _animateTo(0.0);
                          } else {
                            controller.selectedDate.value = selectedDay;
                            controller.returnDate.value = null;
                            controller.focusedDate.value = focusedDay;
                          }
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),

        // Selection UI (Draggable Bottom Sheet)
        Positioned(
          bottom: -_dragOffset,
          left: 0,
          right: 0,
          child: Obx(() {
            if (widget.controller.selectedDate.value == null) return const SizedBox();
            return Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.w),
              decoration: BoxDecoration(
                color: widget.isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle Area
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        _dragOffset += details.primaryDelta!;
                        _dragOffset = _dragOffset.clamp(0.0, _maxDragOffset);
                      });
                    },
                    onVerticalDragEnd: (details) {
                      double velocity = details.primaryVelocity ?? 0;
                      if (velocity > 200 || _dragOffset > 120.h) {
                        _animateToDismiss(_maxDragOffset);
                      } else {
                        _animateTo(0.0);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Column(
                        children: [
                          // Centered Horizontal Pill
                          Center(
                            child: Container(
                              width: 48.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: widget.isDarkMode ? Colors.white24 : Colors.black12,
                                borderRadius: BorderRadius.circular(2.5.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Date display row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    if (_dragOffset > 50.0) {
                                      _animateTo(0.0);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1A1A),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      [
                                        DateFormat('EEE, d MMM').format(widget.controller.selectedDate.value!).toUpperCase(),
                                        if (widget.controller.returnDate.value != null)
                                          "RET. ${DateFormat('EEE, d MMM').format(widget.controller.returnDate.value!).toUpperCase()}",
                                        if (widget.controller.departureTime.value.isNotEmpty) "Dep. ${widget.controller.departureTime.value}",
                                        if (widget.controller.arrivalTime.value.isNotEmpty) "Arr. ${widget.controller.arrivalTime.value}",
                                      ].join(" • "),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Departure & Destination Card
                      Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () {
                            if (_dragOffset > 50.0) {
                              _animateTo(0.0);
                            } else {
                              widget.controller.currentStep.value = 1;
                            }
                          },
                          child: _buildSelectionCard(
                            isDarkMode: widget.isDarkMode,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4FF),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: const Icon(
                                    Icons.route_outlined,
                                    color: Color(0xFF4A80F0),
                                    size: 18,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Departure & Destination",
                                  style: GoogleFonts.manrope(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Obx(
                                  () => _buildMiniInput(
                                    Icons.location_on,
                                    widget.controller.departureText.value.isEmpty
                                        ? "Departure"
                                        : widget.controller.departureText.value,
                                    widget.isDarkMode,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Obx(
                                  () => _buildMiniInput(
                                    Icons.near_me,
                                    widget.controller.destinationText.value.isEmpty
                                        ? "Destination"
                                        : widget.controller.destinationText.value,
                                    widget.isDarkMode,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Right Column
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_dragOffset > 50.0) {
                                  _animateTo(0.0);
                                } else {
                                  widget.controller.currentStep.value = 2;
                                }
                              },
                              child: _buildSelectionCard(
                                isDarkMode: widget.isDarkMode,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Set Price & Capacity",
                                      style: GoogleFonts.manrope(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Obx(
                                            () => _buildMiniTextField(
                                              widget.controller.pricePerPackageText.value.isEmpty
                                                  ? "Price/ kg"
                                                  : "${widget.controller.pricePerPackageText.value} ${widget.controller.selectedCurrency.value}",
                                              widget.isDarkMode,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Obx(
                                            () => _buildMiniTextField(
                                              widget.controller.capacityText.value.isEmpty
                                                  ? "e.g. 10 kg"
                                                  : "${widget.controller.capacityText.value} kg",
                                              widget.isDarkMode,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            GestureDetector(
                              onTap: () {
                                if (_dragOffset > 50.0) {
                                  _animateTo(0.0);
                                } else {
                                  widget.controller.currentStep.value = 3;
                                }
                              },
                              child: _buildSelectionCard(
                                isDarkMode: widget.isDarkMode,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Set Travel Details",
                                      style: GoogleFonts.manrope(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Obx(
                                      () => _buildMiniTextField(
                                        widget.controller.travelDetailsSummary.value.isEmpty
                                            ? "e.g. flight, boat etc."
                                            : widget.controller.travelDetailsSummary.value,
                                        widget.isDarkMode,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSelectionCard({
    required Widget child,
    required bool isDarkMode,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDarkMode ? Colors.white10 : const Color(0xFFF0F0F0),
        ),
      ),
      child: child,
    );
  }

  Widget _buildMiniInput(IconData icon, String text, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: 10.sp,
                color: text == "Departure" || text == "Destination"
                    ? Colors.grey
                    : (isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTextField(String hint, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        hint,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.manrope(
          fontSize: 12.sp,
          color: hint.contains("e.g.") || hint.contains("Price/")
              ? Colors.grey
              : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
