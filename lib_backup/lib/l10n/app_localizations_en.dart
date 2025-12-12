// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'To Be';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String confirmDelete(Object title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get settings => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get analytics => 'Analytics';

  @override
  String get notifications => 'Notifications';

  @override
  String get permissions => 'Permissions';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get age => 'Age';

  @override
  String get save => 'Save';

  @override
  String get savedSuccessfully => 'Saved successfully';

  @override
  String get appearance => 'Appearance';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get dontHaveAccountPrefix => 'Don\'t have an account?';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get goat => 'Our goal is to make you a G.O.A.T.';

  @override
  String get welcome => 'Welcome';

  @override
  String get taskManager => 'Tasks';

  @override
  String get habits => 'Habits';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get subscription => 'Subscription';

  @override
  String get aiManager => 'Kyronos';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get shareApp => 'Share App';

  @override
  String get rateApp => 'Rate App';

  @override
  String get successfulDays => 'Successful Days';

  @override
  String get totalDays => 'Total Days';

  @override
  String get consistency => 'Consistency';

  @override
  String get streak => 'Streak';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get longestStreak => 'Longest Streak';

  @override
  String get loginTitle => 'Login';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Name';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get enterPassword => 'Please enter your password';

  @override
  String get enterName => 'Please enter your name';

  @override
  String get confirmPassword => 'Please confirm your password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get loginSignupButton => 'Login / Sign Up';

  @override
  String get paymentRequiresLogin => 'Payment requires login';

  @override
  String get paymentDescription =>
      'You can use the app as a guest, but you must login to complete the payment process.';

  @override
  String get loadingTasks => 'Loading tasks...';

  @override
  String get noTasks => 'No tasks';

  @override
  String get addTaskHint =>
      'Use the Add Tasks button to create your first mission';

  @override
  String get addTasksButton => 'Add tasks';

  @override
  String get noTasksFiltered => 'No tasks match this filter';

  @override
  String get monthlyAnalytics => 'Monthly Analytics';

  @override
  String get taskCompletionRate => 'Task Completion Rate';

  @override
  String get breakdownTip => 'Try breaking large tasks into smaller ones';

  @override
  String get reminderTip => 'Use reminders to avoid forgetting tasks';

  @override
  String get focusTip => 'Keep focusing on important tasks';

  @override
  String get tasksCompleted => 'Tasks Completed';

  @override
  String get createdDate => 'Created Date';

  @override
  String get addTaskTitle => 'Add new task';

  @override
  String get editTaskTitle => 'Edit task';

  @override
  String get taskTitleLabel => 'Task title';

  @override
  String get enterTaskTitle => 'Please enter a task title';

  @override
  String get taskDescriptionLabel => 'Task description (optional)';

  @override
  String get noDateSelected => 'No date selected';

  @override
  String get noReminderSet => 'No reminder';

  @override
  String durationInMinutes(Object minutes) {
    return '$minutes min';
  }

  @override
  String get genericSaveError =>
      'Something went wrong while saving. Please try again.';

  @override
  String get noAchievementsYet => 'No achievements recorded yet';

  @override
  String get detailsTitle => 'Details';

  @override
  String get pointsLabel => 'Points';

  @override
  String get estimatedDurationLabel => 'Estimated Duration';

  @override
  String get dueDateLabel => 'Due Date';

  @override
  String get reminderTimeLabel => 'Reminder Time';

  @override
  String get statusLabel => 'Status';

  @override
  String get completedLabel => 'Completed';

  @override
  String get pendingLabel => 'Pending';

  @override
  String get deleteTaskTitle => 'Delete Task';

  @override
  String deleteTaskConfirm(Object title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get taskDeletedSuccess => 'Task deleted successfully';

  @override
  String get subscriptionAnnual => 'Annual Subscription';

  @override
  String get perYear => 'Per year';

  @override
  String get cardNumberLabel => 'Card Number';

  @override
  String get cardNumberRequired => 'Please enter the card number';

  @override
  String get cardNumberLength => 'Card number must be 16 digits';

  @override
  String get expiryLabel => 'Expiry Date';

  @override
  String get expiryRequired => 'Please enter expiry date';

  @override
  String get cvvLabel => 'CVV';

  @override
  String get cvvRequired => 'Please enter CVV';

  @override
  String get cvvLength => 'CVV must be 3 digits';

  @override
  String get cardHolderLabel => 'Cardholder Name';

  @override
  String get payButton => 'Pay \$15';

  @override
  String get paymentFailed => 'Processing failed. Please try again.';

  @override
  String get userPerformance => 'User Performance';

  @override
  String get timeRange => 'Time Range';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get performanceMetrics => 'Performance Metrics';

  @override
  String get improvementTips => 'Improvement Tips';

  @override
  String get tryBreakdown => 'Try breaking large tasks into smaller ones';

  @override
  String get setReminders => 'Use reminders to avoid forgetting tasks';

  @override
  String get stayFocused => 'Keep focusing on important tasks';

  @override
  String get weeklySummaryTitle => 'Weekly summary';

  @override
  String get weeklyTasksCompleted => 'Tasks completed';

  @override
  String get weeklySuccessRate => 'Success rate';

  @override
  String get weeklyAveragePoints => 'Average points';

  @override
  String get averagePointsLabel => 'Average points';

  @override
  String get successRateLabel => 'Success rate';

  @override
  String get currentStreakLabel => 'Current streak';

  @override
  String get longestStreakLabel => 'Longest streak';

  @override
  String get consistencyTitle => 'Consistency';

  @override
  String get dailyCompletionRate => 'Daily completion rate';

  @override
  String get mondayLabel => 'Mon';

  @override
  String get tuesdayLabel => 'Tue';

  @override
  String get wednesdayLabel => 'Wed';

  @override
  String get thursdayLabel => 'Thu';

  @override
  String get fridayLabel => 'Fri';

  @override
  String get saturdayLabel => 'Sat';

  @override
  String get sundayLabel => 'Sun';

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: 'One day',
      zero: 'No days',
    );
    return '$_temp0';
  }

  @override
  String get dailyPointsLabel => 'Daily points';

  @override
  String get statusSuccessful => 'On track';

  @override
  String get statusNeedsAttention => 'Needs focus';

  @override
  String get performanceExcellent => 'Excellent';

  @override
  String get performanceGood => 'Great job';

  @override
  String get performanceNeedsAttention => 'Needs attention';

  @override
  String get filterLabel => 'Filter:';

  @override
  String get repetitionLabel => 'Repetition';

  @override
  String get noRepetition => 'No repetition';

  @override
  String get repeatTypeLabel => 'Repeat type';

  @override
  String repeatEveryDays(String days) {
    return 'Repeat every $days days';
  }

  @override
  String get timesPerDayLabel => 'Times per day';

  @override
  String get enterNumberOfDays => 'Enter number of days';

  @override
  String get enterNumberOfTimes => 'Enter number of times';

  @override
  String get repeatNone => 'Does not repeat';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatMonthly => 'Every month';

  @override
  String get repeatCustomDays => 'Custom days';

  @override
  String get repeatMultiplePerDay => 'Multiple times per day';

  @override
  String get habitNameTitle => 'Habit name';

  @override
  String get describeGoalTitle => 'Describe your goal';

  @override
  String get specifyDaysTitle => 'Specify the required number of days';

  @override
  String get numberOfDaysLabel => 'Number of days';

  @override
  String get setDefaultDays => 'Set default days';

  @override
  String get habitDaysRangeWarning =>
      'Number of days should be between 10 and 1000';

  @override
  String get habitGoalHint =>
      'Write about your goal and why it\'s important to you...';

  @override
  String get dailyHabitsCardTitle => 'Daily habits';

  @override
  String habitsCompletedSummary(int completed, int total) {
    return '$completed / $total habits completed';
  }

  @override
  String get noAnalyticsData => 'No analytics data available';

  @override
  String get monthSummaryTitle => 'Month summary';

  @override
  String get successfulDaysLabel => 'Successful days';

  @override
  String get monthlyRatingTitle => 'Monthly rating';

  @override
  String get dailyBreakdownTitle => 'Daily breakdown';

  @override
  String pointsAndGrade(String points, String grade) {
    return '$points pts · $grade';
  }

  @override
  String tasksProgressCount(int completed, int total) {
    return '$completed / $total';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterHigh => 'High priority';

  @override
  String get filterNormal => 'Normal priority';

  @override
  String get filterLow => 'Low priority';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityNormal => 'Medium';

  @override
  String get priorityLow => 'Low';

  @override
  String get filterAllHabits => 'All';

  @override
  String get filterActiveHabits => 'Active';

  @override
  String get filterCompletedHabits => 'Completed today';

  @override
  String get addHabitTooltip => 'Add habit';

  @override
  String get habitCompletionRateTitle => 'Habit completion rate';

  @override
  String get noHabitsTitle => 'No habits yet';

  @override
  String get noHabitsDescription => 'Tap + to add your first habit';

  @override
  String get deleteHabitTitle => 'Delete habit';

  @override
  String deleteHabitConfirm(Object name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String habitProgressPercent(Object percent) {
    return '$percent% of goal';
  }

  @override
  String get addHabitTitle => 'Add new habit';

  @override
  String get editHabitTitle => 'Edit habit';

  @override
  String get habitNameLabel => 'Habit name';

  @override
  String get habitNameValidation => 'Please enter a habit name';

  @override
  String get habitDescriptionLabel => 'Habit description (optional)';

  @override
  String get targetDaysLabel => 'Target days';

  @override
  String targetDaysValue(Object days) {
    return '$days days';
  }

  @override
  String get habitCategoryLabel => 'Category';

  @override
  String get habitSaveError => 'Something went wrong while saving the habit';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryRoutine => 'Routine';

  @override
  String get habitProgressTitle => 'Habit progress';

  @override
  String get completionHistoryTitle => 'Completion history';

  @override
  String get noCompletionsYet => 'No completions recorded yet';

  @override
  String get completedEntryTitle => 'Completed';

  @override
  String get completedDaysLabel => 'Days done';

  @override
  String get totalDaysLabel => 'Total days';

  @override
  String habitProgressHeading(Object habit) {
    return '$habit progress';
  }

  @override
  String get streakCounterTitle => 'Streak tracker';

  @override
  String get progressTowardsGoal => 'Progress toward goal';

  @override
  String streakGoalProgress(Object current, Object total) {
    return '$current / $total days';
  }

  @override
  String get remainingToGoalLabel => 'Remaining to goal';

  @override
  String get dayUnitLabel => 'days';

  @override
  String get welcomePageTitle1 => 'Set Goals';

  @override
  String get welcomePageDesc1 =>
      'Create and track your commitments with simple steps.';

  @override
  String get welcomePageTitle2 => 'Track Progress';

  @override
  String get welcomePageDesc2 =>
      'Monitor daily achievements and streaks to stay focused.';

  @override
  String get welcomePageTitle3 => 'Stay Motivated';

  @override
  String get welcomePageDesc3 =>
      'Earn badges, celebrate wins, and keep the momentum.';

  @override
  String get permissionsTitle => 'Permissions';

  @override
  String get permissionsDesc =>
      'We ask for a couple of permissions to help app-block features and localization.';

  @override
  String get permissionsHint =>
      'Enable permissions when you need location-aware blocking or phone monitoring features.';

  @override
  String get allowLocalization => 'Allow Localization';

  @override
  String get allowPhoneAccess => 'Allow Phone Access';

  @override
  String get goalGoat => 'Our goal is make you a GOAT (Greatest Of All Time)';

  @override
  String get iUnderstandGetStarted => 'I Understand — Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get finish => 'Finish';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get locationPermissionGranted => 'Location permission granted';

  @override
  String get locationPermissionDenied => 'Location permission denied';

  @override
  String get phonePermissionGranted => 'Phone permission granted';

  @override
  String get phonePermissionDenied => 'Phone permission denied';

  @override
  String get requestLocation => 'Location Permission';

  @override
  String get requestPhone => 'Phone Permission';

  @override
  String get ourGoal => 'Our goal is make you a GOAT (Greatest Of All Time)';

  @override
  String get skipForNow => 'Skip for Now';

  @override
  String get authGatewayTitle => 'Unlock your discipline journey';

  @override
  String get authGatewaySubtitle =>
      'Sign in to sync your progress or continue as a guest for now.';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get skipHint => 'You can always log in later from settings.';

  @override
  String get retryLabel => 'Try again';

  @override
  String get allUsersLabel => 'All users';

  @override
  String get planSelectionTitle => 'Choose your plan';

  @override
  String get paymentMethodTitle => 'Payment method';

  @override
  String get paymentMethodVisa => 'Visa / Mastercard';

  @override
  String get paymentMethodBinance => 'Binance Pay';

  @override
  String get subscriptionAnnualDescription =>
      'Best for balanced accountability';

  @override
  String get extraProgramName => 'Extra Discipline Program';

  @override
  String get extraProgramDescription =>
      'Intense accountability designed for elite focus.';

  @override
  String get extraProgramPaymentDescription =>
      'Includes premium check-ins and priority support.';

  @override
  String get walletAddressLabel => 'Wallet address';

  @override
  String get walletAddressRequired => 'Please enter the wallet address';

  @override
  String get networkLabel => 'Network';

  @override
  String get networkRequired => 'Please enter the network';

  @override
  String get authenticationCodeLabel => 'Authentication code';

  @override
  String get authenticationCodeRequired => 'Please enter the 6-digit code';

  @override
  String get authCodeSentMessage => 'Authentication code sent';

  @override
  String get authCodeResentLabel => 'Code sent again';

  @override
  String get sendAuthenticationCode => 'Send code';

  @override
  String get featureAdvancedAnalytics => 'Advanced analytics';

  @override
  String get featureLeaderboard => 'Leaderboard access';

  @override
  String get featureAiManager => 'AI manager';

  @override
  String get featureCustomNotifications => 'Custom notifications';

  @override
  String get featureUnlimitedTasks => 'Unlimited tasks';

  @override
  String get featurePremiumSupport => 'Priority support';

  @override
  String get featureAppBlocking => 'App blocking & distraction control';

  @override
  String get recommendedLabel => 'Recommended';

  @override
  String get joinProgramButton => 'Join program';

  @override
  String get trialActiveLabel => 'Trial activated';

  @override
  String get expiresOnLabel => 'Expires on';

  @override
  String get subscriptionActiveLabel => 'Subscription active';

  @override
  String get cancelSubscription => 'Cancel subscription';

  @override
  String get extraProgramActiveMessage =>
      'Extra Discipline active. Keep pushing!';

  @override
  String get extraProgramPendingMessage =>
      'Complete payment to unlock the intensity tools.';

  @override
  String get standardProgramName => 'Standard discipline';

  @override
  String get standardProgramDescription =>
      'Flexible structure, daily momentum.';

  @override
  String get manageProgramButton => 'Manage program';

  @override
  String get completePaymentButton => 'Complete payment';

  @override
  String get learnMoreLabel => 'Learn more';

  @override
  String get disciplineProgramTitle => 'Choose your discipline path';

  @override
  String get disciplineProgramDescription =>
      'Pick the intensity that matches your goals.';

  @override
  String get extraProgramBadge => 'Most intense';

  @override
  String payAmount(Object amount) {
    return 'Pay $amount';
  }

  @override
  String get dailyHabitsLabel => 'Daily Habits';

  @override
  String get onTrack => 'On Track';

  @override
  String get needAttention => 'Need Attention';

  @override
  String get noHabitsYet => 'No habits yet';

  @override
  String get createFirstHabit => 'Create your first habit';

  @override
  String get addHabit => 'Add Habit';

  @override
  String get addHabitsButton => 'Add habits';

  @override
  String get addProfilePicture => 'Add Profile Picture';

  @override
  String get uploadPhotoSuccess => 'Photo uploaded successfully';

  @override
  String get uploadPhotoFailed => 'Failed to upload photo';

  @override
  String get english => 'English';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get imageFileNotFound => 'Image file not found';

  @override
  String get uploadingPhoto => 'Uploading photo...';

  @override
  String failedToPickImage(Object error) {
    return 'Failed to pick image: $error';
  }

  @override
  String get mustBeLoggedIn =>
      'You must be logged in to upload a profile photo';

  @override
  String get imageFileDeleted => 'Image file was deleted before upload';

  @override
  String get imageFileEmpty => 'Image file is empty';

  @override
  String errorUploadingPhoto(Object error) {
    return 'Error uploading photo: $error';
  }

  @override
  String get permissionRequired => 'Permission Required';

  @override
  String permissionNeeded(Object permission) {
    return 'This app needs $permission access to function properly.';
  }

  @override
  String get openSettings => 'Open Settings';

  @override
  String get cameraPermissionRequired => 'Camera permission is required';

  @override
  String get photoLibraryPermissionRequired =>
      'Photo library permission is required';

  @override
  String get errorPickingImage => 'Error picking image';

  @override
  String get takeAPhoto => 'Take a photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get appDescription => 'App Description';

  @override
  String get welcomeToOurApp => 'Welcome to our app!';

  @override
  String get back => 'Back';

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get retry => 'Retry';

  @override
  String get noLeaderboardData => 'No leaderboard data available';

  @override
  String score(Object score) {
    return 'Score: $score';
  }

  @override
  String get notYouResetVerification => 'Not you? Reset verification';

  @override
  String get addNewHabit => 'Add New Habit';

  @override
  String get pleaseEnterHabitName => 'Please enter a habit name';

  @override
  String get challenges => 'Challenges';

  @override
  String get howToUseToBe => 'How to Use To Be';

  @override
  String get awesome => 'Awesome!';

  @override
  String get errorLoadingApp => 'Error loading app';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get forgotPasswordDialogContent =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get pleaseEnterEmail => 'Please enter your email address';

  @override
  String passwordResetSent(Object email) {
    return 'Password reset link sent to $email';
  }

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterPhoneNumber => 'Please enter your phone number';

  @override
  String wesentVerificationCode(Object phone) {
    return 'We sent a verification code to $phone';
  }

  @override
  String get codeMustBeSixDigits => 'Code must be 6 digits';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get emailOption => 'Email';

  @override
  String get phoneOption => 'Phone';

  @override
  String get tutorialHabitPointsTitle => '🎯 Habit Points & Progress';

  @override
  String get tutorialHabitPointsDesc =>
      'Track your daily habit performance! See points earned, completion rate, and grades. Green means excellent, yellow good, red needs attention.';

  @override
  String get tutorialHabitPointsHint => 'Monitor your habit success';

  @override
  String get tutorialYourHabitsTitle => '📝 Your Habits';

  @override
  String get tutorialYourHabitsDesc =>
      'All your habits appear here. Tap any habit to view detailed progress, or tap the checkmark to mark it complete and earn points!';

  @override
  String get tutorialYourHabitsHint => 'Tap to complete or view details';

  @override
  String get tutorialCreateHabitsTitle => '➕ Create New Habits';

  @override
  String get tutorialCreateHabitsDesc =>
      'Build positive habits or break bad ones! Choose \"Lock In\" for good habits or \"Kick Habit\" for breaking bad ones.';

  @override
  String get tutorialCreateHabitsHint => 'Add a new habit to track';

  @override
  String get tutorialWelcomeTitle => 'Welcome to To Be';

  @override
  String get tutorialWelcomeDesc =>
      'Your companion in building good habits and destroying bad ones. Become the GREATEST OF ALL TIME version of yourself.';

  @override
  String get tutorialLockInTitle => 'Lock In New Habits';

  @override
  String get tutorialLockInDesc =>
      'Create positive habits you want to build. Transform into the GREATEST OF ALL TIME and watch yourself improve every single day.';

  @override
  String get tutorialLockInTip1 => 'Tap the + button in the Habits tab';

  @override
  String get tutorialLockInTip2 => 'Choose \"Lock In\" to build a good habit';

  @override
  String get tutorialLockInTip3 => 'Enter habit name and description';

  @override
  String get tutorialLockInTip4 => 'Mark it done each day to build your streak';

  @override
  String get tutorialDestroyTitle => 'Destroy Bad Habits';

  @override
  String get tutorialDestroyDesc =>
      'Stop the habits that hold you back. Replace them with positive behaviors and break the cycle.';

  @override
  String get tutorialDestroyTip1 => 'Tap the + button in the Habits tab';

  @override
  String get tutorialDestroyTip2 =>
      'Choose \"Kick Habit\" to break a bad habit';

  @override
  String get tutorialDestroyTip3 =>
      'Stay consistent - each day you avoid it counts';

  @override
  String get tutorialDestroyTip4 =>
      'Build a streak and watch your willpower grow';

  @override
  String get tutorialProgressTitle => 'Track Your Progress';

  @override
  String get tutorialProgressDesc =>
      'See your daily completion, current streak, and longest streak. Celebrate your wins!';

  @override
  String get tutorialProgressTip1 =>
      'Mark habits complete by tapping the day in the calendar';

  @override
  String get tutorialProgressTip2 =>
      'View your current streak on each habit card';

  @override
  String get tutorialProgressTip3 => 'Longest streak shows your personal best';

  @override
  String get tutorialProgressTip4 =>
      'Complete daily challenges to maintain momentum';

  @override
  String get tutorialTasksTitle => 'Tasks & Daily Goals';

  @override
  String get tutorialTasksDesc =>
      'Break down your habits into daily tasks. Organize your day and stay focused.';

  @override
  String get tutorialTasksTip1 => 'Create tasks in the Tasks tab';

  @override
  String get tutorialTasksTip2 =>
      'Link tasks to your habits for better tracking';

  @override
  String get tutorialTasksTip3 => 'Check off tasks as you complete them';

  @override
  String get tutorialTasksTip4 => 'Review your daily productivity';

  @override
  String get tutorialCommunityTitle => 'Join the Community';

  @override
  String get tutorialCommunityDesc =>
      'See how others are progressing. Get inspired and inspire others on the leaderboard.';

  @override
  String get tutorialCommunityTip1 => 'Visit the Leaderboard tab';

  @override
  String get tutorialCommunityTip2 => 'See who\'s on their streak';

  @override
  String get tutorialCommunityTip3 => 'Compete with friends and family';

  @override
  String get tutorialCommunityTip4 => 'Earn badges for achievements';

  @override
  String get tutorialAnalyticsTitle => 'Analytics & Insights';

  @override
  String get tutorialAnalyticsDesc =>
      'Understand your habits with detailed analytics. See what works and what doesn\'t.';

  @override
  String get tutorialAnalyticsTip1 => 'View completion rates in Analytics';

  @override
  String get tutorialAnalyticsTip2 => 'See your weekly/monthly progress';

  @override
  String get tutorialAnalyticsTip3 =>
      'Identify your best times to complete habits';

  @override
  String get tutorialAnalyticsTip4 => 'Get AI-powered recommendations';

  @override
  String get tutorialSettingsTitle => 'Settings & Preferences';

  @override
  String get tutorialSettingsDesc =>
      'Customize your experience. Set reminders, notifications, and more.';

  @override
  String get tutorialSettingsTip1 => 'Enable notifications for habit reminders';

  @override
  String get tutorialSettingsTip2 => 'Set your preferred language';

  @override
  String get tutorialSettingsTip3 => 'Customize themes (light/dark mode)';

  @override
  String get tutorialSettingsTip4 => 'Manage your account and privacy';

  @override
  String get welcomeDescriptionMain =>
      'To Be is the app that helps you master your time, destroy bad habits and lock in new ones to level up your daily life.';

  @override
  String get featureKeyFeatures => 'Key Features';

  @override
  String get featureLockIn => 'Lock In New Habits';

  @override
  String get featureLockInDesc =>
      'Build positive habits and track your progress daily.';

  @override
  String get featureDestroy => 'Destroy Bad Habits';

  @override
  String get featureDestroyDesc => 'Break free from habits that hold you back.';

  @override
  String get featureLevelUp => 'Level Up Your Life';

  @override
  String get featureLevelUpDesc =>
      'Watch yourself transform as you complete habits.';

  @override
  String get featureCommunity => 'Join the Community';

  @override
  String get featureCommunityDesc => 'Connect with others on the same journey.';

  @override
  String get warningMessage =>
      '⚠️ Warning: Using our app can turn you into an unstoppable tank';

  @override
  String get agreeToLockIn => 'Agree to Lock In';

  @override
  String get previous => 'Previous';

  @override
  String get done => 'Done';

  @override
  String get toBeTitle => 'To Be';

  @override
  String get lockIn => 'Lock In';

  @override
  String get kickHabit => 'Kick Habit';

  @override
  String get buildNewGoodHabit => 'Build a new good habit';

  @override
  String get stopBadHabit => 'Stop a bad habit';

  @override
  String get habitName => 'Habit Name';

  @override
  String get habitNameExample1 => 'Example: Improve skill, Do exercise';

  @override
  String get habitNameExample2 => 'Example: Stop smoking, Stop wasting time';

  @override
  String get description => 'Description';

  @override
  String get describeYourHabit => 'Describe your goal';

  @override
  String get tasks => 'Tasks';

  @override
  String get taskDetails => 'Task Details';

  @override
  String get taskTitle => 'Task Title';

  @override
  String get taskDescription => 'Task Description';

  @override
  String get taskCompleted => 'Completed';

  @override
  String get taskPending => 'Pending';

  @override
  String get completedAt => 'Completed At';

  @override
  String get createdAt => 'Created At';

  @override
  String get analyticsDescription =>
      'View your key performance metrics and streaks.';

  @override
  String get pointsChart => 'Points Chart';

  @override
  String get pointsChartDescription =>
      'Track your daily points earned over time.';

  @override
  String get weeklySummary => 'Weekly Summary';

  @override
  String get weeklySummaryDescription =>
      'See your weekly task completion and success rate.';

  @override
  String get habitsScale => 'Habits Scale';

  @override
  String get habitsScaleDescription => 'Track your daily habits performance';

  @override
  String get yourHabits => 'Your Habits';

  @override
  String get yourHabitsDescription =>
      'View and manage your habits. Tap to see progress details.';

  @override
  String get addHabitDescription => 'Create a new habit to track and build.';

  @override
  String get filterAllDays => 'Show all days';

  @override
  String get goals => 'Goals';

  @override
  String get addGoal => 'Add Goal';

  @override
  String get addGoalsButton => 'Add goals';

  @override
  String get editGoal => 'Edit Goal';

  @override
  String get goalTitle => 'Goal Title';

  @override
  String get goalTitleHint => 'What do you want to become?';

  @override
  String get goalTitleRequired => 'Please enter a goal title';

  @override
  String get goalDescription => 'Description';

  @override
  String get goalDescriptionHint => 'Describe your goal in detail...';

  @override
  String get targetDate => 'Target Date (Optional)';

  @override
  String get selectDate => 'Select Date';

  @override
  String get assignAIAssistant => 'Assign AI Assistant';

  @override
  String get aiAssistantHint => 'Get help with problem-solving and motivation';

  @override
  String get deleteGoal => 'Delete Goal';

  @override
  String deleteGoalConfirm(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get noGoals => 'No Goals Yet';

  @override
  String get addGoalHint =>
      'Set a goal to track your progress and achieve your dreams';

  @override
  String get activeGoals => 'Active Goals';

  @override
  String get completedGoals => 'Completed Goals';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String get getAdvice => 'Get Advice';

  @override
  String get progressHistory => 'Progress History';

  @override
  String get addProgress => 'Add Progress';

  @override
  String get noProgressEntries => 'No progress entries yet';

  @override
  String get progressNote => 'Note';

  @override
  String get progressNoteHint => 'What progress did you make?';

  @override
  String get progressChange => 'Progress Change';

  @override
  String get gotIt => 'Got it';
}
