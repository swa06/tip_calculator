import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TipsPlease',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyTipCalculator(
        title: 'My Tip Calculator',
        bill: 1000,
        tipPercentage: 12,
      ),
    );
  }
}

class MyTipCalculator extends StatefulWidget {
  final String title;
  final double bill;
  final double tipPercentage;

  const MyTipCalculator(
      {Key key, this.title, this.bill, this.tipPercentage})
      : super(key: key);

  @override
  _MyTipCalculatorState createState() => _MyTipCalculatorState();
}

class _MyTipCalculatorState extends State<MyTipCalculator> {
  TextEditingController _billController;
  TextEditingController _tipPercentageController;
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _billController = TextEditingController(text: widget.bill.toString());
    _tipPercentageController =
        TextEditingController(text: widget.tipPercentage.toString());
    _billController.addListener(_onBillChanged);
    _tipPercentageController.addListener(_onTipPercentageChanged);
    _setCalculatedAmounts();
  }

  void _setCalculatedAmounts() {
    _tipAmount = _getTipAmount();
    _totalAmount = _getBillAmount() + _tipAmount;
  }

  double _getTipAmount() {
    var _bill = _getBillAmount();
    var _tipPercentage = double.tryParse(_tipPercentageController.text) ?? 0.0;

    return (_tipPercentage * _bill) / 100;
  }

  double _getBillAmount() => double.tryParse(_billController.text) ?? 0.0;

  void _onBillChanged() {
    setState(() {
      _setCalculatedAmounts();
    });
  }

  void _onTipPercentageChanged() {
    setState(() {
      _setCalculatedAmounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _billController,
            decoration: InputDecoration(labelText: "Bill :"),
          ),
          TextFormField(
            controller: _tipPercentageController,
            decoration: InputDecoration(labelText: "Tip % :"),
          ),
          Text(
            'Tip Amount : ${_tipAmount.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'Total Amount : ${_totalAmount.toString()}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _billController.removeListener(_onBillChanged);
    _tipPercentageController.removeListener(_onTipPercentageChanged);
    _billController.dispose();
    _tipPercentageController.dispose();
    super.dispose();
  }
}
