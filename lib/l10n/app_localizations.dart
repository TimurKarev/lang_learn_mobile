import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_ru.dart';

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
    Locale('en'),
    Locale('ky'),
    Locale('ru'),
  ];

  /// No description provided for @helloWorld.
  ///
  /// In ru, this message translates to:
  /// **'Привет Мир'**
  String get helloWorld;

  /// No description provided for @kyrgyzLanguage.
  ///
  /// In ru, this message translates to:
  /// **'Кыргыз Тили'**
  String get kyrgyzLanguage;

  /// No description provided for @skip.
  ///
  /// In ru, this message translates to:
  /// **'Пропустить'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In ru, this message translates to:
  /// **'Завершить'**
  String get finish;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Войти в приложение'**
  String get loginTitle;

  /// No description provided for @email.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваш email'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In ru, this message translates to:
  /// **'Забыли пароль?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get login;

  /// No description provided for @dontHaveAccount.
  ///
  /// In ru, this message translates to:
  /// **'Нет аккаунта? '**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get signUp;

  /// No description provided for @or.
  ///
  /// In ru, this message translates to:
  /// **'или'**
  String get or;

  /// No description provided for @byContinuing.
  ///
  /// In ru, this message translates to:
  /// **'Продолжая, я принимаю '**
  String get byContinuing;

  /// No description provided for @termsOfUse.
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get termsOfUse;

  /// No description provided for @and.
  ///
  /// In ru, this message translates to:
  /// **' и '**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In ru, this message translates to:
  /// **'Политику конфиденциальности'**
  String get privacyPolicy;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @practice.
  ///
  /// In ru, this message translates to:
  /// **'Практика'**
  String get practice;

  /// No description provided for @dictionary.
  ///
  /// In ru, this message translates to:
  /// **'Словарь'**
  String get dictionary;

  /// No description provided for @findTeacher.
  ///
  /// In ru, this message translates to:
  /// **'Найти преподавателя'**
  String get findTeacher;

  /// No description provided for @conversationClubs.
  ///
  /// In ru, this message translates to:
  /// **'Разговорные клубы'**
  String get conversationClubs;

  /// No description provided for @learningPath.
  ///
  /// In ru, this message translates to:
  /// **'Ваш путь обучения'**
  String get learningPath;

  /// No description provided for @greeting.
  ///
  /// In ru, this message translates to:
  /// **'Приветствие'**
  String get greeting;

  /// No description provided for @numbers.
  ///
  /// In ru, this message translates to:
  /// **'Цифры'**
  String get numbers;

  /// No description provided for @marketWithGrandma.
  ///
  /// In ru, this message translates to:
  /// **'Поход с бабушкой на базар'**
  String get marketWithGrandma;

  /// No description provided for @themeAnimals.
  ///
  /// In ru, this message translates to:
  /// **'Животные'**
  String get themeAnimals;

  /// No description provided for @themeBasicQualities.
  ///
  /// In ru, this message translates to:
  /// **'Основные качества'**
  String get themeBasicQualities;

  /// No description provided for @themeBiologicalVerbs.
  ///
  /// In ru, this message translates to:
  /// **'Биологические глаголы'**
  String get themeBiologicalVerbs;

  /// No description provided for @themeBodyParts.
  ///
  /// In ru, this message translates to:
  /// **'Части тела'**
  String get themeBodyParts;

  /// No description provided for @themeCity.
  ///
  /// In ru, this message translates to:
  /// **'Город'**
  String get themeCity;

  /// No description provided for @themeClothes.
  ///
  /// In ru, this message translates to:
  /// **'Одежда'**
  String get themeClothes;

  /// No description provided for @themeColors.
  ///
  /// In ru, this message translates to:
  /// **'Цвета'**
  String get themeColors;

  /// No description provided for @themeConsumptionVerbs.
  ///
  /// In ru, this message translates to:
  /// **'Глаголы потребления'**
  String get themeConsumptionVerbs;

  /// No description provided for @themeFood.
  ///
  /// In ru, this message translates to:
  /// **'Еда'**
  String get themeFood;

  /// No description provided for @themeFunctional.
  ///
  /// In ru, this message translates to:
  /// **'Функциональный'**
  String get themeFunctional;

  /// No description provided for @themeFurniture.
  ///
  /// In ru, this message translates to:
  /// **'Мебель'**
  String get themeFurniture;

  /// No description provided for @themeHead.
  ///
  /// In ru, this message translates to:
  /// **'Голова'**
  String get themeHead;

  /// No description provided for @themeHousehold.
  ///
  /// In ru, this message translates to:
  /// **'Домашнее хозяйство'**
  String get themeHousehold;

  /// No description provided for @themeInteractionVerbs.
  ///
  /// In ru, this message translates to:
  /// **'Глаголы взаимодействия'**
  String get themeInteractionVerbs;

  /// No description provided for @themeMindVerbs.
  ///
  /// In ru, this message translates to:
  /// **'Глаголы мышления'**
  String get themeMindVerbs;

  /// No description provided for @themeMovementVerbs.
  ///
  /// In ru, this message translates to:
  /// **'Глаголы движения'**
  String get themeMovementVerbs;

  /// No description provided for @themeNature.
  ///
  /// In ru, this message translates to:
  /// **'Природа'**
  String get themeNature;

  /// No description provided for @themePeople.
  ///
  /// In ru, this message translates to:
  /// **'Люди'**
  String get themePeople;

  /// No description provided for @themeProfessions.
  ///
  /// In ru, this message translates to:
  /// **'Профессии'**
  String get themeProfessions;

  /// No description provided for @themePronouns.
  ///
  /// In ru, this message translates to:
  /// **'Местоимения'**
  String get themePronouns;

  /// No description provided for @themeQuestions.
  ///
  /// In ru, this message translates to:
  /// **'Вопросы'**
  String get themeQuestions;

  /// No description provided for @themeSizes.
  ///
  /// In ru, this message translates to:
  /// **'Размеры'**
  String get themeSizes;

  /// No description provided for @themeTools.
  ///
  /// In ru, this message translates to:
  /// **'Инструменты'**
  String get themeTools;

  /// No description provided for @themeVehicles.
  ///
  /// In ru, this message translates to:
  /// **'Транспорт'**
  String get themeVehicles;

  /// No description provided for @themeUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестно'**
  String get themeUnknown;

  /// No description provided for @memoryChallenge.
  ///
  /// In ru, this message translates to:
  /// **'Память'**
  String get memoryChallenge;

  /// No description provided for @answerHistory.
  ///
  /// In ru, this message translates to:
  /// **'История ответов'**
  String get answerHistory;

  /// No description provided for @vocabulary.
  ///
  /// In ru, this message translates to:
  /// **'Словарь'**
  String get vocabulary;

  /// No description provided for @vocabularyThemes.
  ///
  /// In ru, this message translates to:
  /// **'Темы словаря'**
  String get vocabularyThemes;

  /// No description provided for @flashcardSettings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки карточек'**
  String get flashcardSettings;

  /// No description provided for @wrong.
  ///
  /// In ru, this message translates to:
  /// **'Неправильно'**
  String get wrong;

  /// No description provided for @correct.
  ///
  /// In ru, this message translates to:
  /// **'Правильно'**
  String get correct;

  /// No description provided for @repeat.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get repeat;

  /// No description provided for @right.
  ///
  /// In ru, this message translates to:
  /// **'Верно'**
  String get right;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// No description provided for @addHint.
  ///
  /// In ru, this message translates to:
  /// **'Добавить подсказку'**
  String get addHint;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @apply.
  ///
  /// In ru, this message translates to:
  /// **'Применить'**
  String get apply;

  /// No description provided for @close.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get close;

  /// No description provided for @shuffleCards.
  ///
  /// In ru, this message translates to:
  /// **'Перемешивать карточки'**
  String get shuffleCards;

  /// No description provided for @repeatWrong.
  ///
  /// In ru, this message translates to:
  /// **'Повторять неправильные ответы'**
  String get repeatWrong;

  /// No description provided for @showHint.
  ///
  /// In ru, this message translates to:
  /// **'Показывать подсказку'**
  String get showHint;

  /// No description provided for @questionLanguage.
  ///
  /// In ru, this message translates to:
  /// **'Язык вопроса'**
  String get questionLanguage;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите выйти?'**
  String get logoutConfirmation;

  /// No description provided for @hintText.
  ///
  /// In ru, this message translates to:
  /// **'Текст подсказки'**
  String get hintText;

  /// No description provided for @enterHintText.
  ///
  /// In ru, this message translates to:
  /// **'Введите текст подсказки...'**
  String get enterHintText;

  /// No description provided for @imageOptional.
  ///
  /// In ru, this message translates to:
  /// **'Изображение (необязательно)'**
  String get imageOptional;

  /// No description provided for @clickToSelectImage.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите для выбора изображения'**
  String get clickToSelectImage;

  /// No description provided for @fileSelected.
  ///
  /// In ru, this message translates to:
  /// **'Файл выбран:'**
  String get fileSelected;

  /// No description provided for @failedToLoadImage.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить изображение'**
  String get failedToLoadImage;
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
      <String>['en', 'ky', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ky':
      return AppLocalizationsKy();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
