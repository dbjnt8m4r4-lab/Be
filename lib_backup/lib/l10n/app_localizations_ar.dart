// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'To Be';

  @override
  String get deleteTask => 'حذف المهمة';

  @override
  String confirmDelete(Object title) {
    return 'هل أنت متأكد أنك تريد حذف \"$title\"؟';
  }

  @override
  String get cancel => 'إلغاء';

  @override
  String get edit => 'تعديل';

  @override
  String get delete => 'حذف';

  @override
  String get settings => 'الإعدادات';

  @override
  String get account => 'الحساب';

  @override
  String get theme => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get analytics => 'التحليلات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get permissions => 'الأذونات';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get age => 'العمر';

  @override
  String get save => 'حفظ';

  @override
  String get savedSuccessfully => 'تم الحفظ بنجاح';

  @override
  String get appearance => 'المظهر';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get dontHaveAccountPrefix => 'ليس لديك حساب؟';

  @override
  String get enabled => 'مفعل';

  @override
  String get disabled => 'معطل';

  @override
  String get goat => 'هدفنا هو جعلك الأفضل على الإطلاق';

  @override
  String get welcome => 'مرحباً';

  @override
  String get taskManager => 'المهام';

  @override
  String get habits => 'العادات';

  @override
  String get leaderboard => 'لوحة المتصدرين';

  @override
  String get subscription => 'الاشتراك';

  @override
  String get aiManager => 'مدير الذكاء الاصطناعي';

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get about => 'حول';

  @override
  String get version => 'الإصدار';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get shareApp => 'مشاركة التطبيق';

  @override
  String get rateApp => 'تقييم التطبيق';

  @override
  String get successfulDays => 'الأيام الناجحة';

  @override
  String get totalDays => 'إجمالي الأيام';

  @override
  String get consistency => 'الاتساق';

  @override
  String get streak => 'السلسلة';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get longestStreak => 'أطول سلسلة';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get signupTitle => 'إنشاء حساب';

  @override
  String get emailLabel => 'عنوان البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get enterEmail => 'الرجاء إدخال بريدك الإلكتروني';

  @override
  String get enterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get enterName => 'الرجاء إدخال اسمك';

  @override
  String get confirmPassword => 'الرجاء تأكيد كلمة المرور';

  @override
  String get passwordMismatch => 'كلمات المرور غير متطابقة';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get loginSignupButton => 'تسجيل الدخول / إنشاء حساب';

  @override
  String get paymentRequiresLogin => 'يتطلب الدفع تسجيل الدخول';

  @override
  String get paymentDescription =>
      'يمكنك استخدام التطبيق كضيف، ولكن يجب عليك تسجيل الدخول لإتمام عملية الدفع.';

  @override
  String get loadingTasks => 'جاري تحميل المهام...';

  @override
  String get noTasks => 'لا توجد مهام';

  @override
  String get addTaskHint => 'استخدم زر إضافة المهام لبدء إنشاء قائمتك';

  @override
  String get addTasksButton => 'أضف المهام';

  @override
  String get noTasksFiltered => 'لا توجد مهام تطابق عامل التصفية هذا';

  @override
  String get monthlyAnalytics => 'التحليلات الشهرية';

  @override
  String get taskCompletionRate => 'معدل إتمام المهام';

  @override
  String get breakdownTip => 'حاول تقسيم المهام الكبيرة إلى مهام أصغر';

  @override
  String get reminderTip => 'استخدم التذكيرات لتجنب نسيان المهام';

  @override
  String get focusTip => 'استمر في التركيز على المهام المهمة';

  @override
  String get tasksCompleted => 'المهام المكتملة';

  @override
  String get createdDate => 'تاريخ الإنشاء';

  @override
  String get addTaskTitle => 'إضافة مهمة جديدة';

  @override
  String get editTaskTitle => 'تعديل المهمة';

  @override
  String get taskTitleLabel => 'عنوان المهمة';

  @override
  String get enterTaskTitle => 'الرجاء إدخال عنوان المهمة';

  @override
  String get taskDescriptionLabel => 'وصف المهمة (اختياري)';

  @override
  String get noDateSelected => 'لم يتم اختيار تاريخ';

  @override
  String get noReminderSet => 'لا يوجد تذكير';

  @override
  String durationInMinutes(Object minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get genericSaveError => 'حدث خطأ أثناء الحفظ. يرجى المحاولة مرة أخرى.';

  @override
  String get noAchievementsYet => 'لم يتم تسجيل إنجازات بعد';

  @override
  String get detailsTitle => 'التفاصيل';

  @override
  String get pointsLabel => 'نقطة';

  @override
  String get estimatedDurationLabel => 'المدة المقدرة';

  @override
  String get dueDateLabel => 'تاريخ الاستحقاق';

  @override
  String get reminderTimeLabel => 'وقت التذكير';

  @override
  String get statusLabel => 'الحالة';

  @override
  String get completedLabel => 'مكتمل';

  @override
  String get pendingLabel => 'قيد الانتظار';

  @override
  String get deleteTaskTitle => 'حذف المهمة';

  @override
  String deleteTaskConfirm(Object title) {
    return 'هل أنت متأكد أنك تريد حذف \"$title\"؟';
  }

  @override
  String get taskDeletedSuccess => 'تم حذف المهمة بنجاح';

  @override
  String get subscriptionAnnual => 'الاشتراك السنوي';

  @override
  String get perYear => 'سنوياً';

  @override
  String get cardNumberLabel => 'رقم البطاقة';

  @override
  String get cardNumberRequired => 'الرجاء إدخال رقم البطاقة';

  @override
  String get cardNumberLength => 'يجب أن يكون رقم البطاقة 16 رقماً';

  @override
  String get expiryLabel => 'تاريخ الانتهاء';

  @override
  String get expiryRequired => 'الرجاء إدخال تاريخ الانتهاء';

  @override
  String get cvvLabel => 'CVV';

  @override
  String get cvvRequired => 'الرجاء إدخال CVV';

  @override
  String get cvvLength => 'يجب أن يكون CVV 3 أرقام';

  @override
  String get cardHolderLabel => 'اسم حامل البطاقة';

  @override
  String get payButton => 'دفع 15 دولار';

  @override
  String get paymentFailed => 'فشل المعالجة. يرجى المحاولة مرة أخرى.';

  @override
  String get userPerformance => 'أداء المستخدم';

  @override
  String get timeRange => 'النطاق الزمني';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get monthly => 'شهري';

  @override
  String get yearly => 'سنوي';

  @override
  String get performanceMetrics => 'مقاييس الأداء';

  @override
  String get improvementTips => 'نصائح للتحسين';

  @override
  String get tryBreakdown => 'حاول تقسيم المهام الكبيرة إلى مهام أصغر';

  @override
  String get setReminders => 'استخدم التذكيرات لتجنب نسيان المهام';

  @override
  String get stayFocused => 'استمر في التركيز على المهام المهمة';

  @override
  String get weeklySummaryTitle => 'ملخص أسبوعي';

  @override
  String get weeklyTasksCompleted => 'المهام المكتملة';

  @override
  String get weeklySuccessRate => 'معدل النجاح';

  @override
  String get weeklyAveragePoints => 'متوسط النقاط';

  @override
  String get averagePointsLabel => 'متوسط النقاط';

  @override
  String get successRateLabel => 'نسبة النجاح';

  @override
  String get currentStreakLabel => 'السلسلة الحالية';

  @override
  String get longestStreakLabel => 'أطول سلسلة';

  @override
  String get consistencyTitle => 'الاتساق';

  @override
  String get dailyCompletionRate => 'معدل الإتمام اليومي';

  @override
  String get mondayLabel => 'الاثنين';

  @override
  String get tuesdayLabel => 'الثلاثاء';

  @override
  String get wednesdayLabel => 'الأربعاء';

  @override
  String get thursdayLabel => 'الخميس';

  @override
  String get fridayLabel => 'الجمعة';

  @override
  String get saturdayLabel => 'السبت';

  @override
  String get sundayLabel => 'الأحد';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
      zero: 'لا أيام',
    );
    return '$_temp0';
  }

  @override
  String get dailyPointsLabel => 'النقاط اليومية';

  @override
  String get statusSuccessful => 'على المسار الصحيح';

  @override
  String get statusNeedsAttention => 'يحتاج إلى تركيز';

  @override
  String get performanceExcellent => 'ممتاز';

  @override
  String get performanceGood => 'جيد';

  @override
  String get performanceNeedsAttention => 'يحتاج لاهتمام';

  @override
  String get filterLabel => 'التصفية:';

  @override
  String get repetitionLabel => 'التكرار';

  @override
  String get noRepetition => 'بدون تكرار';

  @override
  String get repeatTypeLabel => 'نوع التكرار';

  @override
  String repeatEveryDays(String days) {
    return 'يتكرر كل $days يوم';
  }

  @override
  String get timesPerDayLabel => 'عدد المرات يومياً';

  @override
  String get enterNumberOfDays => 'أدخل عدد الأيام';

  @override
  String get enterNumberOfTimes => 'أدخل عدد المرات';

  @override
  String get repeatNone => 'لا يتكرر';

  @override
  String get repeatDaily => 'كل يوم';

  @override
  String get repeatWeekly => 'كل أسبوع';

  @override
  String get repeatMonthly => 'كل شهر';

  @override
  String get repeatCustomDays => 'أيام مخصصة';

  @override
  String get repeatMultiplePerDay => 'عدة مرات في اليوم';

  @override
  String get habitNameTitle => 'اسم العادة';

  @override
  String get describeGoalTitle => 'صف هدفك';

  @override
  String get specifyDaysTitle => 'حدد عدد الأيام المطلوبة';

  @override
  String get numberOfDaysLabel => 'عدد الأيام';

  @override
  String get setDefaultDays => 'تعيين العدد الافتراضي';

  @override
  String get habitDaysRangeWarning => 'يجب أن يكون عدد الأيام بين 10 و 1000';

  @override
  String get habitGoalHint => 'اكتب عن هدفك ولماذا هو مهم لك...';

  @override
  String get dailyHabitsCardTitle => 'العادات اليومية';

  @override
  String habitsCompletedSummary(int completed, int total) {
    return '$completed / $total عادات مكتملة';
  }

  @override
  String get noAnalyticsData => 'لا توجد بيانات تحليلات حالياً';

  @override
  String get monthSummaryTitle => 'ملخص الشهر';

  @override
  String get successfulDaysLabel => 'الأيام الناجحة';

  @override
  String get monthlyRatingTitle => 'تقييم الشهر';

  @override
  String get dailyBreakdownTitle => 'التفاصيل اليومية';

  @override
  String pointsAndGrade(String points, String grade) {
    return '$points نقطة · $grade';
  }

  @override
  String tasksProgressCount(int completed, int total) {
    return '$completed / $total';
  }

  @override
  String get filterAll => 'الكل';

  @override
  String get filterHigh => 'أولوية عالية';

  @override
  String get filterNormal => 'أولوية عادية';

  @override
  String get filterLow => 'أولوية منخفضة';

  @override
  String get priorityLabel => 'الأولوية';

  @override
  String get priorityHigh => 'عالي';

  @override
  String get priorityNormal => 'متوسط';

  @override
  String get priorityLow => 'منخفض';

  @override
  String get filterAllHabits => 'الكل';

  @override
  String get filterActiveHabits => 'نشط';

  @override
  String get filterCompletedHabits => 'مكتمل اليوم';

  @override
  String get addHabitTooltip => 'إضافة عادة';

  @override
  String get habitCompletionRateTitle => 'معدل إتمام العادة';

  @override
  String get noHabitsTitle => 'لا توجد عادات بعد';

  @override
  String get noHabitsDescription => 'اضغط + لإضافة عادتك الأولى';

  @override
  String get deleteHabitTitle => 'حذف العادة';

  @override
  String deleteHabitConfirm(Object name) {
    return 'هل أنت متأكد أنك تريد حذف \"$name\"؟';
  }

  @override
  String habitProgressPercent(Object percent) {
    return '$percent% من الهدف';
  }

  @override
  String get addHabitTitle => 'إضافة عادة جديدة';

  @override
  String get editHabitTitle => 'تعديل العادة';

  @override
  String get habitNameLabel => 'اسم العادة';

  @override
  String get habitNameValidation => 'الرجاء إدخال اسم العادة';

  @override
  String get habitDescriptionLabel => 'وصف العادة (اختياري)';

  @override
  String get targetDaysLabel => 'الأيام المستهدفة';

  @override
  String targetDaysValue(Object days) {
    return '$days يوم';
  }

  @override
  String get habitCategoryLabel => 'الفئة';

  @override
  String get habitSaveError => 'حدث خطأ أثناء حفظ العادة';

  @override
  String get categoryHealth => 'صحية';

  @override
  String get categoryEducation => 'تعليمية';

  @override
  String get categoryFinance => 'مالية';

  @override
  String get categorySocial => 'اجتماعية';

  @override
  String get categoryRoutine => 'روتينية';

  @override
  String get habitProgressTitle => 'تقدم العادة';

  @override
  String get completionHistoryTitle => 'سجل الإتمام';

  @override
  String get noCompletionsYet => 'لم يتم تسجيل إتمامات بعد';

  @override
  String get completedEntryTitle => 'مكتمل';

  @override
  String get completedDaysLabel => 'الأيام المنجزة';

  @override
  String get totalDaysLabel => 'إجمالي الأيام';

  @override
  String habitProgressHeading(Object habit) {
    return 'تقدم $habit';
  }

  @override
  String get streakCounterTitle => 'متتبع السلسلة';

  @override
  String get progressTowardsGoal => 'التقدم نحو الهدف';

  @override
  String streakGoalProgress(Object current, Object total) {
    return '$current / $total يوم';
  }

  @override
  String get remainingToGoalLabel => 'المتبقي للهدف';

  @override
  String get dayUnitLabel => 'أيام';

  @override
  String get welcomePageTitle1 => 'تحديد الأهداف';

  @override
  String get welcomePageDesc1 => 'أنشئ وتتبع التزاماتك بخطوات بسيطة.';

  @override
  String get welcomePageTitle2 => 'تتبع التقدم';

  @override
  String get welcomePageDesc2 =>
      'راقب الإنجازات اليومية والسلاسل للبقاء مركزاً.';

  @override
  String get welcomePageTitle3 => 'ابق متحمساً';

  @override
  String get welcomePageDesc3 =>
      'احصل على الشارات واحتفل بالانتصارات وحافظ على الزخم.';

  @override
  String get permissionsTitle => 'الأذونات';

  @override
  String get permissionsDesc =>
      'نطلب بعض الأذونات لمساعدة ميزات حظر التطبيقات والتعريب.';

  @override
  String get permissionsHint =>
      'قم بتمكين الأذونات عندما تحتاج إلى ميزات الحظر القائمة على الموقع أو مراقبة الهاتف.';

  @override
  String get allowLocalization => 'السماح بالتعريب';

  @override
  String get allowPhoneAccess => 'السماح بالوصول إلى الهاتف';

  @override
  String get goalGoat => 'هدفنا هو جعلك الأفضل على الإطلاق';

  @override
  String get iUnderstandGetStarted => 'أفهم - ابدأ';

  @override
  String get skip => 'تخطي';

  @override
  String get finish => 'إنهاء';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get next => 'التالي';

  @override
  String get locationPermissionGranted => 'تم منح إذن الموقع';

  @override
  String get locationPermissionDenied => 'تم رفض إذن الموقع';

  @override
  String get phonePermissionGranted => 'تم منح إذن الهاتف';

  @override
  String get phonePermissionDenied => 'تم رفض إذن الهاتف';

  @override
  String get requestLocation => 'إذن الموقع';

  @override
  String get requestPhone => 'إذن الهاتف';

  @override
  String get ourGoal => 'هدفنا هو جعلك الأفضل على الإطلاق';

  @override
  String get skipForNow => 'تخطي الآن';

  @override
  String get authGatewayTitle => 'افتح رحلة الانضباط الخاصة بك';

  @override
  String get authGatewaySubtitle =>
      'سجل الدخول لمزامنة تقدمك أو استمر كضيف الآن.';

  @override
  String get orContinueWith => 'أو استمر مع';

  @override
  String get or => 'أو';

  @override
  String get continueWithGoogle => 'المتابعة مع Google';

  @override
  String get continueWithApple => 'المتابعة مع Apple';

  @override
  String get skipHint => 'يمكنك دائماً تسجيل الدخول لاحقاً من الإعدادات.';

  @override
  String get retryLabel => 'حاول مرة أخرى';

  @override
  String get allUsersLabel => 'جميع المستخدمين';

  @override
  String get planSelectionTitle => 'اختر خطتك';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get paymentMethodVisa => 'Visa / Mastercard';

  @override
  String get paymentMethodBinance => 'Binance Pay';

  @override
  String get subscriptionAnnualDescription => 'الأفضل للمساءلة المتوازنة';

  @override
  String get extraProgramName => 'برنامج الانضباط الإضافي';

  @override
  String get extraProgramDescription =>
      'المساءلة المكثفة المصممة للتركيز النخبوي.';

  @override
  String get extraProgramPaymentDescription =>
      'يتضمن فحوصات متميزة ودعم ذو أولوية.';

  @override
  String get walletAddressLabel => 'عنوان المحفظة';

  @override
  String get walletAddressRequired => 'الرجاء إدخال عنوان المحفظة';

  @override
  String get networkLabel => 'الشبكة';

  @override
  String get networkRequired => 'الرجاء إدخال الشبكة';

  @override
  String get authenticationCodeLabel => 'رمز المصادقة';

  @override
  String get authenticationCodeRequired =>
      'الرجاء إدخال الرمز المكون من 6 أرقام';

  @override
  String get authCodeSentMessage => 'تم إرسال رمز المصادقة';

  @override
  String get authCodeResentLabel => 'تم إرسال الرمز مرة أخرى';

  @override
  String get sendAuthenticationCode => 'إرسال الرمز';

  @override
  String get featureAdvancedAnalytics => 'تحليلات متقدمة';

  @override
  String get featureLeaderboard => 'الوصول إلى لوحة المتصدرين';

  @override
  String get featureAiManager => 'مدير الذكاء الاصطناعي';

  @override
  String get featureCustomNotifications => 'إشعارات مخصصة';

  @override
  String get featureUnlimitedTasks => 'مهام غير محدودة';

  @override
  String get featurePremiumSupport => 'دعم ذو أولوية';

  @override
  String get featureAppBlocking => 'حظر التطبيقات والتحكم في المشتتات';

  @override
  String get recommendedLabel => 'موصى به';

  @override
  String get joinProgramButton => 'الانضمام إلى البرنامج';

  @override
  String get trialActiveLabel => 'تم تفعيل التجربة';

  @override
  String get expiresOnLabel => 'ينتهي في';

  @override
  String get subscriptionActiveLabel => 'الاشتراك نشط';

  @override
  String get cancelSubscription => 'إلغاء الاشتراك';

  @override
  String get extraProgramActiveMessage =>
      'الانضباط الإضافي نشط. استمر في الدفع!';

  @override
  String get extraProgramPendingMessage => 'أكمل الدفع لفتح أدوات الكثافة.';

  @override
  String get standardProgramName => 'الانضباط القياسي';

  @override
  String get standardProgramDescription => 'هيكل مرن، زخم يومي.';

  @override
  String get manageProgramButton => 'إدارة البرنامج';

  @override
  String get completePaymentButton => 'إتمام الدفع';

  @override
  String get learnMoreLabel => 'اعرف المزيد';

  @override
  String get disciplineProgramTitle => 'اختر مسار الانضباط الخاص بك';

  @override
  String get disciplineProgramDescription => 'اختر الكثافة التي تطابق أهدافك.';

  @override
  String get extraProgramBadge => 'الأكثر كثافة';

  @override
  String payAmount(Object amount) {
    return 'دفع $amount';
  }

  @override
  String get dailyHabitsLabel => 'العادات اليومية';

  @override
  String get onTrack => 'على المسار';

  @override
  String get needAttention => 'يحتاج إلى اهتمام';

  @override
  String get noHabitsYet => 'لا توجد عادات بعد';

  @override
  String get createFirstHabit => 'أنشئ عادتك الأولى';

  @override
  String get addHabit => 'إضافة عادة';

  @override
  String get addHabitsButton => 'أضف العادات';

  @override
  String get addProfilePicture => 'إضافة صورة الملف الشخصي';

  @override
  String get uploadPhotoSuccess => 'تم تحميل الصورة بنجاح';

  @override
  String get uploadPhotoFailed => 'فشل تحميل الصورة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get takePhoto => 'التقط صورة';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get imageFileNotFound => 'لم يتم العثور على ملف الصورة';

  @override
  String get uploadingPhoto => 'جاري تحميل الصورة...';

  @override
  String failedToPickImage(Object error) {
    return 'فشل اختيار الصورة: $error';
  }

  @override
  String get mustBeLoggedIn =>
      'يجب أن تكون مسجل الدخول لتحميل صورة الملف الشخصي';

  @override
  String get imageFileDeleted => 'تم حذف ملف الصورة قبل التحميل';

  @override
  String get imageFileEmpty => 'ملف الصورة فارغ';

  @override
  String errorUploadingPhoto(Object error) {
    return 'خطأ في تحميل الصورة: $error';
  }

  @override
  String get permissionRequired => 'مطلوب إذن';

  @override
  String permissionNeeded(Object permission) {
    return 'يتطلب التطبيق وصولاً إلى $permission للعمل بشكل صحيح.';
  }

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get cameraPermissionRequired => 'مطلوب إذن الكاميرا';

  @override
  String get photoLibraryPermissionRequired => 'مطلوب إذن مكتبة الصور';

  @override
  String get errorPickingImage => 'خطأ في اختيار الصورة';

  @override
  String get takeAPhoto => 'التقط صورة';

  @override
  String get removePhoto => 'حذف الصورة';

  @override
  String get appDescription => 'وصف التطبيق';

  @override
  String get welcomeToOurApp => 'مرحباً بك في تطبيقنا!';

  @override
  String get back => 'رجوع';

  @override
  String error(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get retry => 'حاول مرة أخرى';

  @override
  String get noLeaderboardData => 'لا توجد بيانات لوحة المتصدرين';

  @override
  String score(Object score) {
    return 'نقطة: $score';
  }

  @override
  String get notYouResetVerification => 'لست أنت؟ إعادة تعيين التحقق';

  @override
  String get addNewHabit => 'إضافة عادة جديدة';

  @override
  String get pleaseEnterHabitName => 'يرجى إدخال اسم العادة';

  @override
  String get challenges => 'التحديات';

  @override
  String get howToUseToBe => 'كيفية استخدام To Be';

  @override
  String get awesome => 'رائع!';

  @override
  String get errorLoadingApp => 'خطأ في تحميل التطبيق';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get forgotPasswordDialogContent =>
      'أدخل عنوان بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get pleaseEnterEmail => 'الرجاء إدخال عنوان بريدك الإلكتروني';

  @override
  String passwordResetSent(Object email) {
    return 'تم إرسال رابط إعادة تعيين كلمة المرور إلى $email';
  }

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get pleaseEnterPhoneNumber => 'الرجاء إدخال رقم هاتفك';

  @override
  String wesentVerificationCode(Object phone) {
    return 'أرسلنا رمز التحقق إلى $phone';
  }

  @override
  String get codeMustBeSixDigits => 'يجب أن يكون الرمز 6 أرقام';

  @override
  String get verifyCode => 'التحقق من الرمز';

  @override
  String get emailOption => 'البريد الإلكتروني';

  @override
  String get phoneOption => 'الهاتف';

  @override
  String get tutorialHabitPointsTitle => '🎯 نقاط العادات والتقدم';

  @override
  String get tutorialHabitPointsDesc =>
      'تتبع أدائك اليومي في العادات! شاهد النقاط المكتسبة ومعدل الإتمام والدرجات. الأخضر يعني ممتاز، والأصفر جيد، والأحمر يحتاج إلى تركيز.';

  @override
  String get tutorialHabitPointsHint => 'راقب نجاح عاداتك';

  @override
  String get tutorialYourHabitsTitle => '📝 عاداتك';

  @override
  String get tutorialYourHabitsDesc =>
      'تظهر جميع عاداتك هنا. اضغط على أي عادة لعرض التقدم المفصل، أو اضغط على علامة الاختيار لتحديدها مكتملة وربح النقاط!';

  @override
  String get tutorialYourHabitsHint => 'اضغط لإكمالها أو عرض التفاصيل';

  @override
  String get tutorialCreateHabitsTitle => '➕ إنشاء عادات جديدة';

  @override
  String get tutorialCreateHabitsDesc =>
      'بناء عادات إيجابية أو كسر الأخرى! اختر \"حافظ عليها\" للعادات الجيدة أو \"تخلص منها\" لكسر العادات السيئة.';

  @override
  String get tutorialCreateHabitsHint => 'إضافة عادة جديدة للتتبع';

  @override
  String get tutorialWelcomeTitle => 'مرحباً بك في To Be';

  @override
  String get tutorialWelcomeDesc =>
      'رفيقك في بناء عادات جيدة وتدمير العادات السيئة. اجعل نفسك أعظم نسخة من نفسك.';

  @override
  String get tutorialLockInTitle => 'ركز على العادات الجديدة';

  @override
  String get tutorialLockInDesc =>
      'أنشئ عادات إيجابية تريد بناءها. تحول إلى أعظم نسخة من نفسك واشهد تحسنك كل يوم.';

  @override
  String get tutorialLockInTip1 => 'اضغط على الزر + في علامة التبويب العادات';

  @override
  String get tutorialLockInTip2 => 'اختر \"حافظ عليها\" لبناء عادة جيدة';

  @override
  String get tutorialLockInTip3 => 'أدخل اسم العادة والوصف';

  @override
  String get tutorialLockInTip4 => 'اكملها كل يوم لبناء سلسلتك';

  @override
  String get tutorialDestroyTitle => 'تدمير العادات السيئة';

  @override
  String get tutorialDestroyDesc =>
      'توقف عن العادات التي تمنعك. استبدلها بسلوكيات إيجابية واكسر الحلقة.';

  @override
  String get tutorialDestroyTip1 => 'اضغط على الزر + في علامة التبويب العادات';

  @override
  String get tutorialDestroyTip2 => 'اختر \"تخلص منها\" لكسر عادة سيئة';

  @override
  String get tutorialDestroyTip3 => 'ابقَ متسقاً - كل يوم تتجنبه يعتبر';

  @override
  String get tutorialDestroyTip4 => 'بناء السلسلة واشهد نمو إرادتك';

  @override
  String get tutorialProgressTitle => 'تتبع تقدمك';

  @override
  String get tutorialProgressDesc =>
      'شاهد إتمامك اليومي والسلسلة الحالية وأطول سلسلة. احتفل بانتصاراتك!';

  @override
  String get tutorialProgressTip1 => 'اكمل العادات بالضغط على اليوم في التقويم';

  @override
  String get tutorialProgressTip2 => 'عرض سلسلتك الحالية على كل بطاقة عادة';

  @override
  String get tutorialProgressTip3 => 'أطول سلسلة تظهر أفضل إنجازاتك الشخصية';

  @override
  String get tutorialProgressTip4 => 'أكمل التحديات اليومية للحفاظ على الزخم';

  @override
  String get tutorialTasksTitle => 'المهام والأهداف اليومية';

  @override
  String get tutorialTasksDesc =>
      'قسم عاداتك إلى مهام يومية. نظم يومك وابقَ مركزاً.';

  @override
  String get tutorialTasksTip1 => 'أنشئ مهام في علامة التبويب المهام';

  @override
  String get tutorialTasksTip2 => 'ربط المهام بعاداتك للتتبع الأفضل';

  @override
  String get tutorialTasksTip3 => 'اشطب المهام أثناء إكمالك لها';

  @override
  String get tutorialTasksTip4 => 'راجع إنتاجيتك اليومية';

  @override
  String get tutorialCommunityTitle => 'انضم إلى المجتمع';

  @override
  String get tutorialCommunityDesc =>
      'شاهد كيف يتقدم الآخرون. احصل على الإلهام والهم الآخرين في لوحة المتصدرين.';

  @override
  String get tutorialCommunityTip1 => 'زيارة علامة التبويب لوحة المتصدرين';

  @override
  String get tutorialCommunityTip2 => 'شاهد من على سلسلتهم';

  @override
  String get tutorialCommunityTip3 => 'تنافس مع الأصدقاء والعائلة';

  @override
  String get tutorialCommunityTip4 => 'اكسب شارات للإنجازات';

  @override
  String get tutorialAnalyticsTitle => 'التحليلات والرؤى';

  @override
  String get tutorialAnalyticsDesc =>
      'افهم عاداتك من خلال التحليلات المفصلة. شاهد ما يعمل وما لا يعمل.';

  @override
  String get tutorialAnalyticsTip1 => 'عرض معدلات الإتمام في التحليلات';

  @override
  String get tutorialAnalyticsTip2 => 'شاهد تقدمك الأسبوعي/الشهري';

  @override
  String get tutorialAnalyticsTip3 => 'حدد أفضل الأوقات لإكمال العادات';

  @override
  String get tutorialAnalyticsTip4 =>
      'احصل على توصيات مدعومة بالذكاء الاصطناعي';

  @override
  String get tutorialSettingsTitle => 'الإعدادات والتفضيلات';

  @override
  String get tutorialSettingsDesc =>
      'خصص تجربتك. ضبط التذكيرات والإشعارات والمزيد.';

  @override
  String get tutorialSettingsTip1 => 'تفعيل الإشعارات لتذكيرات العادات';

  @override
  String get tutorialSettingsTip2 => 'اختر لغتك المفضلة';

  @override
  String get tutorialSettingsTip3 => 'تخصيص المواضيع (الوضع الفاتح/الداكن)';

  @override
  String get tutorialSettingsTip4 => 'إدارة حسابك والخصوصية';

  @override
  String get welcomeDescriptionMain =>
      'To Be هو التطبيق الذي يساعدك على إتقان وقتك وتدمير العادات السيئة والحفاظ على العادات الجديدة لترقية حياتك اليومية.';

  @override
  String get featureKeyFeatures => 'الميزات الرئيسية';

  @override
  String get featureLockIn => 'الحفاظ على العادات الجديدة';

  @override
  String get featureLockInDesc => 'بناء عادات إيجابية وتتبع تقدمك يومياً.';

  @override
  String get featureDestroy => 'تدمير العادات السيئة';

  @override
  String get featureDestroyDesc => 'تحرر من العادات التي تمنعك.';

  @override
  String get featureLevelUp => 'حسّن حياتك';

  @override
  String get featureLevelUpDesc => 'شاهد نفسك تتحول مع إكمالك للعادات.';

  @override
  String get featureCommunity => 'انضم إلى المجتمع';

  @override
  String get featureCommunityDesc => 'تواصل مع الآخرين في نفس الرحلة.';

  @override
  String get warningMessage =>
      '⚠️ تحذير: استخدام تطبيقنا يمكن أن يحولك إلى قوة لا توقفها';

  @override
  String get agreeToLockIn => 'وافق على الحفاظ عليها';

  @override
  String get previous => 'السابق';

  @override
  String get done => 'تم';

  @override
  String get toBeTitle => 'To Be';

  @override
  String get lockIn => 'حافظ عليها';

  @override
  String get kickHabit => 'تخلص منها';

  @override
  String get buildNewGoodHabit => 'بناء عادة جديدة جيدة';

  @override
  String get stopBadHabit => 'إيقاف عادة سيئة';

  @override
  String get habitName => 'اسم العادة';

  @override
  String get habitNameExample1 => 'مثال: تحسين المهارة، القيام بالتمرين';

  @override
  String get habitNameExample2 =>
      'مثال: الإقلاع عن التدخين، التوقف عن إهدار الوقت';

  @override
  String get description => 'الوصف';

  @override
  String get describeYourHabit => 'صف هدفك';

  @override
  String get tasks => 'المهام';

  @override
  String get taskDetails => 'تفاصيل المهمة';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get taskDescription => 'وصف المهمة';

  @override
  String get taskCompleted => 'مكتملة';

  @override
  String get taskPending => 'قيد الانتظار';

  @override
  String get completedAt => 'تاريخ الإكمال';

  @override
  String get createdAt => 'تاريخ الإنشاء';

  @override
  String get analyticsDescription => 'عرض مقاييس الأداء الرئيسية والسلاسل';

  @override
  String get pointsChart => 'مخطط النقاط';

  @override
  String get pointsChartDescription =>
      'تتبع النقاط اليومية المكتسبة بمرور الوقت';

  @override
  String get weeklySummary => 'ملخص أسبوعي';

  @override
  String get weeklySummaryDescription =>
      'اطلع على إكمال المهام الأسبوعية ومعدل النجاح';

  @override
  String get habitsScale => 'مقياس العادات';

  @override
  String get habitsScaleDescription => 'تتبع أداء عاداتك اليومية';

  @override
  String get yourHabits => 'عاداتك';

  @override
  String get yourHabitsDescription =>
      'اعرض عاداتك وادِرها. اضغط لمشاهدة تفاصيل التقدم.';

  @override
  String get addHabitDescription => 'أنشئ عادة جديدة لتتبعها وبنائها.';

  @override
  String get filterAllDays => 'عرض جميع الأيام';

  @override
  String get goals => 'الأهداف';

  @override
  String get addGoal => 'إضافة هدف';

  @override
  String get addGoalsButton => 'أضف الأهداف';

  @override
  String get editGoal => 'تعديل الهدف';

  @override
  String get goalTitle => 'عنوان الهدف';

  @override
  String get goalTitleHint => 'ماذا تريد أن تصبح؟';

  @override
  String get goalTitleRequired => 'الرجاء إدخال عنوان الهدف';

  @override
  String get goalDescription => 'الوصف';

  @override
  String get goalDescriptionHint => 'اوصف هدفك بالتفصيل...';

  @override
  String get targetDate => 'تاريخ الهدف (اختياري)';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get assignAIAssistant => 'تعيين مساعد ذكي';

  @override
  String get aiAssistantHint => 'احصل على المساعدة في حل المشاكل والتحفيز';

  @override
  String get deleteGoal => 'حذف الهدف';

  @override
  String deleteGoalConfirm(String title) {
    return 'هل أنت متأكد أنك تريد حذف \"$title\"؟';
  }

  @override
  String get noGoals => 'لا توجد أهداف بعد';

  @override
  String get addGoalHint => 'حدد هدفاً لتتبع تقدمك وتحقيق أحلامك';

  @override
  String get activeGoals => 'الأهداف النشطة';

  @override
  String get completedGoals => 'الأهداف المكتملة';

  @override
  String get aiAssistant => 'المساعد الذكي';

  @override
  String get getAdvice => 'الحصول على نصيحة';

  @override
  String get progressHistory => 'سجل التقدم';

  @override
  String get addProgress => 'إضافة تقدم';

  @override
  String get noProgressEntries => 'لا توجد إدخالات تقدم بعد';

  @override
  String get progressNote => 'ملاحظة';

  @override
  String get progressNoteHint => 'ما التقدم الذي أحرزته؟';

  @override
  String get progressChange => 'تغيير التقدم';

  @override
  String get gotIt => 'فهمت';
}
