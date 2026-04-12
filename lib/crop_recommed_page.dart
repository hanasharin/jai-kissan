import 'package:flutter/material.dart';
import 'theme.dart';

class CropRecommendPage extends StatefulWidget {
  const CropRecommendPage({super.key});
  @override
  State<CropRecommendPage> createState() => _CropRecommendPageState();
}

class _CropRecommendPageState extends State<CropRecommendPage> {
  final _nitrogenCtrl = TextEditingController(text: '40');
  final _phosphCtrl = TextEditingController(text: '30');
  final _potassiumCtrl = TextEditingController(text: '35');
  final _tempCtrl = TextEditingController(text: '27');
  final _humidityCtrl = TextEditingController(text: '70');
  final _phCtrl = TextEditingController(text: '6.5');
  final _rainfallCtrl = TextEditingController(text: '110');

  bool _loading = false;
  List<_CropResult>? _results;

  final _soilTypes = ['Loamy', 'Sandy', 'Clay', 'Silty', 'Peaty'];
  String _soilType = 'Loamy';

  void _recommend() async {
    setState(() {
      _loading = true;
      _results = null;
    });
    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) {
      setState(() {
        _loading = false;
        _results = [
          _CropResult('Rice', 0.92, Icons.grain_rounded, JKTheme.emeraldMid),
          _CropResult(
            'Sugarcane',
            0.85,
            Icons.grass_rounded,
            JKTheme.emeraldLight,
          ),
          _CropResult('Maize', 0.78, Icons.agriculture_rounded, JKTheme.sand),
          _CropResult('Jute', 0.61, Icons.eco_rounded, const Color(0xFF8FB8A8)),
          _CropResult('Wheat', 0.54, Icons.spa_outlined, JKTheme.beigeDark),
        ];
      });
    }
  }

  @override
  void dispose() {
    for (final c in [
      _nitrogenCtrl,
      _phosphCtrl,
      _potassiumCtrl,
      _tempCtrl,
      _humidityCtrl,
      _phCtrl,
      _rainfallCtrl,
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
          Image.asset('assets/images/emarald.jpg', fit: BoxFit.cover),
          Container(color: JKTheme.beigeLight.withOpacity(0.88)),
          SafeArea(
            child: Column(
              children: [
                // App bar row
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: JKTheme.emerald,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Crop Recommendation',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: JKTheme.emerald),
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

                        // Model pill — 2.0 emerald bg
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: JKTheme.emerald.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: JKTheme.emerald.withOpacity(0.25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.account_tree_outlined,
                                color: JKTheme.emerald,
                                size: 15,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Hybrid CNN + DNN Model',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: JKTheme.emerald,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Soil Nutrients',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        _SliderField(
                          label: 'Nitrogen (N)',
                          ctrl: _nitrogenCtrl,
                          min: 0,
                          max: 140,
                          color: JKTheme.emeraldLight,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _SliderField(
                                label: 'Phosphorus (P)',
                                ctrl: _phosphCtrl,
                                min: 0,
                                max: 145,
                                color: JKTheme.sand,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SliderField(
                                label: 'Potassium (K)',
                                ctrl: _potassiumCtrl,
                                min: 0,
                                max: 205,
                                color: JKTheme.emeraldMid,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Environmental Data',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _NumFieldCompact(
                                label: 'Temperature °C',
                                ctrl: _tempCtrl,
                                icon: Icons.thermostat_outlined,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _NumFieldCompact(
                                label: 'Humidity %',
                                ctrl: _humidityCtrl,
                                icon: Icons.water_drop_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _NumFieldCompact(
                                label: 'pH level',
                                ctrl: _phCtrl,
                                icon: Icons.science_outlined,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _NumFieldCompact(
                                label: 'Rainfall mm',
                                ctrl: _rainfallCtrl,
                                icon: Icons.umbrella_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'Soil Type',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _soilTypes
                                .map(
                                  (s) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      onTap: () =>
                                          setState(() => _soilType = s),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 9,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _soilType == s
                                              ? JKTheme.emerald
                                              : JKTheme.beige,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: _soilType == s
                                                ? JKTheme.emerald
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
                                            color: _soilType == s
                                                ? JKTheme.beige
                                                : JKTheme.inkLight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 28),

                        JKButton(
                          label: 'Get Recommendations',
                          onTap: _recommend,
                          loading: _loading,
                          icon: Icons.recommend_rounded,
                        ),
                        const SizedBox(height: 28),

                        if (_results != null) ...[
                          Text(
                            'Ranked Results',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 14),
                          ..._results!.asMap().entries.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _CropResultCard(
                                rank: e.key + 1,
                                result: e.value,
                              ),
                            ),
                          ),
                        ],
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

class _SliderField extends StatefulWidget {
  final String label;
  final TextEditingController ctrl;
  final double min, max;
  final Color color;
  const _SliderField({
    required this.label,
    required this.ctrl,
    required this.min,
    required this.max,
    required this.color,
  });
  @override
  State<_SliderField> createState() => _SliderFieldState();
}

class _SliderFieldState extends State<_SliderField> {
  late double _val;
  @override
  void initState() {
    super.initState();
    _val = double.tryParse(widget.ctrl.text) ?? widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return JKCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.label, style: Theme.of(context).textTheme.bodySmall),
              Text(
                _val.toStringAsFixed(0),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: widget.color,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: widget.color,
              inactiveTrackColor: widget.color.withOpacity(0.15),
              thumbColor: widget.color,
              overlayColor: widget.color.withOpacity(0.1),
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              value: _val,
              min: widget.min,
              max: widget.max,
              onChanged: (v) {
                setState(() => _val = v);
                widget.ctrl.text = v.toStringAsFixed(0);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NumFieldCompact extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final IconData icon;
  const _NumFieldCompact({
    required this.label,
    required this.ctrl,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    style: const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: JKTheme.ink,
    ),
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: JKTheme.inkLight, size: 18),
    ),
  );
}

class _CropResult {
  final String name;
  final double probability;
  final IconData icon;
  final Color color;
  const _CropResult(this.name, this.probability, this.icon, this.color);
}

class _CropResultCard extends StatelessWidget {
  final int rank;
  final _CropResult result;
  const _CropResultCard({required this.rank, required this.result});

  @override
  Widget build(BuildContext context) {
    final isTop = rank == 1;
    return JKCard(
      color: isTop ? JKTheme.emerald : JKTheme.beige,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isTop
                  ? Colors.white.withOpacity(0.15)
                  : result.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              result.icon,
              color: isTop ? JKTheme.beige : result.color,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      result.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: isTop ? JKTheme.beige : JKTheme.ink,
                      ),
                    ),
                    if (isTop) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: JKTheme.sand.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Best match',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: JKTheme.sand,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: result.probability,
                    minHeight: 5,
                    backgroundColor: (isTop ? JKTheme.beige : result.color)
                        .withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isTop ? JKTheme.beige.withOpacity(0.7) : result.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '${(result.probability * 100).toInt()}%',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: isTop ? JKTheme.beige : JKTheme.ink,
            ),
          ),
        ],
      ),
    );
  }
}
