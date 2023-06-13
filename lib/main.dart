import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var passenger = [
      Sales("Sun", 50 , Colors.red),
      Sales("Mon", 70, Colors.green),
      Sales("Tue", 100, Colors.yellow),
      Sales("Wed", 50, Colors.pink),
      Sales("Thu", 145, Colors.purple),
      Sales("Fri", 190, Colors.brown),
      Sales("Sat", 300, Colors.orange),
    ];

    var foreignPassenger = [
      Sales("Sun", 70, Colors.red.shade200),
      Sales("Mon", 170, Colors.green.shade200),
      Sales("Tue", 150, Colors.yellow.shade200),
      Sales("Wed", 150, Colors.pink.shade200),
      Sales("Thu", 45, Colors.purple.shade200),
      Sales("Fri", 90, Colors.brown.shade200),
      Sales("Sat", 30, Colors.orange.shade200),
    ];

    var series = [
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        colorFn: (Sales sales, _) => sales.color,
        id: 'Local Sales',
        data: passenger,
        labelAccessorFn: (Sales sales, _) =>
            '${sales.day} : ${sales.sold.toString()}',
      ),
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        colorFn: (Sales sales, _) => sales.color,
        id: 'Foreign Sales',
        data: foreignPassenger,
        labelAccessorFn: (Sales sales, _) =>
            '${sales.day} : ${sales.sold.toString()}',
      ),
    ];

    var chart = charts.BarChart(
      series,
      barGroupingType: charts.BarGroupingType.grouped,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              "Angkasa Pura Passengers",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 400,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }
}

class Sales {
  final String day;
  final int sold;
  final charts.Color color;

  Sales(this.day, this.sold, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}