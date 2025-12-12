class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    
    return null;
  }

  static String? validateTaskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال عنوان المهمة';
    }
    
    if (value.length < 3) {
      return 'العنوان يجب أن يكون 3 أحرف على الأقل';
    }
    
    return null;
  }

  static String? validateHabitName(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال اسم العادة';
    }
    
    if (value.length < 2) {
      return 'اسم العادة يجب أن يكون حرفين على الأقل';
    }
    
    return null;
  }

  static String? validateDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال المدة';
    }
    
    final duration = int.tryParse(value);
    if (duration == null || duration <= 0) {
      return 'يرجى إدخال مدة صحيحة';
    }
    
    return null;
  }
}