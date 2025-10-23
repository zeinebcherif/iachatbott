import 'package:flutter/material.dart';
import 'models/reclamation.dart';
import 'screens/reclamations_list_screen.dart';
import 'screens/create_reclamation_screen.dart';
import 'screens/chatbot_screen.dart';

final Color firstColor = const Color(0xFFFFCBCB);   // #ffcbcb
final Color secondColor = const Color(0xFFFFB5B5);  // #ffb5b5
final Color thirdColor = const Color(0xFF407088);   // #407088
final Color fourthColor = const Color(0xFF132743);  // #132743

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Reclamation> reclamations = [
    Reclamation(
      id: '1',
      titre: 'Produit cassé',
      description: 'Le produit reçu est cassé.',
      statut: 'Ouvert',
      dateCreation: DateTime.now(),
    ),
    Reclamation(
      id: '2',
      titre: 'Colis non reçu',
      description: 'Je n\'ai pas reçu mon colis.',
      statut: 'En cours',
      dateCreation: DateTime.now(),
    ),
  ];

  void addReclamation(String titre, String description) {
    setState(() {
      reclamations.add(
        Reclamation(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          titre: titre,
          description: description,
          statut: 'Ouvert',
          dateCreation: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: thirdColor,
      brightness: Brightness.light,
    );

    final scheme = baseScheme.copyWith(
      primary: thirdColor,
      onPrimary: Colors.white,
      secondary: secondColor,
      onSecondary: fourthColor,
      error: Colors.red,
      onError: Colors.white,
      background: firstColor,
      onBackground: fourthColor,
      surface: Colors.white,
      onSurface: fourthColor,
    );

    return MaterialApp(
      title: 'MarketPlace SmartFIT',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: scheme.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF132743),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          surfaceTintColor: scheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
          contentTextStyle: TextStyle(
            fontSize: 14,
            color: scheme.onSurface.withOpacity(0.85),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondColor,
            foregroundColor: fourthColor,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: thirdColor,
            side: BorderSide(color: thirdColor.withOpacity(0.4)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondColor,
          foregroundColor: fourthColor,
          elevation: 3,
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(color: scheme.outline.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: fourthColor,
          ),
          bodyMedium: TextStyle(
            color: thirdColor,
          ),
        ),
      ),
      routes: {
        '/': (context) => ReclamationsListScreen(
          reclamations: reclamations,
          onAddPressed: () async {
            final result = await Navigator.pushNamed(context, '/create-reclamation');
            if (result is Map<String, String>) {
              addReclamation(result['titre'] ?? '', result['description'] ?? '');
            }
          },
        ),
        '/create-reclamation': (context) => const CreateReclamationScreen(),
        '/chat': (context) => const ChatbotScreen(),
      },
      initialRoute: '/',
    );
  }
}