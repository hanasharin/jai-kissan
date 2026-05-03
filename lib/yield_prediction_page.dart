import 'package:flutter/material.dart';
import 'theme.dart';

class YieldPredictionPage extends StatefulWidget {
  const YieldPredictionPage({super.key});
  @override
  State<YieldPredictionPage> createState() => _YieldPredictionPageState();
}

class _YieldPredictionPageState extends State<YieldPredictionPage> {
  final _cropCtrl = TextEditingController(text: 'Rice');
  final _areaCtrl = TextEditingController(text: '2.5');
  final _rainfallCtrl = TextEditingController(text: '120');
  final _tempCtrl = TextEditingController(text: '27');
  final _fertCtrl = TextEditingController(text: '60');

  bool _loading = false;
  _YieldResult? _result;

  final _seasons = ['Kharif', 'Rabi', 'Zaid'];
  String _season = 'Kharif';

  // Only GRU is used — no model switcher needed
  static const _modelLabel = 'GRU';

  void _predict() async {
    setState(() {
      _loading = true;
      _result = null;
    });
    await Future.delayed(const Duration(milliseconds: 1800));
    if (mounted) {
      setState(() {
        _loading = false;
        _result = _YieldResult(
          predicted: 4.8,
          min: 3.9,
          max: 5.6,
          confidence: 0.87,
          season: _season,
          model: _modelLabel,
        );
      });
    }
  }

  @override
  void dispose() {
    for (final c in [
      _cropCtrl,
      _areaCtrl,
      _rainfallCtrl,
      _tempCtrl,
      _fertCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dash.jpg', fit: BoxFit.cover),
          Container(color: JaikissanTheme.beigeLight.withValues(alpha: 0.6)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: JaikissanTheme.emerald,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Yield Prediction',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: JaikissanTheme.emerald),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // Model badge — GRU only
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: JaikissanTheme.emerald.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: JaikissanTheme.emerald.withOpacity(0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.show_chart_rounded,
                                color: JaikissanTheme.emerald,
                                size: 15,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'GRU Model',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: JaikissanTheme.emerald,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Crop Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _InputField(
                                label: 'Crop Name',
                                ctrl: _cropCtrl,
                                icon: Icons.eco_outlined,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _InputField(
                                label: 'Area (acres)',
                                ctrl: _areaCtrl,
                                icon: Icons.landscape_outlined,
                                keyboard: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'Season',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: _seasons
                              .map(
                                (s) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _season = s),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 180,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 9,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _season == s
                                            ? JaikissanTheme.emerald
                                            : JaikissanTheme.beige,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: _season == s
                                              ? JaikissanTheme.emerald
                                              : const Color(0xFFCDC9A5),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        s,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: _season == s
                                              ? JaikissanTheme.beige
                                              : JaikissanTheme.inkLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Environmental Inputs',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _InputField(
                                label: 'Rainfall mm',
                                ctrl: _rainfallCtrl,
                                icon: Icons.umbrella_outlined,
                                keyboard: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _InputField(
                                label: 'Temperature °C',
                                ctrl: _tempCtrl,
                                icon: Icons.thermostat_outlined,
                                keyboard: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InputField(
                          label: 'Fertiliser (kg/ha)',
                          ctrl: _fertCtrl,
                          icon: Icons.science_outlined,
                          keyboard: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                        const SizedBox(height: 32),

                        JaikissanButton(
                          label: 'Predict Yield',
                          onTap: _predict,
                          loading: _loading,
                          icon: Icons.show_chart_rounded,
                        ),
                        const SizedBox(height: 28),

                        if (_result != null) _YieldResultCard(result: _result!),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final IconData icon;
  final TextInputType? keyboard;
  const _InputField({
    required this.label,
    required this.ctrl,
    required this.icon,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl,
    keyboardType: keyboard,
    style: const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: JaikissanTheme.ink,
    ),
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: JaikissanTheme.inkLight, size: 18),
    ),
  );
}

class _YieldResult {
  final double predicted, min, max, confidence;
  final String season, model;
  const _YieldResult({
    required this.predicted,
    required this.min,
    required this.max,
    required this.confidence,
    required this.season,
    required this.model,
  });
}

class _YieldResultCard extends StatelessWidget {
  final _YieldResult result;
  const _YieldResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    return JaikissanCard(
      color: JaikissanTheme.emerald,
      padding: const EdgeInsets.all(22),
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
                child: const Icon(
                  Icons.show_chart_rounded,
                  color: JaikissanTheme.beige,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yield Prediction',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: JaikissanTheme.beige.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    result.model, // shows 'GRU'
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: JaikissanTheme.beige,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: JaikissanTheme.sand.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(result.confidence * 100).toInt()}% confident',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: JaikissanTheme.sand,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '${result.predicted.toStringAsFixed(1)} tons/ha',
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: JaikissanTheme.beige,
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Expected range: ${result.min}–${result.max} tons/ha',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: JaikissanTheme.beige.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: result.confidence,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                JaikissanTheme.sand,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Season: ${result.season}',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: JaikissanTheme.beige.withOpacity(0.55),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
