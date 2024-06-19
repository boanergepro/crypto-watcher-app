import 'package:cripto_wacher/src/presentation/controllers/binance/binance_controller.dart';
import 'package:cripto_wacher/src/presentation/widgets/items/item_list_currency.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<BinanceController>().establishSocketConnectionTicker();
    context.read<BinanceController>().getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'CriptoWacher',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // logout
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            // list of currencies updated in the last 24h
            const SizedBox(
              height: 15,
            ),
            const Text(
              'List of the cryptocurrencies that have experienced the highest changes in the last 24 hours.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Consumer<BinanceController>(
                builder: (context, state, _) {
                  return ListView.builder(
                    itemCount: state.listCrypto.length,
                    itemBuilder: (context, index) {
                      final crypto = state.listCrypto[index];

                      return ItemListCurrency(
                        onPressed: () {
                          state.goToDetail(crypto: crypto, context: context);
                        },
                        cryptoModel: state.listCrypto[index],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
