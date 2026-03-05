import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final _formKey = GlobalKey<FormState>();
  final _nitrogenController = TextEditingController();
  final _phosphorusController = TextEditingController();
  final _potassiumController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _humidityController = TextEditingController();
  final _phController = TextEditingController();
  final _rainfallController = TextEditingController();

  bool _showRecommendations = false;
  List<Map<String, dynamic>> _recommendedCrops = [];

  void _getRecommendations() {
    if (_formKey.currentState!.validate()) {
      // Simulate DL model inference
      // In a real app, load TFLite model and run inference with inputs
      // For example:
      // final interpreter = await Interpreter.fromAsset('model.tflite');
      // var input = [double.parse(_nitrogenController.text), ...];
      // var output = interpreter.run(input);
      // Then parse output to get crop recommendations

      // Mock logic based on inputs
      double n = double.tryParse(_nitrogenController.text) ?? 0;
      double p = double.tryParse(_phosphorusController.text) ?? 0;
      double k = double.tryParse(_potassiumController.text) ?? 0;
      double temp = double.tryParse(_temperatureController.text) ?? 0;
      double humidity = double.tryParse(_humidityController.text) ?? 0;
      double ph = double.tryParse(_phController.text) ?? 0;
      double rainfall = double.tryParse(_rainfallController.text) ?? 0;

      // Simple mock decision tree
      if (temp > 25 && humidity > 70 && rainfall > 100) {
        _recommendedCrops = [
          {
            'name': 'Rice',
            'yield': 'High yield expected: 5-7 tons/ha',
            'suitability':
                'Suitable for high temperature, humidity, and rainfall',
            'icon': Icons.grass,
          },
          {
            'name': 'Banana',
            'yield': 'High yield: 20-30 tons/ha',
            'suitability': 'Ideal for tropical conditions',
            'icon': Icons.eco,
          },
          {
            'name': 'Coconut',
            'yield': 'Moderate yield: 80-100 nuts/tree',
            'suitability': 'Good for humid and rainy areas',
            'icon': Icons.beach_access,
          },
        ];
      } else if (temp < 20 && ph > 6) {
        _recommendedCrops = [
          {
            'name': 'Wheat',
            'yield': 'Moderate yield: 3-5 tons/ha',
            'suitability': 'Suitable for cooler temperatures and neutral pH',
            'icon': Icons.agriculture,
          },
          {
            'name': 'Barley',
            'yield': 'Moderate yield: 2-4 tons/ha',
            'suitability': 'Good for dry and cool regions',
            'icon': Icons.grain,
          },
          {
            'name': 'Potato',
            'yield': 'High yield: 15-20 tons/ha',
            'suitability': 'Ideal for cool weather',
            'icon': Icons.local_florist,
          },
        ];
      } else {
        _recommendedCrops = [
          {
            'name': 'Maize',
            'yield': 'High yield: 4-6 tons/ha',
            'suitability': 'Versatile for various conditions',
            'icon': Icons.eco,
          },
          {
            'name': 'Soybean',
            'yield': 'Moderate yield: 2-3 tons/ha',
            'suitability': 'Good for moderate rainfall',
            'icon': Icons.nature,
          },
          {
            'name': 'Cotton',
            'yield': 'Moderate yield: 1-2 tons/ha',
            'suitability': 'Suitable for warm and dry areas',
            'icon': Icons.cloud,
          },
        ];
      }

      setState(() {
        _showRecommendations = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const emerald = Color(0xFF203D2B);
    const beige = Color(0xFFFAF2D5);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: emerald,
        title: Text(
          'Crop Recommendations',
          style: TextStyle(
            color: beige,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: beige),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/dash.jpg', fit: BoxFit.cover),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your farm details for personalized recommendations:',
                  style: TextStyle(
                    fontSize: 18,
                    color: emerald,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        'Nitrogen (N)',
                        _nitrogenController,
                        emerald,
                        beige,
                      ),
                      _buildTextField(
                        'Phosphorus (P)',
                        _phosphorusController,
                        emerald,
                        beige,
                      ),
                      _buildTextField(
                        'Potassium (K)',
                        _potassiumController,
                        emerald,
                        beige,
                      ),
                      _buildTextField(
                        'Temperature (°C)',
                        _temperatureController,
                        emerald,
                        beige,
                      ),
                      _buildTextField(
                        'Humidity (%)',
                        _humidityController,
                        emerald,
                        beige,
                      ),
                      _buildTextField('pH', _phController, emerald, beige),
                      _buildTextField(
                        'Rainfall (mm)',
                        _rainfallController,
                        emerald,
                        beige,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _getRecommendations,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: emerald,
                          foregroundColor: beige,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Get Recommendations',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showRecommendations) ...[
                  const SizedBox(height: 30),
                  Text(
                    'Recommended Crops:',
                    style: TextStyle(
                      fontSize: 18,
                      color: emerald,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _recommendedCrops.length,
                    itemBuilder: (context, index) {
                      final crop = _recommendedCrops[index];
                      return _buildCropCard(crop, beige, emerald);
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    Color emerald,
    Color beige,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: emerald, fontFamily: 'Poppins'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: emerald),
          ),
          filled: true,
          fillColor: beige.withOpacity(0.1),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> crop, Color beige, Color emerald) {
    return Card(
      color: emerald,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(crop['icon'], size: 48, color: beige),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crop['name'],
                    style: TextStyle(
                      fontSize: 20,
                      color: beige,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    crop['yield'],
                    style: TextStyle(
                      fontSize: 14,
                      color: beige.withOpacity(0.8),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    crop['suitability'],
                    style: TextStyle(
                      fontSize: 14,
                      color: beige.withOpacity(0.8),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _temperatureController.dispose();
    _humidityController.dispose();
    _phController.dispose();
    _rainfallController.dispose();
    super.dispose();
  }
}
