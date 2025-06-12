import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/common/domain/use_cases/get_voice_use_case.dart';
import 'package:sureline/common/domain/use_cases/is_onboarding_completed_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/schedule_up_to_sixty_notifications_use_case.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/general_settings/voice/data/model/voice_model.dart';
import 'package:sureline/features/home/domain/use_cases/save_all_quotes_to_app_group_use_case.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/get_notification_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/initialize_notifications_presets_use_case.dart';
import 'package:sureline/features/remote_config/domain/use_cases/prepare_remote_config_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/set_theme_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  debugPrint(
    'pending ${(await FlutterLocalNotificationsPlugin().pendingNotificationRequests()).length}',
  );
  await locator<InitializeNotificationsPresetsUseCase>().execute();
  debugPrint('check 1');
  await locator<PrepareRemoteConfigUseCase>().execute();
  debugPrint('check 2');
  final result = await locator<GetVolumeUseCase>().execute();
  result.fold((left) {}, (right) {
    App.volume = right;
  });
  debugPrint('check 3');
  final voice = await locator<GetVoiceUseCase>().execute();
  voice.fold((left) {}, (right) {
    if (right != null) {
      App.voice = VoiceModel.fromEntity(right).toJson();
    }
  });
  await locator<ScheduleUpToSixtyNotificationsUseCase>().execute();
  debugPrint('check 4');
  await locator<SetThemeUseCase>().execute();
  debugPrint('check 5');
  await locator<SaveAllQuotesToAppGroupUseCase>().execute();
  debugPrint('check 6');
  _cacheFonts();
  (await locator<IsOnboardingCompletedUseCase>().execute()).fold((left) {}, (
    right,
  ) {
    if (right) {
      runApp(const MyApp(isOnboarded: true));
    } else {
      runApp(const MyApp(isOnboarded: false));
    }
  });
  debugPrint('check 7');
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

//
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// void main() => runApp(MaterialApp(home: TextToImageExample()));
//
// class TextToImageExample extends StatefulWidget {
//   @override
//   _TextToImageExampleState createState() => _TextToImageExampleState();
// }
//
// class _TextToImageExampleState extends State<TextToImageExample> {
//   final GlobalKey _textKey = GlobalKey();
//   Uint8List? _textImageBytes;
//
//   Future<void> _convertTextToImage() async {
//     try {
//       RenderRepaintBoundary boundary = _textKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData =
//       await image.toByteData(format: ui.ImageByteFormat.png);
//
//       setState(() {
//         _textImageBytes = byteData!.buffer.asUint8List();
//       });
//     } catch (e) {
//       debugPrint('Error converting text to image: $e');
//     }
//   }
//   double _width = 0;
//   double _height = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final temp  =_textKey.currentContext!.findRenderObject() as RenderBox;
//       final Size size = temp.size;
//       setState(() {
//         _width = size.width;
//         _height = size.height;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Text to Image")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // This shows the image generated from the text
//             _textImageBytes != null
//                 ? SizedBox(width: _width, height: _height, child: Image.memory(_textImageBytes!))
//                 : SizedBox(height: 100, child: Text('No image yet')),
//
//             SizedBox(height: 20),
//
//             // This is the text that gets rendered as an image
//             RepaintBoundary(
//               key: _textKey,
//               child: Text(
//                 'This is a rendered image',
//                 style: TextStyle(fontSize: 24, color: Colors.amber),
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: _convertTextToImage,
//               child: Text("Render Text as Image"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
