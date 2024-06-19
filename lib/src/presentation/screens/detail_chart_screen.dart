import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/presentation/controllers/binance/binance_controller.dart';
import 'package:cripto_wacher/src/presentation/widgets/items/item_interval.dart';
import 'package:cripto_wacher/src/presentation/widgets/items/item_list_currency.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailChartScreen extends StatelessWidget {
  const DetailChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.read<BinanceController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          state.cryptoSelected?.cryptoName ?? '',
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Theme.of(context).primaryColor
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: ItemListCurrency(
                cryptoModel: state.cryptoSelected!,
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // filter by chart
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<BinanceController>(
                    builder: (context, state, _) {
                      return Container(
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<Currency>(
                          value: state.currencyValue,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).primaryColor,
                          ),
                          elevation: 16,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          onChanged: (Currency? value) {
                            if (value != null) {
                              state.currencyValue = value;

                              state.getCurrenciesPrices(
                                  symbol: value.symbol,
                                  interval: state.intervalSelected);
                            }
                          },
                          items: state.listCurrencies
                              .map<DropdownMenuItem<Currency>>(
                                  (Currency value) {
                            return DropdownMenuItem<Currency>(
                              value: value,
                              child: Text(value.symbol),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  Consumer<BinanceController>(
                    builder: (context, state, _) {
                      return Row(
                        children: List.generate(
                          intervals.length,
                          (index) => ItemInterval(
                            onPressed: () {
                              state.setInterval(intervals[index]);
                            },
                            isActive:
                                state.intervalSelected == intervals[index],
                            label: intervals[index],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // chart
            Consumer<BinanceController>(
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
    );
  }
}
