import 'dart:math';
import 'package:flutter/material.dart';
import 'theme.dart';

class MarketPricePage extends StatefulWidget {
  const MarketPricePage({super.key});
  @override
  State<MarketPricePage> createState() => _MarketPricePageState();
}

class _MarketPricePageState extends State<MarketPricePage> {
  bool _loading = true;
  String _selectedCrop = 'Rice';
  String _selectedState = 'Kerala';

  final _crops = ['Rice', 'Wheat', 'Sugarcane', 'Maize', 'Cotton'];
  final _states = [
    'Kerala',
    'Tamil Nadu',
    'Karnataka',
    'Andhra Pradesh',
    'Punjab',
  ];

  List<_MarketEntry> _prices = [];
  List<double> _forecast = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    final rng = Random(42);
    setState(() {
      _prices = [
        _MarketEntry('Tirur', 'Malappuram', 2050, 2400, 2220),
        _MarketEntry('Kochi', 'Ernakulam', 2100, 2450, 2280),
        _MarketEntry('Palakkad', 'Palakkad', 2000, 2380, 2190),
        _MarketEntry('Thrissur', 'Thrissur', 2080, 2430, 2250),
        _MarketEntry('Kozhikode', 'Kozhikode', 2060, 2420, 2240),
      ];
      double base = 2250;
      _forecast = List.generate(7, (i) {
        base += (rng.nextDouble() - 0.42) * 50;
        return base.clamp(2000, 2600);
      });
      _loading = false;
    });
  }

  double get _avgModal => _prices.isEmpty
      ? 0
      : _prices.map((p) => p.modal).reduce((a, b) => a + b) / _prices.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/emarald.jpg', fit: BoxFit.cover),
          Container(color: JKTheme.beigeLight.withOpacity(0.88)),
          SafeArea(
            child: Column(
              children: [
                // Custom app bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: JKTheme.emerald,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          'Market Prices',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: JKTheme.emerald),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: JKTheme.emerald,
                        ),
                        onPressed: _loadData,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: JKTheme.emerald,
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          children: [
                            const SizedBox(height: 4),
                            _buildFilters(),
                            const SizedBox(height: 20),
                            _buildKpiRow(context),
                            const SizedBox(height: 20),
                            _buildForecastCard(context),
                            const SizedBox(height: 20),
                            Text(
                              'Live Listings',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            ..._prices.map(
                              (p) => _PriceCard(entry: p, avgModal: _avgModal),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 13,
                                  color: JKTheme.inkLight.withOpacity(0.5),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Agmarknet via data.gov.in · ₹ per quintal',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() => Row(
    children: [
      Expanded(
        child: _FilterDropdown(
          value: _selectedCrop,
          items: _crops,
          label: 'Crop',
          onChanged: (v) {
            setState(() => _selectedCrop = v!);
            _loadData();
          },
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _FilterDropdown(
          value: _selectedState,
          items: _states,
          label: 'State',
          onChanged: (v) {
            setState(() => _selectedState = v!);
            _loadData();
          },
        ),
      ),
    ],
  );

  Widget _buildKpiRow(BuildContext context) => Row(
    children: [
      Expanded(
        child: _KpiTile(
          label: 'Avg Modal',
          value: '₹${_avgModal.toStringAsFixed(0)}',
          unit: '/qtl',
          color: JKTheme.emerald,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _KpiTile(
          label: 'Peak Forecast',
          value:
              '₹${_forecast.isEmpty ? 0 : _forecast.reduce(max).toStringAsFixed(0)}',
          unit: '/qtl',
          color: JKTheme.emeraldMid,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _KpiTile(
          label: 'Markets',
          value: '${_prices.length}',
          unit: 'listed',
          color: JKTheme.sand,
        ),
      ),
    ],
  );

  Widget _buildForecastCard(BuildContext context) => JKCard(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '7-Day Forecast',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: JKTheme.emerald.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: JKTheme.emerald.withOpacity(0.25)),
              ),
              child: Text(
                _selectedCrop,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: JKTheme.emerald,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Price trend in ₹ per quintal',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 20),
        SizedBox(height: 160, child: _ForecastChart(data: _forecast)),
      ],
    ),
  );
}

class _FilterDropdown extends StatelessWidget {
  final String value, label;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    decoration: BoxDecoration(
      color: JKTheme.beige,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFCDC9A5), width: 1.5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: JKTheme.inkLight,
          size: 18,
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: JKTheme.ink,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        items: items
            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
            .toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

class _KpiTile extends StatelessWidget {
  final String label, value, unit;
  final Color color;
  const _KpiTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: JKTheme.beige,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFCDC9A5), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: color,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            color: color.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            color: JKTheme.inkLight,
          ),
        ),
      ],
    ),
  );
}

class _MarketEntry {
  final String market, district;
  final double min, max, modal;
  const _MarketEntry(
    this.market,
    this.district,
    this.min,
    this.max,
    this.modal,
  );
}

class _PriceCard extends StatelessWidget {
  final _MarketEntry entry;
  final double avgModal;
  const _PriceCard({required this.entry, required this.avgModal});

  @override
  Widget build(BuildContext context) {
    final isAbove = entry.modal >= avgModal;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: JKCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: JKTheme.emerald.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: JKTheme.emeraldMid,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.market,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    entry.district,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      '₹${entry.modal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: JKTheme.ink,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: (isAbove ? JKTheme.emeraldLight : JKTheme.sand)
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        isAbove
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        color: isAbove ? JKTheme.emeraldLight : JKTheme.sand,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${entry.min.toStringAsFixed(0)} – ${entry.max.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ForecastChart extends StatelessWidget {
  final List<double> data;
  const _ForecastChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();
    return CustomPaint(painter: _ChartPainter(data), size: Size.infinite);
  }
}

class _ChartPainter extends CustomPainter {
  final List<double> data;
  const _ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    const padL = 48.0, padR = 12.0, padT = 8.0, padB = 28.0;
    final w = size.width - padL - padR;
    final h = size.height - padT - padB;
    final minV = data.reduce(min) * 0.98;
    final maxV = data.reduce(max) * 1.02;
    final range = maxV - minV;

    double px(int i) => padL + i * w / (data.length - 1);
    double py(double v) => padT + h - (v - minV) / range * h;

    final gridPaint = Paint()
      ..color = const Color(0xFFCDC9A5)
      ..strokeWidth = 1;
    for (var i = 0; i <= 3; i++) {
      final y = padT + i * h / 3;
      canvas.drawLine(Offset(padL, y), Offset(size.width - padR, y), gridPaint);
      final lbl = maxV - i * range / 3;
      final tp = TextPainter(
        text: TextSpan(
          text: '₹${lbl.toStringAsFixed(0)}',
          style: const TextStyle(
            color: JKTheme.inkLight,
            fontSize: 9,
            fontFamily: 'Poppins',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    final path = Path()..moveTo(px(0), py(data[0]));
    for (var i = 1; i < data.length; i++) {
      final cx1 = px(i - 1) + w / (data.length - 1) * 0.5;
      final cx2 = px(i) - w / (data.length - 1) * 0.5;
      path.cubicTo(cx1, py(data[i - 1]), cx2, py(data[i]), px(i), py(data[i]));
    }
    final fill = Path.from(path)
      ..lineTo(px(data.length - 1), padT + h)
      ..lineTo(padL, padT + h)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            JKTheme.emeraldLight.withOpacity(0.2),
            JKTheme.emeraldLight.withOpacity(0),
          ],
        ).createShader(Rect.fromLTWH(padL, padT, w, h)),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = JKTheme.emeraldLight
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (var i = 0; i < data.length; i++) {
      canvas.drawCircle(
        Offset(px(i), py(data[i])),
        4.5,
        Paint()..color = JKTheme.beige,
      );
      canvas.drawCircle(
        Offset(px(i), py(data[i])),
        3,
        Paint()..color = JKTheme.emeraldLight,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: days[i % 7],
          style: const TextStyle(
            color: JKTheme.inkLight,
            fontSize: 9,
            fontFamily: 'Poppins',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(px(i) - tp.width / 2, padT + h + 8));
    }
  }

  @override
  bool shouldRepaint(_ChartPainter old) => old.data != data;
}
