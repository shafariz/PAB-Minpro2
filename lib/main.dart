import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'controllers/theme_controller.dart';
import 'pages/home_page.dart';
import 'pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY']!,
    );

    final themeController = Get.put(ThemeController(), permanent: true);
    await themeController.loadTheme();

    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Error saat inisialisasi:\n$e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Favobooks',
          themeMode: themeController.themeMode,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF3E5AB),
            textTheme: GoogleFonts.poppinsTextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF8F8395),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF8F8395),
              foregroundColor: Colors.white,
              shape: CircleBorder(),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8F8395),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF1E1B22),
            textTheme: GoogleFonts.poppinsTextTheme(
              ThemeData.dark().textTheme,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF3D3342),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF8F8395),
              foregroundColor: Colors.white,
              shape: CircleBorder(),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8F8395),
              brightness: Brightness.dark,
            ),
          ),
          home: Supabase.instance.client.auth.currentSession == null
              ? const WelcomePage()
              : const HomePage(),
        );
      },
    );
  }
}
