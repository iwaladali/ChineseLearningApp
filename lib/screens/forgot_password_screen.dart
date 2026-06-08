import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const Color primaryRed = Color(0xFFDC2626);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color borderGrey = Color(0xFFE5E7EB);
  static const Color yellow = Color(0xFFFFD600);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TODO: Add email controller if AuthProvider needs the email value directly.
  // TODO: Connect this screen with AuthProvider.resetPassword().
  // TODO: Show loading, success, and error states from AuthProvider.
  // TODO: After success, show confirmation message or navigate back to LoginScreen.

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          // TODO: Replace with named route if needed.
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: darkText,
                          size: 22,
                        ),
                      ),
                    ),

                    const SizedBox(height: 105),

                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: lightRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset,
                        color: primaryRed,
                        size: 52,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'استعادة كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: darkText,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'أدخل بريدك الإلكتروني وسنرسل لك رابط استعادة كلمة المرور',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: greyText,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 95),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'البريد الإلكتروني',
                            style: TextStyle(
                              color: darkText,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              hintText: 'أدخل بريدك الإلكتروني',
                              hintTextDirection: TextDirection.rtl,
                              prefixIcon: const Icon(Icons.email_outlined),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: borderGrey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: primaryRed,
                                  width: 1.5,
                                ),
                              ),
                            ),

                            // TODO: Save email value for AuthProvider.resetPassword().
                            // TODO: Validate email format before sending reset link.
                            // TODO: Send email to Firebase Authentication reset password flow.

                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'يرجى إدخال البريد الإلكتروني';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 28),

                          Center(
                            child: Text(
                              '[error]',
                              style: TextStyle(
                                color: primaryRed,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          // TODO: Replace static [error] text with AuthProvider error message.
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    SizedBox(
                      width: 170,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRed,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Call AuthProvider.resetPassword(email).
                            // TODO: Show loading state while sending reset link.
                            // TODO: Show success message after email is sent.
                          }
                        },
                        child: const Text(
                          'إرسال الرابط',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 90,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'تذكرت كلمة المرور؟',
                          style: TextStyle(
                            color: greyText,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to LoginScreen using named route.
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: primaryRed,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 70),

                    Container(
                      width: 68,
                      height: 5,
                      decoration: BoxDecoration(
                        color: yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}