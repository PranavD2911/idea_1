import 'package:flutter/material.dart';
import 'package:idea_1/common/utils/bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:idea_1/modules/gemini/presentation/widgets/conversation_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConversationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop With Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CustomBottomNav(),
    );
  }
}
