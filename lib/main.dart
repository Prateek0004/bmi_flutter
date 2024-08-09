import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: const MyHomePage(title: 'BMI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();

  var result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BMI Calculator",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 26),
            TextField(
              controller: ftController,
              decoration: InputDecoration(
                labelText: 'Enter your height (feet)',
                prefixIcon: Icon(Icons.straighten),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: inchController,
              decoration: InputDecoration(
                labelText: 'Enter your height (inches)',
                prefixIcon: Icon(Icons.straighten),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: wtController,
              decoration: InputDecoration(
                labelText: 'Enter your weight (kg)',
                prefixIcon: Icon(Icons.line_weight),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 26),
            ElevatedButton(
              onPressed: () {
                // BMI calculation logic
                var wt = wtController.text.toString();
                var ft = ftController.text.toString();
                var inch = inchController.text.toString();

                if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                  try {
                    double weight = double.parse(wt);
                    double feet = double.parse(ft);
                    double inches = double.parse(inch);

                    // Convert height to meters
                    double totalInches = (feet * 12) + inches;
                    double heightInMeters = totalInches * 0.0254;

                    // Calculate BMI
                    double bmi = weight / (heightInMeters * heightInMeters);

                    setState(() {
                      result = "Your BMI is ${bmi.toStringAsFixed(2)}";
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter valid numeric values!"),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("All fields are mandatory!"),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            Text(
              result,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
