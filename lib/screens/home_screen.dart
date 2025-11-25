import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Player> _players = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTop();
  }

  Future<void> _loadTop() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.topPlayers(limit: 20);
      setState(() {
        _players = data.map<Player>((d) => Player.fromJson(Map<String, dynamic>.from(d))).toList();
      });
    } catch (e) {
      // ignore errors for now
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scout IA - Top Sub-21')),
      body: RefreshIndicator(
        onRefresh: _loadTop,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, i) {
                  final p = _players[i];
                  return ListTile(
                    leading: CircleAvatar(child: Text(p.name.substring(0, 1))),
                    title: Text(p.name),
                    subtitle: Text('${p.club} • ${p.position} • Age ${p.age}'),
                    trailing: Text(p.predictedScore.toStringAsFixed(1)),
                    onTap: () {
                      Navigator.pushNamed(context, '/player', arguments: p);
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadTop,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}