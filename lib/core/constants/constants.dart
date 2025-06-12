import 'dart:ui';

import 'package:sureline/common/data/model/question_model.dart';
import 'package:sureline/common/data/model/review_model.dart';
import 'package:sureline/features/remote_config/data/model/remote_config_model.dart';

class Constants {
  static const String widgetAppGroup = 'group.com.abdulmuiz.sureline.quoteWidget';
  static const String streakReminderNotificationTitle =
      '❄️ Streak will freeze soon!';
  static const String streakReminderNotificationBody =
      'Come back today or your streak freeze will be used and you\'ll lose your streak';
  static const int streakReminderNotificationId = 100;
  static const int minimumLikeGoal = 5;
  static const double defaultVolume = 0.5;
  static const String defaultFontFamily = 'Poppins';
  static const double defaultFontSize = 20;
  static const FontWeight defaultFontWeight = FontWeight.w500;
  static const String flagSmithApiKey = 'nuo5Uhia5pPLRbguT3q6RS';
  static const String defaultBackground = 'assets/images/background2.png';
  static final remoteConfigModel = RemoteConfigModel(
    survey1: [
      QuestionModel(
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
      QuestionModel(
        title: 'How old are you?',
        subTitle: 'Your age is used to personalize your content',
        choices: [
          '13 to 17',
          '18 to 24',
          '25 to 34',
          '35 to 44',
          '45 to 54',
          '55+',
        ],
      ),
      QuestionModel(
        title: 'Which option represents you best, Abdul Muiz?',
        subTitle: 'Some quotes will use your gender or pronouns',
        choices: ['Female', 'Male', 'Others', 'Prefer not to say'],
      ),
      QuestionModel(
        title: 'What\'s your Zodiac sign?',
        subTitle: 'This information will be used to personalize your quotes',
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
      QuestionModel(
        title: 'Are you religious?',
        subTitle:
            'This information will be used to tailor your quotes to your beliefs',
        choices: ['Yes', 'No', 'Spiritual but not religious'],
      ),
      QuestionModel(
        title: 'Which of these best describes your beliefs?',
        subTitle: 'This information will be used to personalize your quotes',
        choices: [
          'Islam',
          'Judaism',
          'Christianity',
          'Hinduism',
          'Buddhism',
          'Other',
        ],
      ),
      QuestionModel(
        title: 'Get quotes that fit your relationship status',
        subTitle: 'Choose the option that describes it the best',
        choices: [
          'It\'s complicated',
          'Single and open to connection',
          'Going through a breakup',
          'Happily single',
          'In a happy relationship',
          'Not interested in this topic',
        ],
      ),
      QuestionModel(
        title: 'How familiar are you with quotes, Abdul Muiz?',
        subTitle: 'Your experience will be adjusted according to your answer',
        choices: [
          'This is new for me',
          'I\'ve used them occasionally',
          'I use them regularly',
        ],
      ),
    ],
    survey3: [
      QuestionModel(
        title: 'How much time will you devote to quotes?',
        subTitle: 'You can change your goal later',
        choices: ['1 minute a day', '3 minutes a day', '10 minutes a day'],
      ),
    ],
    survey4: [
      QuestionModel(
        title: 'How have you been feeling lately, Abdul Muiz?',
        subTitle: 'Choose a mood to personalize your content',
        choices: ['Awesome', 'Good', 'Neutral', 'Bad', 'Terrible', 'Other'],
      ),
      QuestionModel(
        title: 'What\'s making you feel that way?',
        subTitle: 'You can select more than one option',
        choices: ['Health', 'Family', 'Work', 'Friends', 'Love', 'Other'],
      ),
      QuestionModel(
        title: 'What do you want to improve?',
        subTitle:
            'Choose at least one to tailor your content so it resonates with you',
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
      QuestionModel(
        title: 'How can Sureline help you with?',
        subTitle: 'Choose at least one to see quotes based on your goals',
        choices: [
          'Improve my mental health',
          'Develop a positive mindset',
          'Feel more self-confident',
          'Personal growth',
          'Be more present and enjoy life',
          'Learn to love myself',
        ],
      ),
      QuestionModel(
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
      QuestionModel(
        title: 'What do you want to achieve with Sureline?',
        subTitle: 'Choose at least one to see quotes based on your goals',
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
      ReviewModel(
        stars: 5,
        reviewText: 'This app has helped me get through so many tough times',
      ),
      ReviewModel(stars: 4, reviewText: 'Must install for struggling founders'),
      ReviewModel(stars: 5, reviewText: 'life changing'),
    ],
    benefits: [
      'Focus on achieving goals',
      'Shift negative thoughts',
      'Improve mental health',
    ],
  );
}
