import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'To Be'**
  String get appTitle;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTask;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String confirmDelete(Object title);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @dontHaveAccountPrefix.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountPrefix;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @goat.
  ///
  /// In en, this message translates to:
  /// **'Our goal is to make you a G.O.A.T.'**
  String get goat;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @taskManager.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get taskManager;

  /// No description provided for @habits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habits;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @aiManager.
  ///
  /// In en, this message translates to:
  /// **'Kyronos'**
  String get aiManager;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @successfulDays.
  ///
  /// In en, this message translates to:
  /// **'Successful Days'**
  String get successfulDays;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total Days'**
  String get totalDays;

  /// No description provided for @consistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get consistency;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get longestStreak;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get enterName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPassword;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @loginSignupButton.
  ///
  /// In en, this message translates to:
  /// **'Login / Sign Up'**
  String get loginSignupButton;

  /// No description provided for @paymentRequiresLogin.
  ///
  /// In en, this message translates to:
  /// **'Payment requires login'**
  String get paymentRequiresLogin;

  /// No description provided for @paymentDescription.
  ///
  /// In en, this message translates to:
  /// **'You can use the app as a guest, but you must login to complete the payment process.'**
  String get paymentDescription;

  /// No description provided for @loadingTasks.
  ///
  /// In en, this message translates to:
  /// **'Loading tasks...'**
  String get loadingTasks;

  /// No description provided for @noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get noTasks;

  /// No description provided for @addTaskHint.
  ///
  /// In en, this message translates to:
  /// **'Use the Add Tasks button to create your first mission'**
  String get addTaskHint;

  /// No description provided for @addTasksButton.
  ///
  /// In en, this message translates to:
  /// **'Add tasks'**
  String get addTasksButton;

  /// No description provided for @noTasksFiltered.
  ///
  /// In en, this message translates to:
  /// **'No tasks match this filter'**
  String get noTasksFiltered;

  /// No description provided for @monthlyAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Monthly Analytics'**
  String get monthlyAnalytics;

  /// No description provided for @taskCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'Task Completion Rate'**
  String get taskCompletionRate;

  /// No description provided for @breakdownTip.
  ///
  /// In en, this message translates to:
  /// **'Try breaking large tasks into smaller ones'**
  String get breakdownTip;

  /// No description provided for @reminderTip.
  ///
  /// In en, this message translates to:
  /// **'Use reminders to avoid forgetting tasks'**
  String get reminderTip;

  /// No description provided for @focusTip.
  ///
  /// In en, this message translates to:
  /// **'Keep focusing on important tasks'**
  String get focusTip;

  /// No description provided for @tasksCompleted.
  ///
  /// In en, this message translates to:
  /// **'Tasks Completed'**
  String get tasksCompleted;

  /// No description provided for @createdDate.
  ///
  /// In en, this message translates to:
  /// **'Created Date'**
  String get createdDate;

  /// No description provided for @addTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new task'**
  String get addTaskTitle;

  /// No description provided for @editTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get editTaskTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get taskTitleLabel;

  /// No description provided for @enterTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a task title'**
  String get enterTaskTitle;

  /// No description provided for @taskDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Task description (optional)'**
  String get taskDescriptionLabel;

  /// No description provided for @noDateSelected.
  ///
  /// In en, this message translates to:
  /// **'No date selected'**
  String get noDateSelected;

  /// No description provided for @noReminderSet.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get noReminderSet;

  /// No description provided for @durationInMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationInMinutes(Object minutes);

  /// No description provided for @genericSaveError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while saving. Please try again.'**
  String get genericSaveError;

  /// No description provided for @noAchievementsYet.
  ///
  /// In en, this message translates to:
  /// **'No achievements recorded yet'**
  String get noAchievementsYet;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsTitle;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsLabel;

  /// No description provided for @estimatedDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDurationLabel;

  /// No description provided for @dueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDateLabel;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get reminderTimeLabel;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @completedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedLabel;

  /// No description provided for @pendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingLabel;

  /// No description provided for @deleteTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTaskTitle;

  /// No description provided for @deleteTaskConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String deleteTaskConfirm(Object title);

  /// No description provided for @taskDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Task deleted successfully'**
  String get taskDeletedSuccess;

  /// No description provided for @subscriptionAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual Subscription'**
  String get subscriptionAnnual;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'Per year'**
  String get perYear;

  /// No description provided for @cardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumberLabel;

  /// No description provided for @cardNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the card number'**
  String get cardNumberRequired;

  /// No description provided for @cardNumberLength.
  ///
  /// In en, this message translates to:
  /// **'Card number must be 16 digits'**
  String get cardNumberLength;

  /// No description provided for @expiryLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryLabel;

  /// No description provided for @expiryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter expiry date'**
  String get expiryRequired;

  /// No description provided for @cvvLabel.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvvLabel;

  /// No description provided for @cvvRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter CVV'**
  String get cvvRequired;

  /// No description provided for @cvvLength.
  ///
  /// In en, this message translates to:
  /// **'CVV must be 3 digits'**
  String get cvvLength;

  /// No description provided for @cardHolderLabel.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardHolderLabel;

  /// No description provided for @payButton.
  ///
  /// In en, this message translates to:
  /// **'Pay \$15'**
  String get payButton;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Processing failed. Please try again.'**
  String get paymentFailed;

  /// No description provided for @userPerformance.
  ///
  /// In en, this message translates to:
  /// **'User Performance'**
  String get userPerformance;

  /// No description provided for @timeRange.
  ///
  /// In en, this message translates to:
  /// **'Time Range'**
  String get timeRange;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @performanceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Performance Metrics'**
  String get performanceMetrics;

  /// No description provided for @improvementTips.
  ///
  /// In en, this message translates to:
  /// **'Improvement Tips'**
  String get improvementTips;

  /// No description provided for @tryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Try breaking large tasks into smaller ones'**
  String get tryBreakdown;

  /// No description provided for @setReminders.
  ///
  /// In en, this message translates to:
  /// **'Use reminders to avoid forgetting tasks'**
  String get setReminders;

  /// No description provided for @stayFocused.
  ///
  /// In en, this message translates to:
  /// **'Keep focusing on important tasks'**
  String get stayFocused;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly summary'**
  String get weeklySummaryTitle;

  /// No description provided for @weeklyTasksCompleted.
  ///
  /// In en, this message translates to:
  /// **'Tasks completed'**
  String get weeklyTasksCompleted;

  /// No description provided for @weeklySuccessRate.
  ///
  /// In en, this message translates to:
  /// **'Success rate'**
  String get weeklySuccessRate;

  /// No description provided for @weeklyAveragePoints.
  ///
  /// In en, this message translates to:
  /// **'Average points'**
  String get weeklyAveragePoints;

  /// No description provided for @averagePointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Average points'**
  String get averagePointsLabel;

  /// No description provided for @successRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Success rate'**
  String get successRateLabel;

  /// No description provided for @currentStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get currentStreakLabel;

  /// No description provided for @longestStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get longestStreakLabel;

  /// No description provided for @consistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get consistencyTitle;

  /// No description provided for @dailyCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'Daily completion rate'**
  String get dailyCompletionRate;

  /// No description provided for @mondayLabel.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mondayLabel;

  /// No description provided for @tuesdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesdayLabel;

  /// No description provided for @wednesdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesdayLabel;

  /// No description provided for @thursdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursdayLabel;

  /// No description provided for @fridayLabel.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fridayLabel;

  /// No description provided for @saturdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturdayLabel;

  /// No description provided for @sundayLabel.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sundayLabel;

  /// A message showing the number of days
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No days} =1{One day} other{{count} days}}'**
  String daysCount(int count);

  /// No description provided for @dailyPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily points'**
  String get dailyPointsLabel;

  /// No description provided for @statusSuccessful.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get statusSuccessful;

  /// No description provided for @statusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs focus'**
  String get statusNeedsAttention;

  /// No description provided for @performanceExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get performanceExcellent;

  /// No description provided for @performanceGood.
  ///
  /// In en, this message translates to:
  /// **'Great job'**
  String get performanceGood;

  /// No description provided for @performanceNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get performanceNeedsAttention;

  /// No description provided for @filterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter:'**
  String get filterLabel;

  /// No description provided for @repetitionLabel.
  ///
  /// In en, this message translates to:
  /// **'Repetition'**
  String get repetitionLabel;

  /// No description provided for @noRepetition.
  ///
  /// In en, this message translates to:
  /// **'No repetition'**
  String get noRepetition;

  /// No description provided for @repeatTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat type'**
  String get repeatTypeLabel;

  /// No description provided for @repeatEveryDays.
  ///
  /// In en, this message translates to:
  /// **'Repeat every {days} days'**
  String repeatEveryDays(String days);

  /// No description provided for @timesPerDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Times per day'**
  String get timesPerDayLabel;

  /// No description provided for @enterNumberOfDays.
  ///
  /// In en, this message translates to:
  /// **'Enter number of days'**
  String get enterNumberOfDays;

  /// No description provided for @enterNumberOfTimes.
  ///
  /// In en, this message translates to:
  /// **'Enter number of times'**
  String get enterNumberOfTimes;

  /// No description provided for @repeatNone.
  ///
  /// In en, this message translates to:
  /// **'Does not repeat'**
  String get repeatNone;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get repeatMonthly;

  /// No description provided for @repeatCustomDays.
  ///
  /// In en, this message translates to:
  /// **'Custom days'**
  String get repeatCustomDays;

  /// No description provided for @repeatMultiplePerDay.
  ///
  /// In en, this message translates to:
  /// **'Multiple times per day'**
  String get repeatMultiplePerDay;

  /// No description provided for @habitNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit name'**
  String get habitNameTitle;

  /// No description provided for @describeGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Describe your goal'**
  String get describeGoalTitle;

  /// No description provided for @specifyDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Specify the required number of days'**
  String get specifyDaysTitle;

  /// No description provided for @numberOfDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of days'**
  String get numberOfDaysLabel;

  /// No description provided for @setDefaultDays.
  ///
  /// In en, this message translates to:
  /// **'Set default days'**
  String get setDefaultDays;

  /// No description provided for @habitDaysRangeWarning.
  ///
  /// In en, this message translates to:
  /// **'Number of days should be between 10 and 1000'**
  String get habitDaysRangeWarning;

  /// No description provided for @habitGoalHint.
  ///
  /// In en, this message translates to:
  /// **'Write about your goal and why it\'s important to you...'**
  String get habitGoalHint;

  /// No description provided for @dailyHabitsCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily habits'**
  String get dailyHabitsCardTitle;

  /// No description provided for @habitsCompletedSummary.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} habits completed'**
  String habitsCompletedSummary(int completed, int total);

  /// No description provided for @noAnalyticsData.
  ///
  /// In en, this message translates to:
  /// **'No analytics data available'**
  String get noAnalyticsData;

  /// No description provided for @monthSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Month summary'**
  String get monthSummaryTitle;

  /// No description provided for @successfulDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Successful days'**
  String get successfulDaysLabel;

  /// No description provided for @monthlyRatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly rating'**
  String get monthlyRatingTitle;

  /// No description provided for @dailyBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily breakdown'**
  String get dailyBreakdownTitle;

  /// No description provided for @pointsAndGrade.
  ///
  /// In en, this message translates to:
  /// **'{points} pts · {grade}'**
  String pointsAndGrade(String points, String grade);

  /// No description provided for @tasksProgressCount.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total}'**
  String tasksProgressCount(int completed, int total);

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterHigh.
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get filterHigh;

  /// No description provided for @filterNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal priority'**
  String get filterNormal;

  /// No description provided for @filterLow.
  ///
  /// In en, this message translates to:
  /// **'Low priority'**
  String get filterLow;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @priorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityNormal;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @filterAllHabits.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAllHabits;

  /// No description provided for @filterActiveHabits.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get filterActiveHabits;

  /// No description provided for @filterCompletedHabits.
  ///
  /// In en, this message translates to:
  /// **'Completed today'**
  String get filterCompletedHabits;

  /// No description provided for @addHabitTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add habit'**
  String get addHabitTooltip;

  /// No description provided for @habitCompletionRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit completion rate'**
  String get habitCompletionRateTitle;

  /// No description provided for @noHabitsTitle.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get noHabitsTitle;

  /// No description provided for @noHabitsDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first habit'**
  String get noHabitsDescription;

  /// No description provided for @deleteHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete habit'**
  String get deleteHabitTitle;

  /// No description provided for @deleteHabitConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteHabitConfirm(Object name);

  /// No description provided for @habitProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of goal'**
  String habitProgressPercent(Object percent);

  /// No description provided for @addHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new habit'**
  String get addHabitTitle;

  /// No description provided for @editHabitTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit habit'**
  String get editHabitTitle;

  /// No description provided for @habitNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Habit name'**
  String get habitNameLabel;

  /// No description provided for @habitNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a habit name'**
  String get habitNameValidation;

  /// No description provided for @habitDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Habit description (optional)'**
  String get habitDescriptionLabel;

  /// No description provided for @targetDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Target days'**
  String get targetDaysLabel;

  /// No description provided for @targetDaysValue.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String targetDaysValue(Object days);

  /// No description provided for @habitCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get habitCategoryLabel;

  /// No description provided for @habitSaveError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while saving the habit'**
  String get habitSaveError;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @categoryRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get categoryRoutine;

  /// No description provided for @habitProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit progress'**
  String get habitProgressTitle;

  /// No description provided for @completionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Completion history'**
  String get completionHistoryTitle;

  /// No description provided for @noCompletionsYet.
  ///
  /// In en, this message translates to:
  /// **'No completions recorded yet'**
  String get noCompletionsYet;

  /// No description provided for @completedEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedEntryTitle;

  /// No description provided for @completedDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days done'**
  String get completedDaysLabel;

  /// No description provided for @totalDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Total days'**
  String get totalDaysLabel;

  /// No description provided for @habitProgressHeading.
  ///
  /// In en, this message translates to:
  /// **'{habit} progress'**
  String habitProgressHeading(Object habit);

  /// No description provided for @streakCounterTitle.
  ///
  /// In en, this message translates to:
  /// **'Streak tracker'**
  String get streakCounterTitle;

  /// No description provided for @progressTowardsGoal.
  ///
  /// In en, this message translates to:
  /// **'Progress toward goal'**
  String get progressTowardsGoal;

  /// No description provided for @streakGoalProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total} days'**
  String streakGoalProgress(Object current, Object total);

  /// No description provided for @remainingToGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining to goal'**
  String get remainingToGoalLabel;

  /// No description provided for @dayUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get dayUnitLabel;

  /// No description provided for @welcomePageTitle1.
  ///
  /// In en, this message translates to:
  /// **'Set Goals'**
  String get welcomePageTitle1;

  /// No description provided for @welcomePageDesc1.
  ///
  /// In en, this message translates to:
  /// **'Create and track your commitments with simple steps.'**
  String get welcomePageDesc1;

  /// No description provided for @welcomePageTitle2.
  ///
  /// In en, this message translates to:
  /// **'Track Progress'**
  String get welcomePageTitle2;

  /// No description provided for @welcomePageDesc2.
  ///
  /// In en, this message translates to:
  /// **'Monitor daily achievements and streaks to stay focused.'**
  String get welcomePageDesc2;

  /// No description provided for @welcomePageTitle3.
  ///
  /// In en, this message translates to:
  /// **'Stay Motivated'**
  String get welcomePageTitle3;

  /// No description provided for @welcomePageDesc3.
  ///
  /// In en, this message translates to:
  /// **'Earn badges, celebrate wins, and keep the momentum.'**
  String get welcomePageDesc3;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissionsTitle;

  /// No description provided for @permissionsDesc.
  ///
  /// In en, this message translates to:
  /// **'We ask for a couple of permissions to help app-block features and localization.'**
  String get permissionsDesc;

  /// No description provided for @permissionsHint.
  ///
  /// In en, this message translates to:
  /// **'Enable permissions when you need location-aware blocking or phone monitoring features.'**
  String get permissionsHint;

  /// No description provided for @allowLocalization.
  ///
  /// In en, this message translates to:
  /// **'Allow Localization'**
  String get allowLocalization;

  /// No description provided for @allowPhoneAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Phone Access'**
  String get allowPhoneAccess;

  /// No description provided for @goalGoat.
  ///
  /// In en, this message translates to:
  /// **'Our goal is make you a GOAT (Greatest Of All Time)'**
  String get goalGoat;

  /// No description provided for @iUnderstandGetStarted.
  ///
  /// In en, this message translates to:
  /// **'I Understand — Get Started'**
  String get iUnderstandGetStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @locationPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Location permission granted'**
  String get locationPermissionGranted;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// No description provided for @phonePermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Phone permission granted'**
  String get phonePermissionGranted;

  /// No description provided for @phonePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Phone permission denied'**
  String get phonePermissionDenied;

  /// No description provided for @requestLocation.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get requestLocation;

  /// No description provided for @requestPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Permission'**
  String get requestPhone;

  /// No description provided for @ourGoal.
  ///
  /// In en, this message translates to:
  /// **'Our goal is make you a GOAT (Greatest Of All Time)'**
  String get ourGoal;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @authGatewayTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock your discipline journey'**
  String get authGatewayTitle;

  /// No description provided for @authGatewaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your progress or continue as a guest for now.'**
  String get authGatewaySubtitle;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @skipHint.
  ///
  /// In en, this message translates to:
  /// **'You can always log in later from settings.'**
  String get skipHint;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retryLabel;

  /// No description provided for @allUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'All users'**
  String get allUsersLabel;

  /// No description provided for @planSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your plan'**
  String get planSelectionTitle;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethodTitle;

  /// No description provided for @paymentMethodVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa / Mastercard'**
  String get paymentMethodVisa;

  /// No description provided for @paymentMethodBinance.
  ///
  /// In en, this message translates to:
  /// **'Binance Pay'**
  String get paymentMethodBinance;

  /// No description provided for @subscriptionAnnualDescription.
  ///
  /// In en, this message translates to:
  /// **'Best for balanced accountability'**
  String get subscriptionAnnualDescription;

  /// No description provided for @extraProgramName.
  ///
  /// In en, this message translates to:
  /// **'Extra Discipline Program'**
  String get extraProgramName;

  /// No description provided for @extraProgramDescription.
  ///
  /// In en, this message translates to:
  /// **'Intense accountability designed for elite focus.'**
  String get extraProgramDescription;

  /// No description provided for @extraProgramPaymentDescription.
  ///
  /// In en, this message translates to:
  /// **'Includes premium check-ins and priority support.'**
  String get extraProgramPaymentDescription;

  /// No description provided for @walletAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet address'**
  String get walletAddressLabel;

  /// No description provided for @walletAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the wallet address'**
  String get walletAddressRequired;

  /// No description provided for @networkLabel.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get networkLabel;

  /// No description provided for @networkRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the network'**
  String get networkRequired;

  /// No description provided for @authenticationCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Authentication code'**
  String get authenticationCodeLabel;

  /// No description provided for @authenticationCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code'**
  String get authenticationCodeRequired;

  /// No description provided for @authCodeSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Authentication code sent'**
  String get authCodeSentMessage;

  /// No description provided for @authCodeResentLabel.
  ///
  /// In en, this message translates to:
  /// **'Code sent again'**
  String get authCodeResentLabel;

  /// No description provided for @sendAuthenticationCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendAuthenticationCode;

  /// No description provided for @featureAdvancedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Advanced analytics'**
  String get featureAdvancedAnalytics;

  /// No description provided for @featureLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard access'**
  String get featureLeaderboard;

  /// No description provided for @featureAiManager.
  ///
  /// In en, this message translates to:
  /// **'AI manager'**
  String get featureAiManager;

  /// No description provided for @featureCustomNotifications.
  ///
  /// In en, this message translates to:
  /// **'Custom notifications'**
  String get featureCustomNotifications;

  /// No description provided for @featureUnlimitedTasks.
  ///
  /// In en, this message translates to:
  /// **'Unlimited tasks'**
  String get featureUnlimitedTasks;

  /// No description provided for @featurePremiumSupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get featurePremiumSupport;

  /// No description provided for @featureAppBlocking.
  ///
  /// In en, this message translates to:
  /// **'App blocking & distraction control'**
  String get featureAppBlocking;

  /// No description provided for @recommendedLabel.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommendedLabel;

  /// No description provided for @joinProgramButton.
  ///
  /// In en, this message translates to:
  /// **'Join program'**
  String get joinProgramButton;

  /// No description provided for @trialActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Trial activated'**
  String get trialActiveLabel;

  /// No description provided for @expiresOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires on'**
  String get expiresOnLabel;

  /// No description provided for @subscriptionActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Subscription active'**
  String get subscriptionActiveLabel;

  /// No description provided for @cancelSubscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get cancelSubscription;

  /// No description provided for @extraProgramActiveMessage.
  ///
  /// In en, this message translates to:
  /// **'Extra Discipline active. Keep pushing!'**
  String get extraProgramActiveMessage;

  /// No description provided for @extraProgramPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete payment to unlock the intensity tools.'**
  String get extraProgramPendingMessage;

  /// No description provided for @standardProgramName.
  ///
  /// In en, this message translates to:
  /// **'Standard discipline'**
  String get standardProgramName;

  /// No description provided for @standardProgramDescription.
  ///
  /// In en, this message translates to:
  /// **'Flexible structure, daily momentum.'**
  String get standardProgramDescription;

  /// No description provided for @manageProgramButton.
  ///
  /// In en, this message translates to:
  /// **'Manage program'**
  String get manageProgramButton;

  /// No description provided for @completePaymentButton.
  ///
  /// In en, this message translates to:
  /// **'Complete payment'**
  String get completePaymentButton;

  /// No description provided for @learnMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMoreLabel;

  /// No description provided for @disciplineProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your discipline path'**
  String get disciplineProgramTitle;

  /// No description provided for @disciplineProgramDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick the intensity that matches your goals.'**
  String get disciplineProgramDescription;

  /// No description provided for @extraProgramBadge.
  ///
  /// In en, this message translates to:
  /// **'Most intense'**
  String get extraProgramBadge;

  /// No description provided for @payAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay {amount}'**
  String payAmount(Object amount);

  /// No description provided for @dailyHabitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Habits'**
  String get dailyHabitsLabel;

  /// No description provided for @onTrack.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get onTrack;

  /// No description provided for @needAttention.
  ///
  /// In en, this message translates to:
  /// **'Need Attention'**
  String get needAttention;

  /// No description provided for @noHabitsYet.
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get noHabitsYet;

  /// No description provided for @createFirstHabit.
  ///
  /// In en, this message translates to:
  /// **'Create your first habit'**
  String get createFirstHabit;

  /// No description provided for @addHabit.
  ///
  /// In en, this message translates to:
  /// **'Add Habit'**
  String get addHabit;

  /// No description provided for @addHabitsButton.
  ///
  /// In en, this message translates to:
  /// **'Add habits'**
  String get addHabitsButton;

  /// No description provided for @addProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Add Profile Picture'**
  String get addProfilePicture;

  /// No description provided for @uploadPhotoSuccess.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully'**
  String get uploadPhotoSuccess;

  /// No description provided for @uploadPhotoFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload photo'**
  String get uploadPhotoFailed;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @imageFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image file not found'**
  String get imageFileNotFound;

  /// No description provided for @uploadingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Uploading photo...'**
  String get uploadingPhoto;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {error}'**
  String failedToPickImage(Object error);

  /// No description provided for @mustBeLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to upload a profile photo'**
  String get mustBeLoggedIn;

  /// No description provided for @imageFileDeleted.
  ///
  /// In en, this message translates to:
  /// **'Image file was deleted before upload'**
  String get imageFileDeleted;

  /// No description provided for @imageFileEmpty.
  ///
  /// In en, this message translates to:
  /// **'Image file is empty'**
  String get imageFileEmpty;

  /// No description provided for @errorUploadingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Error uploading photo: {error}'**
  String errorUploadingPhoto(Object error);

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission Required'**
  String get permissionRequired;

  /// No description provided for @permissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'This app needs {permission} access to function properly.'**
  String permissionNeeded(Object permission);

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera permission is required'**
  String get cameraPermissionRequired;

  /// No description provided for @photoLibraryPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Photo library permission is required'**
  String get photoLibraryPermissionRequired;

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image'**
  String get errorPickingImage;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'App Description'**
  String get appDescription;

  /// No description provided for @welcomeToOurApp.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our app!'**
  String get welcomeToOurApp;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noLeaderboardData.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard data available'**
  String get noLeaderboardData;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String score(Object score);

  /// No description provided for @notYouResetVerification.
  ///
  /// In en, this message translates to:
  /// **'Not you? Reset verification'**
  String get notYouResetVerification;

  /// No description provided for @addNewHabit.
  ///
  /// In en, this message translates to:
  /// **'Add New Habit'**
  String get addNewHabit;

  /// No description provided for @pleaseEnterHabitName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a habit name'**
  String get pleaseEnterHabitName;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @howToUseToBe.
  ///
  /// In en, this message translates to:
  /// **'How to Use To Be'**
  String get howToUseToBe;

  /// No description provided for @awesome.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get awesome;

  /// No description provided for @errorLoadingApp.
  ///
  /// In en, this message translates to:
  /// **'Error loading app'**
  String get errorLoadingApp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordDialogContent;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterEmail;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to {email}'**
  String passwordResetSent(Object email);

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @wesentVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to {phone}'**
  String wesentVerificationCode(Object phone);

  /// No description provided for @codeMustBeSixDigits.
  ///
  /// In en, this message translates to:
  /// **'Code must be 6 digits'**
  String get codeMustBeSixDigits;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @emailOption.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailOption;

  /// No description provided for @phoneOption.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneOption;

  /// No description provided for @tutorialHabitPointsTitle.
  ///
  /// In en, this message translates to:
  /// **'🎯 Habit Points & Progress'**
  String get tutorialHabitPointsTitle;

  /// No description provided for @tutorialHabitPointsDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your daily habit performance! See points earned, completion rate, and grades. Green means excellent, yellow good, red needs attention.'**
  String get tutorialHabitPointsDesc;

  /// No description provided for @tutorialHabitPointsHint.
  ///
  /// In en, this message translates to:
  /// **'Monitor your habit success'**
  String get tutorialHabitPointsHint;

  /// No description provided for @tutorialYourHabitsTitle.
  ///
  /// In en, this message translates to:
  /// **'📝 Your Habits'**
  String get tutorialYourHabitsTitle;

  /// No description provided for @tutorialYourHabitsDesc.
  ///
  /// In en, this message translates to:
  /// **'All your habits appear here. Tap any habit to view detailed progress, or tap the checkmark to mark it complete and earn points!'**
  String get tutorialYourHabitsDesc;

  /// No description provided for @tutorialYourHabitsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to complete or view details'**
  String get tutorialYourHabitsHint;

  /// No description provided for @tutorialCreateHabitsTitle.
  ///
  /// In en, this message translates to:
  /// **'➕ Create New Habits'**
  String get tutorialCreateHabitsTitle;

  /// No description provided for @tutorialCreateHabitsDesc.
  ///
  /// In en, this message translates to:
  /// **'Build positive habits or break bad ones! Choose \"Lock In\" for good habits or \"Kick Habit\" for breaking bad ones.'**
  String get tutorialCreateHabitsDesc;

  /// No description provided for @tutorialCreateHabitsHint.
  ///
  /// In en, this message translates to:
  /// **'Add a new habit to track'**
  String get tutorialCreateHabitsHint;

  /// No description provided for @tutorialWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to To Be'**
  String get tutorialWelcomeTitle;

  /// No description provided for @tutorialWelcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Your companion in building good habits and destroying bad ones. Become the GREATEST OF ALL TIME version of yourself.'**
  String get tutorialWelcomeDesc;

  /// No description provided for @tutorialLockInTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock In New Habits'**
  String get tutorialLockInTitle;

  /// No description provided for @tutorialLockInDesc.
  ///
  /// In en, this message translates to:
  /// **'Create positive habits you want to build. Transform into the GREATEST OF ALL TIME and watch yourself improve every single day.'**
  String get tutorialLockInDesc;

  /// No description provided for @tutorialLockInTip1.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button in the Habits tab'**
  String get tutorialLockInTip1;

  /// No description provided for @tutorialLockInTip2.
  ///
  /// In en, this message translates to:
  /// **'Choose \"Lock In\" to build a good habit'**
  String get tutorialLockInTip2;

  /// No description provided for @tutorialLockInTip3.
  ///
  /// In en, this message translates to:
  /// **'Enter habit name and description'**
  String get tutorialLockInTip3;

  /// No description provided for @tutorialLockInTip4.
  ///
  /// In en, this message translates to:
  /// **'Mark it done each day to build your streak'**
  String get tutorialLockInTip4;

  /// No description provided for @tutorialDestroyTitle.
  ///
  /// In en, this message translates to:
  /// **'Destroy Bad Habits'**
  String get tutorialDestroyTitle;

  /// No description provided for @tutorialDestroyDesc.
  ///
  /// In en, this message translates to:
  /// **'Stop the habits that hold you back. Replace them with positive behaviors and break the cycle.'**
  String get tutorialDestroyDesc;

  /// No description provided for @tutorialDestroyTip1.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button in the Habits tab'**
  String get tutorialDestroyTip1;

  /// No description provided for @tutorialDestroyTip2.
  ///
  /// In en, this message translates to:
  /// **'Choose \"Kick Habit\" to break a bad habit'**
  String get tutorialDestroyTip2;

  /// No description provided for @tutorialDestroyTip3.
  ///
  /// In en, this message translates to:
  /// **'Stay consistent - each day you avoid it counts'**
  String get tutorialDestroyTip3;

  /// No description provided for @tutorialDestroyTip4.
  ///
  /// In en, this message translates to:
  /// **'Build a streak and watch your willpower grow'**
  String get tutorialDestroyTip4;

  /// No description provided for @tutorialProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Track Your Progress'**
  String get tutorialProgressTitle;

  /// No description provided for @tutorialProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'See your daily completion, current streak, and longest streak. Celebrate your wins!'**
  String get tutorialProgressDesc;

  /// No description provided for @tutorialProgressTip1.
  ///
  /// In en, this message translates to:
  /// **'Mark habits complete by tapping the day in the calendar'**
  String get tutorialProgressTip1;

  /// No description provided for @tutorialProgressTip2.
  ///
  /// In en, this message translates to:
  /// **'View your current streak on each habit card'**
  String get tutorialProgressTip2;

  /// No description provided for @tutorialProgressTip3.
  ///
  /// In en, this message translates to:
  /// **'Longest streak shows your personal best'**
  String get tutorialProgressTip3;

  /// No description provided for @tutorialProgressTip4.
  ///
  /// In en, this message translates to:
  /// **'Complete daily challenges to maintain momentum'**
  String get tutorialProgressTip4;

  /// No description provided for @tutorialTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks & Daily Goals'**
  String get tutorialTasksTitle;

  /// No description provided for @tutorialTasksDesc.
  ///
  /// In en, this message translates to:
  /// **'Break down your habits into daily tasks. Organize your day and stay focused.'**
  String get tutorialTasksDesc;

  /// No description provided for @tutorialTasksTip1.
  ///
  /// In en, this message translates to:
  /// **'Create tasks in the Tasks tab'**
  String get tutorialTasksTip1;

  /// No description provided for @tutorialTasksTip2.
  ///
  /// In en, this message translates to:
  /// **'Link tasks to your habits for better tracking'**
  String get tutorialTasksTip2;

  /// No description provided for @tutorialTasksTip3.
  ///
  /// In en, this message translates to:
  /// **'Check off tasks as you complete them'**
  String get tutorialTasksTip3;

  /// No description provided for @tutorialTasksTip4.
  ///
  /// In en, this message translates to:
  /// **'Review your daily productivity'**
  String get tutorialTasksTip4;

  /// No description provided for @tutorialCommunityTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the Community'**
  String get tutorialCommunityTitle;

  /// No description provided for @tutorialCommunityDesc.
  ///
  /// In en, this message translates to:
  /// **'See how others are progressing. Get inspired and inspire others on the leaderboard.'**
  String get tutorialCommunityDesc;

  /// No description provided for @tutorialCommunityTip1.
  ///
  /// In en, this message translates to:
  /// **'Visit the Leaderboard tab'**
  String get tutorialCommunityTip1;

  /// No description provided for @tutorialCommunityTip2.
  ///
  /// In en, this message translates to:
  /// **'See who\'s on their streak'**
  String get tutorialCommunityTip2;

  /// No description provided for @tutorialCommunityTip3.
  ///
  /// In en, this message translates to:
  /// **'Compete with friends and family'**
  String get tutorialCommunityTip3;

  /// No description provided for @tutorialCommunityTip4.
  ///
  /// In en, this message translates to:
  /// **'Earn badges for achievements'**
  String get tutorialCommunityTip4;

  /// No description provided for @tutorialAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics & Insights'**
  String get tutorialAnalyticsTitle;

  /// No description provided for @tutorialAnalyticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Understand your habits with detailed analytics. See what works and what doesn\'t.'**
  String get tutorialAnalyticsDesc;

  /// No description provided for @tutorialAnalyticsTip1.
  ///
  /// In en, this message translates to:
  /// **'View completion rates in Analytics'**
  String get tutorialAnalyticsTip1;

  /// No description provided for @tutorialAnalyticsTip2.
  ///
  /// In en, this message translates to:
  /// **'See your weekly/monthly progress'**
  String get tutorialAnalyticsTip2;

  /// No description provided for @tutorialAnalyticsTip3.
  ///
  /// In en, this message translates to:
  /// **'Identify your best times to complete habits'**
  String get tutorialAnalyticsTip3;

  /// No description provided for @tutorialAnalyticsTip4.
  ///
  /// In en, this message translates to:
  /// **'Get AI-powered recommendations'**
  String get tutorialAnalyticsTip4;

  /// No description provided for @tutorialSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get tutorialSettingsTitle;

  /// No description provided for @tutorialSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience. Set reminders, notifications, and more.'**
  String get tutorialSettingsDesc;

  /// No description provided for @tutorialSettingsTip1.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications for habit reminders'**
  String get tutorialSettingsTip1;

  /// No description provided for @tutorialSettingsTip2.
  ///
  /// In en, this message translates to:
  /// **'Set your preferred language'**
  String get tutorialSettingsTip2;

  /// No description provided for @tutorialSettingsTip3.
  ///
  /// In en, this message translates to:
  /// **'Customize themes (light/dark mode)'**
  String get tutorialSettingsTip3;

  /// No description provided for @tutorialSettingsTip4.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and privacy'**
  String get tutorialSettingsTip4;

  /// No description provided for @welcomeDescriptionMain.
  ///
  /// In en, this message translates to:
  /// **'To Be is the app that helps you master your time, destroy bad habits and lock in new ones to level up your daily life.'**
  String get welcomeDescriptionMain;

  /// No description provided for @featureKeyFeatures.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get featureKeyFeatures;

  /// No description provided for @featureLockIn.
  ///
  /// In en, this message translates to:
  /// **'Lock In New Habits'**
  String get featureLockIn;

  /// No description provided for @featureLockInDesc.
  ///
  /// In en, this message translates to:
  /// **'Build positive habits and track your progress daily.'**
  String get featureLockInDesc;

  /// No description provided for @featureDestroy.
  ///
  /// In en, this message translates to:
  /// **'Destroy Bad Habits'**
  String get featureDestroy;

  /// No description provided for @featureDestroyDesc.
  ///
  /// In en, this message translates to:
  /// **'Break free from habits that hold you back.'**
  String get featureDestroyDesc;

  /// No description provided for @featureLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up Your Life'**
  String get featureLevelUp;

  /// No description provided for @featureLevelUpDesc.
  ///
  /// In en, this message translates to:
  /// **'Watch yourself transform as you complete habits.'**
  String get featureLevelUpDesc;

  /// No description provided for @featureCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join the Community'**
  String get featureCommunity;

  /// No description provided for @featureCommunityDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect with others on the same journey.'**
  String get featureCommunityDesc;

  /// No description provided for @warningMessage.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning: Using our app can turn you into an unstoppable tank'**
  String get warningMessage;

  /// No description provided for @agreeToLockIn.
  ///
  /// In en, this message translates to:
  /// **'Agree to Lock In'**
  String get agreeToLockIn;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @toBeTitle.
  ///
  /// In en, this message translates to:
  /// **'To Be'**
  String get toBeTitle;

  /// No description provided for @lockIn.
  ///
  /// In en, this message translates to:
  /// **'Lock In'**
  String get lockIn;

  /// No description provided for @kickHabit.
  ///
  /// In en, this message translates to:
  /// **'Kick Habit'**
  String get kickHabit;

  /// No description provided for @buildNewGoodHabit.
  ///
  /// In en, this message translates to:
  /// **'Build a new good habit'**
  String get buildNewGoodHabit;

  /// No description provided for @stopBadHabit.
  ///
  /// In en, this message translates to:
  /// **'Stop a bad habit'**
  String get stopBadHabit;

  /// No description provided for @habitName.
  ///
  /// In en, this message translates to:
  /// **'Habit Name'**
  String get habitName;

  /// No description provided for @habitNameExample1.
  ///
  /// In en, this message translates to:
  /// **'Example: Improve skill, Do exercise'**
  String get habitNameExample1;

  /// No description provided for @habitNameExample2.
  ///
  /// In en, this message translates to:
  /// **'Example: Stop smoking, Stop wasting time'**
  String get habitNameExample2;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @describeYourHabit.
  ///
  /// In en, this message translates to:
  /// **'Describe your goal'**
  String get describeYourHabit;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @taskDetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetails;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// No description provided for @taskDescription.
  ///
  /// In en, this message translates to:
  /// **'Task Description'**
  String get taskDescription;

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get taskCompleted;

  /// No description provided for @taskPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get taskPending;

  /// No description provided for @completedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed At'**
  String get completedAt;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @analyticsDescription.
  ///
  /// In en, this message translates to:
  /// **'View your key performance metrics and streaks.'**
  String get analyticsDescription;

  /// No description provided for @pointsChart.
  ///
  /// In en, this message translates to:
  /// **'Points Chart'**
  String get pointsChart;

  /// No description provided for @pointsChartDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your daily points earned over time.'**
  String get pointsChartDescription;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get weeklySummary;

  /// No description provided for @weeklySummaryDescription.
  ///
  /// In en, this message translates to:
  /// **'See your weekly task completion and success rate.'**
  String get weeklySummaryDescription;

  /// No description provided for @habitsScale.
  ///
  /// In en, this message translates to:
  /// **'Habits Scale'**
  String get habitsScale;

  /// No description provided for @habitsScaleDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your daily habits performance'**
  String get habitsScaleDescription;

  /// No description provided for @yourHabits.
  ///
  /// In en, this message translates to:
  /// **'Your Habits'**
  String get yourHabits;

  /// No description provided for @yourHabitsDescription.
  ///
  /// In en, this message translates to:
  /// **'View and manage your habits. Tap to see progress details.'**
  String get yourHabitsDescription;

  /// No description provided for @addHabitDescription.
  ///
  /// In en, this message translates to:
  /// **'Create a new habit to track and build.'**
  String get addHabitDescription;

  /// No description provided for @filterAllDays.
  ///
  /// In en, this message translates to:
  /// **'Show all days'**
  String get filterAllDays;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @addGoal.
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get addGoal;

  /// No description provided for @addGoalsButton.
  ///
  /// In en, this message translates to:
  /// **'Add goals'**
  String get addGoalsButton;

  /// No description provided for @editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editGoal;

  /// No description provided for @goalTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal Title'**
  String get goalTitle;

  /// No description provided for @goalTitleHint.
  ///
  /// In en, this message translates to:
  /// **'What do you want to become?'**
  String get goalTitleHint;

  /// No description provided for @goalTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a goal title'**
  String get goalTitleRequired;

  /// No description provided for @goalDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get goalDescription;

  /// No description provided for @goalDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your goal in detail...'**
  String get goalDescriptionHint;

  /// No description provided for @targetDate.
  ///
  /// In en, this message translates to:
  /// **'Target Date (Optional)'**
  String get targetDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @assignAIAssistant.
  ///
  /// In en, this message translates to:
  /// **'Assign AI Assistant'**
  String get assignAIAssistant;

  /// No description provided for @aiAssistantHint.
  ///
  /// In en, this message translates to:
  /// **'Get help with problem-solving and motivation'**
  String get aiAssistantHint;

  /// No description provided for @deleteGoal.
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get deleteGoal;

  /// No description provided for @deleteGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String deleteGoalConfirm(String title);

  /// No description provided for @noGoals.
  ///
  /// In en, this message translates to:
  /// **'No Goals Yet'**
  String get noGoals;

  /// No description provided for @addGoalHint.
  ///
  /// In en, this message translates to:
  /// **'Set a goal to track your progress and achieve your dreams'**
  String get addGoalHint;

  /// No description provided for @activeGoals.
  ///
  /// In en, this message translates to:
  /// **'Active Goals'**
  String get activeGoals;

  /// No description provided for @completedGoals.
  ///
  /// In en, this message translates to:
  /// **'Completed Goals'**
  String get completedGoals;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @getAdvice.
  ///
  /// In en, this message translates to:
  /// **'Get Advice'**
  String get getAdvice;

  /// No description provided for @progressHistory.
  ///
  /// In en, this message translates to:
  /// **'Progress History'**
  String get progressHistory;

  /// No description provided for @addProgress.
  ///
  /// In en, this message translates to:
  /// **'Add Progress'**
  String get addProgress;

  /// No description provided for @noProgressEntries.
  ///
  /// In en, this message translates to:
  /// **'No progress entries yet'**
  String get noProgressEntries;

  /// No description provided for @progressNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get progressNote;

  /// No description provided for @progressNoteHint.
  ///
  /// In en, this message translates to:
  /// **'What progress did you make?'**
  String get progressNoteHint;

  /// No description provided for @progressChange.
  ///
  /// In en, this message translates to:
  /// **'Progress Change'**
  String get progressChange;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
