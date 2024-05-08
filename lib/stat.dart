import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class Stat {
  String? name;
  String? type;
  String? qual;
  String? series;

    Stat({
      required this.name,
      required this.type,
      required this.qual,
      required this.series
    });

    Stat.fromJson(Map<String, dynamic> json) {
      name = json['jmfldnm'];
      type = json['obligfldnm'];
      qual = json['qualgbnm'];
      series = json['seriesnm'];
  }

  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String,dynamic>();

      data['jmfldnm'] = this.name;
      data['obligfldnm'] = this.type;
      data['qualgbnm'] = this.qual;
      data['seriesnm'] = this.series;
      return data;
  }
}

class Cardrepository {
  var apikey = "kzHGi2aum2RUN7TFM4CZb4uKbleWgTALT1qLMCn091jdx0nCQ2Wj9h9uspuGPp7zkI8cGMMmVq4sLPxEvODC1A%3D%3D";

  Future<List<Stat>?> loadCards() async {
    String url = "http://openapi.q-net.or.kr/api/service/rest/InquiryListNationalQualifcationSVC/getList?serviceKey=yeBlEyPYUpcvfhWu46aKhkHF5qWlqEHvfHA%2B9wfdI9D%2FLXYI8NNmfbh8AcKdfdCcF1%2BoLsl8mVKtLNvtCESn1A%3D%3D&";
    final response = await http.get(Uri.parse(url));

    print('respone = $response');

    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);
      //print('xml: $body');

      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      //print('json: $json');

      Map<String, dynamic> jsonResult = convert.jsonDecode(json)['response']['body']['items'];
      List<dynamic> list = jsonResult['item'];

      //Map<String, dynamic> jsonResult = convert.json.decode(json);
      //final jsonCard = jsonResult['response']['body']['items'];

      //print(jsonCard['item']);

      //print(jsonResult);

      return list.map<Stat>((e) => Stat.fromJson(e)).toList();
      /*
      if(jsonCard['item'] != null) {
        List<dynamic> list = jsonCard['item'];
        print(list.map<Stat>((item) => Stat.fromJson(item)).toList());

        return list.map<Stat>((item) => Stat.fromJson(item)).toList();
      }

       */
    }
  }
}