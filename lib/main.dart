import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sureline/common/domain/use_cases/get_voice_use_case.dart';
import 'package:sureline/common/domain/use_cases/is_onboarding_completed_use_case.dart';
import 'package:sureline/common/domain/use_cases/schedule_up_to_sixty_notifications_use_case.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/secrets.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/initialize_notifications_presets_use_case.dart';
import 'package:sureline/features/onboarding/getting_started/getting_started_screen.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/initialize_recommendation_algorithm.dart';
import 'package:sureline/features/remote_config/domain/use_cases/prepare_remote_config_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/set_theme_use_case.dart';
import 'package:sureline/core/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  await initializeRevenueCat();

  // Check premium status before initializing recommendation algorithm
  final isPremium = await Utils.checkPremiumStatus();
  await locator<InitializeRecommendationAlgorithm>().call(isPremium: isPremium);
  await locator<PrepareRemoteConfigUseCase>().execute();
  final result = await locator<GetVolumeUseCase>().execute();
  result.fold((left) {}, (right) {
    App.volume = right;
  });
  final voice = await locator<GetVoiceUseCase>().execute();
  voice.fold((left) {}, (right) {
    if (right != null) {
      App.voice = VoiceModel.fromEntity(right).toJson();
    }
  });

  await locator<SetThemeUseCase>().execute();

  // await locator<SaveAllQuotesToAppGroupUseCase>().execute();
  _cacheFonts();
  print('here');
  await (await locator<IsOnboardingCompletedUseCase>().execute()).fold((left) {}, (right) async {
    if (right) {
      await locator<InitializeNotificationsPresetsUseCase>().execute();
      await locator<ScheduleUpToSixtyNotificationsUseCase>().execute();
      runApp(const MyApp(isOnboarded: true));
    } else {
      runApp(const MyApp(isOnboarded: false));
    }
  });
}

Future<void> initializeRevenueCat() async {
  await Purchases.setLogLevel(LogLevel.debug);

  final configuration = PurchasesConfiguration(Secrets.revenueCatApiKey);

  await Purchases.configure(configuration);
}

void _cacheFonts() {
  Future(() {
    GoogleFonts.roboto();
    GoogleFonts.openSans();
    GoogleFonts.lato();
    GoogleFonts.poppins();
    GoogleFonts.montserrat();
    GoogleFonts.playfairDisplay();
    GoogleFonts.merriweather();
    GoogleFonts.raleway();
    GoogleFonts.ptSerif();
    GoogleFonts.dancingScript();
    GoogleFonts.lora();
    GoogleFonts.nunito();
    GoogleFonts.oswald();
    GoogleFonts.quicksand();
    GoogleFonts.pacifico();
    GoogleFonts.ubuntu();
    GoogleFonts.bebasNeue();
    GoogleFonts.libreBaskerville();
    GoogleFonts.caveat();
    GoogleFonts.josefinSans();
    GoogleFonts.sourceSerifPro();
    GoogleFonts.dmSerifDisplay();
    GoogleFonts.workSans();
    GoogleFonts.titilliumWeb();
    GoogleFonts.abrilFatface();
    GoogleFonts.mulish();
    GoogleFonts.zillaSlab();
    GoogleFonts.comfortaa();
    GoogleFonts.arvo();
    GoogleFonts.amaticSc();
    GoogleFonts.firaSans();
    GoogleFonts.indieFlower();
    GoogleFonts.tinos();
    GoogleFonts.notoSerif();
    GoogleFonts.ibmPlexSerif();
    GoogleFonts.anton();
    GoogleFonts.greatVibes();
    GoogleFonts.hind();
    GoogleFonts.rubik();
    GoogleFonts.inconsolata();
    GoogleFonts.cormorantGaramond();
    GoogleFonts.exo2();
    GoogleFonts.manrope();
    GoogleFonts.ptSans();
    GoogleFonts.signika();
    GoogleFonts.crimsonPro();
    GoogleFonts.questrial();
    GoogleFonts.cardo();
    GoogleFonts.yanoneKaffeesatz();
    GoogleFonts.mavenPro();
    GoogleFonts.bitter();
    GoogleFonts.catamaran();
    GoogleFonts.cabin();
    GoogleFonts.nanumGothic();
    GoogleFonts.karla();
    GoogleFonts.asap();
    GoogleFonts.inter();
    GoogleFonts.assistant();
    GoogleFonts.domine();
    GoogleFonts.tangerine();
    GoogleFonts.vollkorn();
    GoogleFonts.baloo2();
    GoogleFonts.noticiaText();
    GoogleFonts.righteous();
    GoogleFonts.notoSans();
    GoogleFonts.barlow();
    GoogleFonts.archivo();
    GoogleFonts.overpass();
    GoogleFonts.elMessiri();
    GoogleFonts.cairo();
    GoogleFonts.chivo();
    GoogleFonts.frankRuhlLibre();
    GoogleFonts.candal();
    GoogleFonts.oxygen();
    GoogleFonts.dmSans();
    GoogleFonts.tenorSans();
    GoogleFonts.heebo();
    GoogleFonts.varelaRound();
    GoogleFonts.lexend();
    GoogleFonts.sora();
    GoogleFonts.jost();
    GoogleFonts.alfaSlabOne();
    GoogleFonts.parisienne();
    GoogleFonts.satisfy();
    GoogleFonts.play();
    GoogleFonts.cinzel();
    GoogleFonts.orbitron();
    GoogleFonts.leagueSpartan();
    GoogleFonts.alegreya();
    GoogleFonts.notoSerifDisplay();
    GoogleFonts.syne();
    GoogleFonts.breeSerif();
    GoogleFonts.philosopher();
    GoogleFonts.redHatDisplay();
    GoogleFonts.glory();
    GoogleFonts.yesevaOne();
    GoogleFonts.martel();
    GoogleFonts.trirong();
    GoogleFonts.scopeOne();
    GoogleFonts.arapey();
  });
}

class MyApp extends StatelessWidget {
  final bool isOnboarded;

  const MyApp({super.key, required this.isOnboarded});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        // fontFamily: Constants.defaultFontFamily,
      ),
      home: (isOnboarded) ? HomeScreen() : HomeScreen(),
    );
  }
}
