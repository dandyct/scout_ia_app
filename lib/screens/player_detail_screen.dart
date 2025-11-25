import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerDetailScreen extends StatelessWidget {
  final Player player;

  const PlayerDetailScreen({Key? key, required this.player}) : super(key: key);

  Widget _buildAvatar(BuildContext context) {
    // Player no tiene campo photo en tu modelo actual; usamos iniciales.
    final avatar = CircleAvatar(
      radius: 40,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
      child: Text(
        player.name.isNotEmpty ? player.name.substring(0, 1).toUpperCase() : '?',
        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );

    return Hero(
      tag: 'avatar-${player.name}',
      child: Material(
        color: Colors.transparent,
        child: Semantics(
          label: 'Avatar de ${player.name}',
          image: true,
          child: avatar,
        ),
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(player.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 6),
        Text('${player.club} • ${player.position}', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 6),
        Text('Edad: ${player.age}', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        // Predicted score card
        Semantics(
          label: 'Puntuación prevista ${player.predictedScore.toStringAsFixed(1)}',
          value: player.predictedScore.toStringAsFixed(1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  Theme.of(context).colorScheme.primary.withOpacity(0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.12)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.show_chart, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Predicted Score', style: Theme.of(context).textTheme.bodySmall),
                    Text(player.predictedScore.toStringAsFixed(2), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsArea(BuildContext context) {
    // Placeholder: puedes reemplazar con un gráfico real (fl_chart, charts_flutter, etc.)
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estadísticas & Evolución', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Aquí aparecerá la gráfica de evolución, métricas y comparativas.', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('Gráfico de ejemplo', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        actions: [
          IconButton(
            tooltip: 'Favorito',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Favorito (no implementado)')));
            },
            icon: const Icon(Icons.star_border),
          ),
          IconButton(
            tooltip: 'Compartir',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compartir (no implementado)')));
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column: avatar + basic info
                    SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          _buildAvatar(context),
                          const SizedBox(height: 16),
                          _buildBasicInfo(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Right column: stats and other content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatsArea(context),
                          const SizedBox(height: 12),
                          // Additional details placeholder
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Detalle', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 8),
                                  Text('Más información del jugador (scouting notes, strengths, weaknesses, etc.)', style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: _buildAvatar(context)),
                    const SizedBox(height: 12),
                    _buildBasicInfo(context),
                    const SizedBox(height: 12),
                    _buildStatsArea(context),
                    const SizedBox(height: 12),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detalle', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text('Más información del jugador (scouting notes, strengths, weaknesses, etc.)', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}