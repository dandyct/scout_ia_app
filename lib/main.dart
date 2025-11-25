import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/player_detail_screen.dart';
import 'services/api_service.dart';
import 'models/player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScoutApp());
}

class ScoutApp extends StatelessWidget {
  const ScoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
      ],
      child: MaterialApp(
        title: 'Scout IA',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/player': (ctx) => PlayerDetailScreen(
                player: ModalRoute.of(ctx)!.settings.arguments as Player,
              ),
        },
      ),
    );
  }
}
