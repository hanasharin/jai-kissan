import 'package:flutter/material.dart';
import 'theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dash.jpg', fit: BoxFit.cover),
          Container(color: JaikissanTheme.beigeLight.withValues(alpha: 0.6)),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context)),
                SliverToBoxAdapter(child: _buildWeatherBanner(context)),
                SliverToBoxAdapter(
                  child: _buildSectionTitle(context, 'AI Modules'),
                ),
                SliverToBoxAdapter(child: _buildModuleGrid(context)),
                SliverToBoxAdapter(
                  child: _buildSectionTitle(context, 'Latest Insights'),
                ),
                SliverToBoxAdapter(child: _buildInsightsList(context)),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: JaikissanTheme.inkLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Hasil 🌿',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: JaikissanTheme.emerald,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'H',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: JaikissanTheme.beige,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: JaikissanTheme.emerald,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tirur, Kerala',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: JaikissanTheme.beige.withOpacity(0.65),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '28°',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: JaikissanTheme.beige,
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6, left: 4),
                        child: Text(
                          'Partly cloudy',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: JaikissanTheme.beige.withOpacity(0.55),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _WeatherPill(
                        icon: Icons.water_drop_outlined,
                        label: '78% humidity',
                      ),
                      const SizedBox(width: 10),
                      _WeatherPill(
                        icon: Icons.air_rounded,
                        label: '12 km/h wind',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.cloud_outlined,
              color: JaikissanTheme.beige.withOpacity(0.3),
              size: 72,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 14),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildModuleGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Hero module — Yield Prediction (GRU)
          _ModuleCard(
            title: 'Yield Prediction',
            subtitle: 'GRU Model',
            description:
                'Forecast expected yield using GRU-based deep learning on rainfall, temperature and soil data.',
            icon: Icons.show_chart_rounded,
            color: JaikissanTheme.emerald,
            accent: JaikissanTheme.sand,
            onTap: () => Navigator.pushNamed(context, '/yield'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _SmallModuleCard(
                  title: 'Crop\nRecommend',
                  icon: Icons.recommend_rounded,
                  color: JaikissanTheme.emeraldMid,
                  onTap: () => Navigator.pushNamed(context, '/recommend'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SmallModuleCard(
                  title: 'Market\nPrices',
                  icon: Icons.trending_up_rounded,
                  color: JaikissanTheme.sand,
                  onTap: () => Navigator.pushNamed(context, '/market'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsList(BuildContext context) {
    final insights = [
      _Insight(
        icon: Icons.info_outline_rounded,
        color: JaikissanTheme.emeraldLight,
        title: 'Rice yield up 12% this season',
        sub: 'Based on current rainfall + temp data',
      ),
      _Insight(
        icon: Icons.warning_amber_rounded,
        color: JaikissanTheme.sand,
        title: 'Soil moisture below optimal',
        sub: 'Consider irrigation in next 48h',
      ),
      _Insight(
        icon: Icons.price_change_outlined,
        color: JaikissanTheme.emeraldMid,
        title: 'Rice modal price ₹2,280/qtl',
        sub: 'Tirur market · updated today',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: insights
            .map(
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: JaikissanCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: i.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(i.icon, color: i.color, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              i.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              i.sub,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: JaikissanTheme.inkLight,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _WeatherPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _WeatherPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white12,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: JaikissanTheme.beige.withOpacity(0.6), size: 13),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: JaikissanTheme.beige.withOpacity(0.7),
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

class _ModuleCard extends StatelessWidget {
  final String title, subtitle, description;
  final IconData icon;
  final Color color, accent;
  final VoidCallback onTap;
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: JaikissanTheme.beige,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: JaikissanTheme.beige.withOpacity(0.65),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: JaikissanTheme.beige,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Run prediction',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: JaikissanTheme.emerald,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: JaikissanTheme.emerald,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _SmallModuleCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSand = color == JaikissanTheme.sand;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSand ? JaikissanTheme.emerald : JaikissanTheme.beige,
              size: 26,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isSand ? JaikissanTheme.emerald : JaikissanTheme.beige,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            Icon(
              Icons.arrow_forward_rounded,
              color: (isSand ? JaikissanTheme.emerald : JaikissanTheme.beige)
                  .withOpacity(0.5),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _Insight {
  final IconData icon;
  final Color color;
  final String title, sub;
  const _Insight({
    required this.icon,
    required this.color,
    required this.title,
    required this.sub,
  });
}
