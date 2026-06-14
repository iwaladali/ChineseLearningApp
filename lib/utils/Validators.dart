class Validators {
  // ---------------- EMAIL ----------------
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الإيميل مطلوب';
    }

    final email = value.trim();

    final emailRegex = RegExp(
      r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'صيغة الإيميل غير صحيحة';
    }

    return null;
  }

  // ---------------- PASSWORD ----------------
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    // تحسين إضافي (اختياري قوي)
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'يجب أن تحتوي على حروف وأرقام';
    }

    return null;
  }

  // ---------------- DISPLAY NAME ----------------
  static String? validateDisplayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم مطلوب';
    }

    final name = value.trim();

    if (name.length < 2) {
      return 'الاسم يجب أن يكون حرفين على الأقل';
    }

    if (RegExp(r'[0-9]').hasMatch(name)) {
      return 'الاسم لا يجب أن يحتوي على أرقام';
    }

    return null;
  }

  // ---------------- CONFIRM PASSWORD ----------------
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }

    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }

    return null;
  }

  // ---------------- OPTIONAL: PHONE ----------------
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final phone = value.trim();

    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

    if (!phoneRegex.hasMatch(phone)) {
      return 'رقم الهاتف غير صحيح';
    }

    return null;
  }
}