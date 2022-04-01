import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/get_prices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

String selectedCurrency = "USD";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CoinConverter BTC = CoinConverter(coinName: "BTC");
  CoinConverter ETH =CoinConverter(coinName: "ETH");
  CoinConverter LTC = CoinConverter(coinName: "LTC");
  Widget getIOSPicker(){
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex){
        selectedCurrency=currenciesList[selectedIndex];
      },
      children: currenciesList.map((e) => Text(e)).toList(),
    );
  }

  Widget getDropDownButton(){
    return DropdownButton(
        value: selectedCurrency,
        items: currenciesList.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
        onChanged: (value) async{
          setState(() {
        selectedCurrency = value.toString();
        BTC.convert(value.toString(), "BTC");
        ETH.convert(value.toString(), "ETH");
        LTC.convert(value.toString(), "LTC");
      });


    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ShowCoinValue(coin:"BTC",coinConverter: BTC,),
          ShowCoinValue(coin:"ETH",coinConverter: ETH,),
          ShowCoinValue(coin:"LTC",coinConverter: LTC,),
          const SizedBox(height: 300,),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isIOS? getIOSPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}

class ShowCoinValue extends StatelessWidget {
  const ShowCoinValue({
    Key? key,
    required this.coinConverter,
    required this.coin,
  }) : super(key: key);

  final String coin;
  final CoinConverter coinConverter;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = ${coinConverter.coinValue.truncate()} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

