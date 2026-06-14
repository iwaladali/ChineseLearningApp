import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' ;
import '../utils/Validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();


  static const Color primaryRed = Color(0xFFDC2626);
  static const Color lightRed = Color(0xFFFDEAEA);
  static const Color darkText = Color(0xFF2F3A3F);
  static const Color greyText = Color(0xFF9CA3AF);
  static const Color borderGrey = Color(0xFFE5E7EB);



  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _emailNotifications = false;


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
  Future<void> _onRegister() async {
    //print('REgister okkkkkkkkkkkkk');
    if (!_formKey.currentState!.validate()) return;

    // 🔥 check password match
    if (_passwordController.text.trim() !=
        _confirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('كلمات المرور غير متطابقة'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final auth = Provider.of<AuthenticatProvider>(context,listen: false,);

    final success = await auth.register(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      displayName: _nameController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:Text("Register Operation Is Successful"),
          backgroundColor: Colors.green,),);
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(auth.errorMessage ?? 'حدث خطأ'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  //TODO : Replace all local handling with AuthProvider
  //TODO: Connect registration to Firebase Authentication
  //TODO: Store user profile data in Firebase after registration
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticatProvider>(context, listen: false,);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: lightRed,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1,
                        color: primaryRed,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'إنشاء حساب جديد',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkText,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'انضم إلينا وابدأ رحلتك في تعلم اللغة الصينية اليوم',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: greyText,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 34),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                         const Align(
                           alignment: Alignment.centerRight,
                           child: Text('الاسم الكامل',
                           style: TextStyle(
                             color: darkText,
                             fontSize: 15,
                             fontWeight: FontWeight.w600
                           ),),
                         ),
                          const SizedBox(height: 8,),
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            textDirection: TextDirection.ltr,
                            decoration:InputDecoration(
                              hintText: 'أدخل الاسم الكامل',
                              hintTextDirection: TextDirection.rtl,
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: borderGrey),
                              ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: const BorderSide(
                                        color: primaryRed,
                                        width: 1.5
                                    )
                                )
                            ),
                            // TODO: Connect full name with AuthProvider.register().
                            // TODO: Send full name to firebase when creating account.
                            validator:(value) => value == null || value.isEmpty ? 'أدخل الاسم' : null,
                          ),
                          const SizedBox(height: 20,),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text('البريد الإلكتروني',
                              style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textDirection: TextDirection.ltr,
                            decoration:InputDecoration(
                                hintText: 'أدخل بريدك الإلكتروني',
                                hintTextDirection: TextDirection.rtl,
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: borderGrey),
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                  color: primaryRed,
                                  width: 1.5
                                )
                              )
                            ),
                            // TODO: Validate email format before registration
                            // TODO: Save email value for AuthProvider.register().
                            // TODO: Send email to firebase authentication.
                            validator: Validators.validateEmail,
                          ),
                          SizedBox(height: 20,),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text('كلمة المرور',
                            style: TextStyle(
                              color: darkText,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'أدخل كلمة المرور',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  }, icon: Icon(_isPasswordVisible?Icons.visibility_outlined:Icons.visibility_off_outlined)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(color: borderGrey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: primaryRed,width: 1.5)
                              ),
                            ),
                            //TODO: Save password value for AuthProvider.register().
                            //TODO: Send password to Firebase Authentication security.
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'أدخل كلمة المرور'
                                : null,
                          ),
                          SizedBox(height: 20,),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text('تأكيد كلمة المرور',
                              style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),),
                          ),
                          SizedBox(height: 8,),
                          TextFormField(
                            controller: _confirmController,
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'أعد إدخال كلمة المرور كلمة المرور',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                    });
                                  }, icon: Icon(_isConfirmPasswordVisible?Icons.visibility_outlined:Icons.visibility_off_outlined)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: borderGrey)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: primaryRed,width: 1.5)
                              ),
                            ),
                            //TODO: Compare confirm password with password before calling AuthProvider.register()
                            validator: (value) =>
                            value == null || value.isEmpty
                                ? 'أكد كلمة المرور'
                                : null,
                          ),
                          const SizedBox(height: 24,),
                          CheckboxListTile(
                              value: _emailNotifications,
                              onChanged: (value){
                                setState(() {
                                  _emailNotifications = value ?? false;
                                });
                              },
                            //TODO: Save notification preference is AuthProvider 
                          activeColor: primaryRed,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Email Notification',
                          style: TextStyle(
                            fontSize: 14,
                            color: darkText
                          ),),
                            subtitle: const Text('Receive weekly updates',
                            style: TextStyle(
                              fontSize: 12,
                              color: greyText
                            ),),
                          ),
                          SizedBox(height: 24,),
                          SizedBox(
                            width: 190,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _onRegister,
                               // onPressed: (){
                                  //if(_formKey.currentState!.validate()){
                                    //TODO: Call AuthProvider.register
                                    //TODO: Create Firebase Account
                                    //TODO: Save notification preference 
                                    //TODO: Navigate to HomeScreen after successful registration
                                 // }
                             //   },
                              child: Text('إنشاء حساب',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(30)
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 28,),
                          const Text('أو تسجيل الدخول بواسطة',
                            style: TextStyle(
                              color: greyText,
                              fontSize: 14
                            ) ,),
                          const SizedBox(height: 18,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                  onPressed: (){
                                    setState(() {
                                      //TODO" Implement Google Sign In with AuthProvider
                                    });
                                  },
                                  icon: const Icon(Icons.g_mobiledata,size: 28,),
                                  label: const Text('Google'),
                                  style:OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                                    side: const BorderSide(color: borderGrey),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                  ) ,),
                              SizedBox(height: 12,),
                              OutlinedButton.icon(
                                onPressed: (){
                                  setState(() {
                                    //TODO" Implement Facebook Sign In with AuthProvider
                                  });
                                },
                                icon: const Icon(Icons.facebook,size: 28,),
                                label: const Text('Facebook'),
                                style:OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                                    side: const BorderSide(color: borderGrey),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                ) ,),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('لدبك حساب بالفعل؟',
                              style: TextStyle(
                                color: greyText
                              ),),
                              TextButton(onPressed: (){
                                Navigator.pushNamed(context,'/');
                                //TODO : Navigate to LoginScreen
                              }, child: const Text('تسجيل الدخول',
                              style: TextStyle(
                                color: primaryRed,
                                fontWeight: FontWeight.bold
                              ),))
                            ],
                          )

                        ],
                      ),
                    ),
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