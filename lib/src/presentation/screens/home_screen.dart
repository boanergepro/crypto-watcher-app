import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/presentation/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeController>().getCurrencies();
    context.read<HomeController>().establishSocketConnectionTicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              // list of currencies
              Consumer<HomeController>(
                builder: (context, state, _) {
                  return DropdownButton<Currency>(
                    value: state.currencyValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (Currency? value) {
                      if (value != null) {
                        setState(() {
                          state.currencyValue = value;
                        });
                        state.getCurrenciesPrices(symbol: value.symbol, interval: '1d');
                      }

                    },
                    items: state.listCurrencies.map<DropdownMenuItem<Currency>>((Currency value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(value.symbol),
                      );
                    }).toList(),
                  );
                },
              ),

              // chart
              Consumer<HomeController>(
                builder: (context, state, _) {

                  return SfCartesianChart(
                    key: UniqueKey(),
                    primaryXAxis: DateTimeAxis(),
                    series: [
                      CandleSeries<Candlestick, DateTime>(
                        dataSource: state.listCurrenciesPrices,
                        xValueMapper: (Candlestick data, _) => data.time,
                        lowValueMapper: (Candlestick data, _) => data.low,
                        highValueMapper: (Candlestick data, _) => data.high,
                        openValueMapper: (Candlestick data, _) => data.open,
                        closeValueMapper: (Candlestick data, _) => data.close,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
