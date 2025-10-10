/// Core application constants and configuration values.

import 'dart:ui';

import 'package:sureline/common/data/model/recommendation_algorithm/question_model.dart';
import 'package:sureline/common/data/model/review_model.dart';
import 'package:sureline/features/remote_config/data/model/remote_config_model.dart';
import 'package:sureline/core/constants/secrets.dart';

/// Core constants class containing all application-wide configuration values.
class Constants {
  /// Number of quotes to load per page for pagination.
  static const int quotesPageSize = 20;

  /// Maximum number of heads-up notifications allowed.
  static const int headsUpNotificationLimit = 15;

  /// App group identifier for widget extensions.
  static const String widgetAppGroup = 'group.com.abdulmuiz.sureline.quoteWidget';

  /// Title for streak reminder notifications.
  static const String streakReminderNotificationTitle = '❄️ Streak will freeze soon!';

  /// Body text for streak reminder notifications.
  static const String streakReminderNotificationBody =
      "Come back today or your streak freeze will be used and you'll lose your streak";

  /// Unique identifier for streak reminder notifications.
  static const int streakReminderNotificationId = 100;

  /// Minimum number of likes required to achieve a goal.
  static const int minimumLikeGoal = 5;

  /// Default volume setting for audio features.
  static const double defaultVolume = 0.5;

  /// Default font family for text display.
  static const String defaultFontFamily = 'Poppins';

  /// Default font size for text display.
  static const double defaultFontSize = 20;

  /// Default font weight for text display.
  ///
  /// Used as the base font weight for quote text and other content.
  static const FontWeight defaultFontWeight = FontWeight.w500;

  /// API key for FlagSmith feature flag service.
  ///
  /// Used for remote configuration and feature flag management.
  static const String flagSmithApiKey = Secrets.flagSmithApiKey;

  /// Default background image path.
  ///
  /// Used as the fallback background when no custom background is selected.
  static const String defaultBackground = 'assets/images/background2.png';

  /// Remote configuration model with survey questions and app settings.
  ///
  /// Contains all the survey questions for user onboarding, reviews,
  /// and benefits that are used for personalization and user engagement.
  ///
  /// Survey Structure:
  /// - survey1: How user discovered the app
  /// - survey2: Demographics and personal preferences
  /// - survey3: Time commitment preferences
  /// - survey4: Current mood and improvement areas
  /// - survey5: Personal growth goals
  /// - survey6: Achievement goals
  /// - reviews: User testimonials
  /// - benefits: App benefits list
  static final remoteConfigModel = RemoteConfigModel(
    survey1: [
      const QuestionModel(
        title: 'How did you hear about Sureline?',
        subTitle: 'Select an option to continue',
        choices: [
          'Friend/family',
          'App Store',
          'Instagram',
          'TikTok',
          'Facebook',
          'Web search',
          'Other',
        ],
      ),
    ],
    survey2: [
      const QuestionModel(
        title: 'How old are you?',
        subTitle: 'Your age is used to personalize your content',
        isSkipable: true,
        choices: ['13 to 17', '18 to 24', '25 to 34', '35 to 44', '45 to 54', '55+'],
      ),
      const QuestionModel(
        title: 'Which option represents you best, Abdul Muiz?',
        subTitle: 'Some quotes will use your gender or pronouns',
        choices: ['Female', 'Male', 'Others', 'Prefer not to say'],
      ),
      const QuestionModel(
        title: "What's your Zodiac sign?",
        subTitle: 'This information will be used to personalize your quotes',
        isSkipable: true,
        choices: [
          'Capricorn',
          'Aquarius',
          'Pisces',
          'Aries',
          'Taurus',
          'Gemini',
          'Cancer',
          'Leo',
          'Virgo',
          'Libra',
          'Scorpio',
          'Sagittarius',
        ],
      ),
      const QuestionModel(
        title: 'Are you religious?',
        subTitle: 'This information will be used to tailor your quotes to your beliefs',
        isSkipable: true,
        choices: ['Yes', 'No', 'Spiritual but not religious'],
      ),
      const QuestionModel(
        title: 'Which of these best describes your beliefs?',
        subTitle: 'This information will be used to personalize your quotes',
        isSkipable: true,
        choices: ['Islam', 'Judaism', 'Christianity', 'Hinduism', 'Buddhism', 'Other'],
      ),
      const QuestionModel(
        title: 'Get quotes that fit your relationship status',
        subTitle: 'Choose the option that describes it the best',
        isSkipable: true,
        choices: [
          "It's complicated",
          'Single and open to connection',
          'Going through a breakup',
          'Happily single',
          'In a happy relationship',
          'Not interested in this topic',
        ],
      ),
      const QuestionModel(
        title: 'How familiar are you with quotes, Abdul Muiz?',
        subTitle: 'Your experience will be adjusted according to your answer',
        choices: ['This is new for me', "I've used them occasionally", 'I use them regularly'],
      ),
    ],
    survey3: [
      const QuestionModel(
        title: 'How much time will you devote to quotes?',
        subTitle: 'You can change your goal later',
        choices: ['1 minute a day', '3 minutes a day', '10 minutes a day'],
      ),
    ],
    survey4: [
      const QuestionModel(
        title: 'How have you been feeling lately, Abdul Muiz?',
        subTitle: 'Choose a mood to personalize your content',
        choices: ['Awesome', 'Good', 'Neutral', 'Bad', 'Terrible', 'Other'],
      ),
      const QuestionModel(
        title: "What's making you feel that way?",
        subTitle: 'Choose the best option',
        isStay: true,
        choices: ['Health', 'Family', 'Work', 'Friends', 'Love', 'Other'],
      ),
      const QuestionModel(
        title: 'What do you want to improve?',
        subTitle: 'Choose the best option',
        isStay: true,
        choices: [
          'Loving myself',
          'Stress & anxiety',
          'Being thankful',
          'Personal growth',
          'Loving my body',
          'Positive thinking',
        ],
      ),
    ],
    survey5: [
      const QuestionModel(
        title: 'How can Sureline help you with?',
        subTitle: 'Choose the best option to see quotes based on your goals',
        choices: [
          'Improve my mental health',
          'Develop a positive mindset',
          'Feel more self-confident',
          'Personal growth',
          'Be more present and enjoy life',
          'Learn to love myself',
        ],
      ),
      const QuestionModel(
        title: 'What are you learning to accept about yourself?',
        subTitle: 'Select all the options that resonate',
        choices: [
          'My circumstances',
          'My emotional needs',
          'My past choices',
          'My limiting beliefs',
          'My imperfections',
        ],
      ),
    ],
    survey6: [
      const QuestionModel(
        title: 'What do you want to achieve with Sureline?',
        subTitle: 'Choose the best option to see quotes based on your goals',
        choices: [
          'Be more present and enjoy life',
          'Improve my mental health',
          'Feel more self-confident',
          'Personal growth',
          'Develop a positive mindset',
          'Learn to love myself',
        ],
      ),
    ],
    reviews: [
      ReviewModel(stars: 5, reviewText: 'This app has helped me get through so many tough times'),
      ReviewModel(stars: 4, reviewText: 'Must install for struggling founders'),
      ReviewModel(stars: 5, reviewText: 'life changing'),
    ],
    benefits: ['Focus on achieving goals', 'Shift negative thoughts', 'Improve mental health'],
    benefitsImages: [
      'assets/images/focus.png',
      'assets/images/negative_thoughts.png',
      'assets/images/positive_thoughts.png',
    ],
  );
}
