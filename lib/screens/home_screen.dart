import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart';
import '../models/player.dart';
import '../widgets/header.dart';
import '../widgets/card_item.dart';

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
      // Si ApiService.topPlayers no es static, usa Provider.of<ApiService>(context, listen: false)
      final data = await ApiService.topPlayers(limit: 20);
      setState(() {
        _players = data
            .map<Player>((d) => Player.fromJson(Map<String, dynamic>.from(d)))
            .toList();
      });
    } catch (e) {
      // Puedes mostrar un SnackBar o manejar el error aquí
    } finally {
      setState(() => _loading = false);
    }
  }

  void _openPlayer(Player p) {
    Navigator.pushNamed(context, '/player', arguments: p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scout IA - Top Sub-21')),
      body: RefreshIndicator(
        onRefresh: _loadTop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              const AppHeader(title: 'Top Sub-21'),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _loading
                      ? const Center(key: ValueKey('loading'), child: CircularProgressIndicator())
                      : _players.isEmpty
                          ? Center(
                              key: const ValueKey('empty'),
                              child: Text('No hay jugadores disponibles', style: Theme.of(context).textTheme.bodyMedium),
                            )
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                final isWide = constraints.maxWidth > 700;
                                if (isWide) {
                                  // Grid para pantallas anchas
                                  return GridView.builder(
                                    key: const ValueKey('grid'),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 4,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemCount: _players.length,
                                    itemBuilder: (context, i) {
                                      final p = _players[i];
                                      return CardItem(
                                        // Usamos name como tag porque Player no tiene id
                                        leading: Hero(
                                          tag: 'avatar-${p.name}',
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                                            child: Text(p.name.isNotEmpty ? p.name.substring(0, 1).toUpperCase() : '?',
                                                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                          ),
                                        ),
                                        title: p.name,
                                        subtitle: '${p.club} • ${p.position} • ${p.age} yrs',
                                        onTap: () => _openPlayer(p),
                                        trailing: Text(p.predictedScore.toStringAsFixed(1), style: Theme.of(context).textTheme.titleSmall),
                                        semanticLabel: 'Jugador ${p.name}, ${p.position}, club ${p.club}',
                                      );
                                    },
                                  );
                                } else {
                                  // Lista para móvil
                                  return ListView.separated(
                                    key: const ValueKey('list'),
                                    itemCount: _players.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                                    itemBuilder: (context, i) {
                                      final p = _players[i];
                                      return CardItem(
                                        leading: Hero(
                                          tag: 'avatar-${p.name}',
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                                            child: Text(p.name.isNotEmpty ? p.name.substring(0, 1).toUpperCase() : '?',
                                                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                                          ),
                                        ),
                                        title: p.name,
                                        subtitle: '${p.club} • ${p.position} • Age ${p.age}',
                                        trailing: Text(p.predictedScore.toStringAsFixed(1), style: Theme.of(context).textTheme.titleSmall),
                                        onTap: () => _openPlayer(p),
                                        semanticLabel: 'Jugador ${p.name}, ${p.position}, club ${p.club}',
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadTop,
        tooltip: 'Refrescar top',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}