import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  
  static const Color primaryRed = Color(0xFFDC2626);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color borderGrey = Color(0xFFE5E7EB);

  // TODO: Connect this screen with AuthProvider.
// TODO: Use AuthProvider to manage loading, success, and error states.
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                      color: lightRed,
                      borderRadius: BorderRadius.circular(28)
                  ),
                  child: const Icon(
                    Icons.translate,
                    color: primaryRed,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 22,),
                const Text('تسجيل الدخول',
                  style: TextStyle(
                      color: darkText,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),),
                const SizedBox(height: 6,),
                const Text('مرحباً بعودتك مجدداً',
                  style: TextStyle(
                      color: greyText,
                      fontSize: 14
                  ),),
                const SizedBox(height: 40,),
               
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('البريد الإلكتروني',
                        style: TextStyle(
                          color: darkText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),),
                        const SizedBox(height: 8,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            hintText: 'ادخل بريدك الإلكتروني ',
                            hintTextDirection: TextDirection.rtl,
                            prefixIcon: const Icon(Icons.email_outlined),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: borderGrey
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: borderGrey
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: primaryRed,
                                width: 1.4
                              )
                            ),
                          ),
                          // TODO: Save email value and send it to AuthProvider.
                          // TODO: Improve email validation later.
                          validator: (value){
                            if(value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 18,),
                        Text('كلمة المرور',
                          style: TextStyle(
                            color: darkText,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        TextFormField(
                          obscureText: !_isPasswordVisible,
                          decoration:
                          InputDecoration(
                            hintText: 'أدخل كلمة المرور',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(_isPasswordVisible? Icons.visibility_outlined:Icons.visibility_off_outlined)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: borderGrey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: borderGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: primaryRed,
                                width: 1.4,
                              ),
                            ),
                          ),
                          // TODO: Save password value and send it to AuthProvider.
                          // TODO: Improve password validation later.
                          validator: (value){
                            if(value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            else{
                              return null;
                            }
                          },
                          ),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: (){
                                // TODO: Navigate to ForgotPasswordScreen.
                                // TODO: Later connect reset password with AuthProvider.
                              }, child: const Text('نسيت كلمة المرور؟ ',
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),),
                          ),
                        ),
                        const SizedBox(height: 18,),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)
                                )
                              ),
                              onPressed: (){
                                if(_formKey.currentState!.validate())
                                  {
                                    // TODO: Call AuthProvider.login(email, password).
                                    // TODO: Navigate to HomeScreen after successful login.
                                    // TODO: Show error message if login fails.
                                  }
                              }, child: const Text('تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟ ',
                            style: TextStyle(
                              color: primaryRed,
                              fontWeight: FontWeight.bold,
                            fontSize: 14)
                            ),
                            TextButton(onPressed: (){
                              // TODO: Navigate to RegisterScreen
                            }, child: const Text('إنشاء حساب جديد',
                            style: TextStyle(
                              color: primaryRed,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),))
                          ],
                        )
                      ],
                    ) )
              ],
            ),
          )),
        ));
  }
}



 

