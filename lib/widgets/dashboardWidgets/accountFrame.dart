import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: const ShapeDecoration(
        color: Color(0xFF0E47D8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 40,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      // decoration: ShapeDecoration(
                      //   // image: const DecorationImage(
                      //   //   image:
                      //   //       NetworkImage("https://via.placeholder.com/48x48"),
                      //   //   fit: BoxFit.fill,
                      //   // ),

                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(200),
                      //   ),
                      // ),

                      child: Image.asset(
                        'assets/images/logoImages/profile.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Howdy,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                            letterSpacing: 0.02,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                            letterSpacing: -0.16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 28),
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.10000000149011612),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(400),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Current Balance',
                  style: TextStyle(
                    color: Color(0xFFCEDAF7),
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    height: 0.12,
                    letterSpacing: 0.02,
                  ),
                ),
                SizedBox(height: 25),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '₦250,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          height: 0.04,
                          letterSpacing: -0.96,
                        ),
                      ),
                      TextSpan(
                        text: '.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          height: 0.04,
                          letterSpacing: -1.12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Today, 20th June, 2023',
                  style: TextStyle(
                    color: Color(0xFFCEDAF7),
                    fontSize: 10,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w400,
                    height: 0.14,
                    letterSpacing: 0.02,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
