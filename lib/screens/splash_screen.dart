import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const Color primaryRed = Color(0xFFDC2626);
  static const Color darkRed = Color(0xFFC52222);
  static const Color yellow = Color(0xFFFFD600);

  // TODO: Call AppInitializationProvider
// TODO: Navigate to LoginScreen after initialization

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryRed,
      body: SafeArea(
          child:SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 30,
                        offset: const Offset(0, 14)
                      )
                    ]
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('学',
                      style: TextStyle(
                        color: darkRed,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 4,),
                      SizedBox(
                        width: 35,
                        height: 5,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: yellow,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                            )
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 45,),
                Text('تعلم الصينية',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 14,),
                Text('تعلم الصينية بسهولة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),),
                const SizedBox(height: 140,),
                const SizedBox(
                  width: 35,
                  height: 35,
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 140,),
                const Text('جاري التحميل . . .',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14
                ),)
              ],
            ),
          )),
    );
  }
}
