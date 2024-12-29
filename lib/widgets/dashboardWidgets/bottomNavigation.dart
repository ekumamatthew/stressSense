import 'package:flutter/material.dart';
import 'package:neuroTrack/theme/colors.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: AppColor.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 87,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Stack(children: [
                                    Image.asset(
                                        "assets/images/dashboardImages/home.png",
                                        height: 24,
                                        width: 24)
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Home',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0E47D8),
                              fontSize: 8,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Stack(children: [
                                    Image.asset(
                                        "assets/images/dashboardImages/status-up.png",
                                        height: 24,
                                        width: 24)
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 8,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Container(
                  width: 65,
                  height: 65,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 28),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E47D8),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 6,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0x110E47D8),
                      ),
                      borderRadius: BorderRadius.circular(400),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Stack(children: [
                                      Image.asset(
                                          "assets/images/dashboardImages/sound.png",
                                          height: 24,
                                          width: 24)
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Stack(children: [
                                    Image.asset(
                                        "assets/images/dashboardImages/frame.png",
                                        height: 24,
                                        width: 24)
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Insurance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 8,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Stack(children: [
                                    Image.asset(
                                        "assets/images/dashboardImages/profile-circle.png",
                                        height: 24,
                                        width: 24)
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 8,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                              letterSpacing: 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
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
