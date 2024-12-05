import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(ElectronicsHelperApp());
}

class ElectronicsHelperApp extends StatefulWidget {
  @override
  _ElectronicsHelperAppState createState() => _ElectronicsHelperAppState();
}

class _ElectronicsHelperAppState extends State<ElectronicsHelperApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronics Helper',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signing in...')),
      );

      // Navigate to the home page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Electronics Helper')),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _buildClickableCard(
                title: 'Resistor Color Code Calculator',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResistorCalculator()),
                ),
              );
            case 1:
              return _buildClickableCard(
                title: 'Ohm\'s Law Calculator',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OhmsLawCalculator()),
                ),
              );
            case 2:
              return _buildClickableCard(
                title: 'Unit Conversion Tool',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnitConverter()),
                ),
              );
            case 3:
              return _buildClickableCard(
                title: 'Power Calculator',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PowerCalculator()),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _buildClickableCard({
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.blue.withAlpha(30),
        highlightColor: Colors.blue.withAlpha(100),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Resistor Color Code Calculator
class ResistorCalculator extends StatefulWidget {
  @override
  _ResistorCalculatorState createState() => _ResistorCalculatorState();
}

class _ResistorCalculatorState extends State<ResistorCalculator> {
  final _band1Controller = TextEditingController();
  final _band2Controller = TextEditingController();
  final _band3Controller = TextEditingController();
  final _band4Controller = TextEditingController();

  String _resistorValue = '';

  final Map<String, int> _colorMap = {
    'black': 0,
    'brown': 1,
    'red': 2,
    'orange': 3,
    'yellow': 4,
    'green': 5,
    'blue': 6,
    'violet': 7,
    'gray': 8,
    'white': 9
  };

  final Map<String, int> _multiplierMap = {
    'black': 1,
    'brown': 10,
    'red': 100,
    'orange': 1000,
    'yellow': 10000,
    'green': 100000,
    'blue': 1000000,
    'violet': 10000000,
    'gray': 100000000,
    'white': 1000000000
  };

  void _calculateResistorValue() {
    String band1 = _band1Controller.text.toLowerCase();
    String band2 = _band2Controller.text.toLowerCase();
    String band3 = _band3Controller.text.toLowerCase();
    String band4 = _band4Controller.text.toLowerCase();

    if (_colorMap.containsKey(band1) &&
        _colorMap.containsKey(band2) &&
        _multiplierMap.containsKey(band3)) {
      int digit1 = _colorMap[band1]!;
      int digit2 = _colorMap[band2]!;
      int multiplier = _multiplierMap[band3]!;

      int value = (digit1 * 10 + digit2) * multiplier;

      setState(() {
        _resistorValue = '${value} Ohms';
      });
    } else {
      setState(() {
        _resistorValue = 'Invalid color code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resistor Color Code Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _band1Controller,
              decoration: InputDecoration(
                labelText: 'Enter 1st Color Band',
                hintText: 'e.g., Red, Brown, Blue',
              ),
            ),
            TextField(
              controller: _band2Controller,
              decoration: InputDecoration(
                labelText: 'Enter 2nd Color Band',
                hintText: 'e.g., Orange, Yellow, Green',
              ),
            ),
            TextField(
              controller: _band3Controller,
              decoration: InputDecoration(
                labelText: 'Enter 3rd Color Band (Multiplier)',
                hintText: 'e.g., Red, Green, Blue',
              ),
            ),
            TextField(
              controller: _band4Controller,
              decoration: InputDecoration(
                labelText: 'Enter 4th Color Band (Tolerance)',
                hintText: 'e.g., Gold, Silver (Optional)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateResistorValue,
              child: Text('Calculate Resistor Value'),
            ),
            SizedBox(height: 20),
            Text(
              'Resistor Value: $_resistorValue',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Ohm's Law Calculator
class OhmsLawCalculator extends StatefulWidget {
  @override
  _OhmsLawCalculatorState createState() => _OhmsLawCalculatorState();
}

class _OhmsLawCalculatorState extends State<OhmsLawCalculator> {
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _resistanceController = TextEditingController();

  String _result = '';

  void _calculateOhmsLaw() {
    double voltage = double.tryParse(_voltageController.text) ?? 0;
    double current = double.tryParse(_currentController.text) ?? 0;
    double resistance = double.tryParse(_resistanceController.text) ?? 0;

    if (voltage != 0 && current != 0) {
      resistance = voltage / current;
    } else if (voltage != 0 && resistance != 0) {
      current = voltage / resistance;
    } else if (current != 0 && resistance != 0) {
      voltage = current * resistance;
    }

    setState(() {
      _result = 'Voltage: $voltage V, Current: $current A, Resistance: $resistance Ω';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ohm\'s Law Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _voltageController,
              decoration: InputDecoration(
                labelText: 'Voltage (V)',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _currentController,
              decoration: InputDecoration(
                labelText: 'Current (A)',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _resistanceController,
              decoration: InputDecoration(
                labelText: 'Resistance (Ω)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateOhmsLaw,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// Unit Conversion Tool
class UnitConverter extends StatefulWidget {
@override
_UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final _valueController = TextEditingController();
  double? _result;

  final List<String> _units = ['Volts', 'Amps', 'Ohms', 'Watts'];
  String _fromUnit = 'Volts';
  String _toUnit = 'Amps';

  void _convert() {
    double? value = double.tryParse(_valueController.text);
    if (value != null) {
      double conversionFactor = _getConversionFactor(_fromUnit, _toUnit, value);
      setState(() {
        _result = conversionFactor;
      });
    }
  }

  double _getConversionFactor(String fromUnit, String toUnit, double value) {
    if (fromUnit == 'Volts' && toUnit == 'Amps') {
      // Calculate current (I) = Voltage (V) / Resistance (R)
      return value / 1; // For simplicity, assuming resistance of 1 Ohm
    } else if (fromUnit == 'Amps' && toUnit == 'Volts') {
      // Calculate voltage (V) = Current (I) * Resistance (R)
      return value * 1; // Assuming resistance of 1 Ohm
    } else if (fromUnit == 'Volts' && toUnit == 'Watts') {
      // Calculate power (W) = Voltage (V) * Current (I)
      return value * 1; // Assuming current of 1 Amp
    } else if (fromUnit == 'Watts' && toUnit == 'Volts') {
      // Calculate voltage (V) = Power (W) / Current (I)
      return value / 1; // Assuming current of 1 Amp
    } else if (fromUnit == 'Amps' && toUnit == 'Watts') {
      // Calculate power (W) = Current (I) * Voltage (V)
      return value * 1; // Assuming voltage of 1 Volt
    } else if (fromUnit == 'Watts' && toUnit == 'Amps') {
      // Calculate current (I) = Power (W) / Voltage (V)
      return value / 1; // Assuming voltage of 1 Volt
    } else if (fromUnit == 'Ohms' && toUnit == 'Volts') {
      // Calculate voltage (V) = Current (I) * Resistance (R)
      return value * 1; // Assuming current of 1 Amp
    } else if (fromUnit == 'Volts' && toUnit == 'Ohms') {
      // Calculate resistance (R) = Voltage (V) / Current (I)
      return value / 1; // Assuming current of 1 Amp
    } else {
      return value; // If no conversion is applied, return the original value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Enter value to convert',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: ${_result ?? "Invalid input"}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}


class PowerCalculator extends StatefulWidget {
  @override
  _PowerCalculatorState createState() => _PowerCalculatorState();
}


class _PowerCalculatorState extends State<PowerCalculator> {
  final TextEditingController _voltageController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _resistanceController = TextEditingController();
  String _result = '';
  String _selectedFormula = 'P = V × I';

  void _calculatePower() {
    final double? voltage = double.tryParse(_voltageController.text);
    final double? current = double.tryParse(_currentController.text);
    final double? resistance = double.tryParse(_resistanceController.text);

    double? power;

    switch (_selectedFormula) {
      case 'P = V × I':
        if (voltage != null && current != null) {
          power = voltage * current;
        }
        break;
      case 'P = I² × R':
        if (current != null && resistance != null) {
          power = pow(current, 2) * resistance;
        }
        break;
      case 'P = V² / R':
        if (voltage != null && resistance != null) {
          power = pow(voltage, 2) / resistance;
        }
        break;
    }

    setState(() {
      if (power != null) {
        _result = 'Power: ${power.toStringAsFixed(2)} W';
      } else {
        _result = 'Please enter valid inputs for the selected formula.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electronics Power Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedFormula,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFormula = newValue!;
                });
              },
              items: <String>['P = V × I', 'P = I² × R', 'P = V² / R']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _voltageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Voltage (V)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _currentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Current (I)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _resistanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Resistance (R)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculatePower,
              child: const Text('Calculate Power'),
            ),
            const SizedBox(height: 16),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _voltageController.dispose();
    _currentController.dispose();
    _resistanceController.dispose();
    super.dispose();
  }
}