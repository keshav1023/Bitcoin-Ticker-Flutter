import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

//url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=D104D3DF-4C51-4D58-8BAC-E8AB6E1F4914'
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'D104D3DF-4C51-4D58-8BAC-E8AB6E1F4914';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String cryptoCoin in cryptoList) {
      String requestURL =
          '$coinAPIURL/$cryptoCoin/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];

        cryptoPrices[cryptoCoin] = price.toStringAsFixed(0);
      } else {
        print('Problem with the get request ${response.statusCode}');
      }
    }
    return cryptoPrices;
  }
}
