import 'package:flutter/material.dart';

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
class UnitConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Conversion Tool')),
      body: Center(
        child: Text('Unit Conversion Tool Coming Soon'),
      ),
    );
  }
}

class PowerCalculator extends StatefulWidget {
  @override
  _PowerCalculatorState createState() => _PowerCalculatorState();
}

class _PowerCalculatorState extends State<PowerCalculator> {
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();

  String _powerResult = '';

  void _calculatePower() {
    double voltage = double.tryParse(_voltageController.text) ?? 0;
    double current = double.tryParse(_currentController.text) ?? 0;

    setState(() {
      double power = voltage * current;
      _powerResult = 'Power: $power Watts';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Power Calculator')),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculatePower,
              child: Text('Calculate Power'),
            ),
            SizedBox(height: 20),
            Text(
              _powerResult,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}