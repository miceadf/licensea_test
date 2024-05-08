import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_prac/stat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '자격증 API',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
      ),
      home: const MyHomePage(title: '자격증API Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String authKey = 'yeBlEyPYUpcvfhWu46aKhkHF5qWlqEHvfHA+9wfdI9D/LXYI8NNmfbh8AcKdfdCcF1+oLsl8mVKtLNvtCESn1A==';

  List<Stat>? statData = List.empty(growable: true);

  Cardrepository provider = Cardrepository();
  bool isLoading = true;

  void initCard() async {
    statData = await provider.loadCards();
    print(statData);
  }

  ImageProvider<Object> getImage(String? imagePath) {
    if(imagePath != null && imagePath.length > 10) {
      print(imagePath);
      return NetworkImage(imagePath);
    } else {
      return const AssetImage("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              initCard();
            }, child: const Text('Get data from openAPI')),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  child: Row(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 100.0,
                      height: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            statData![index].name.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      //decoration: BoxDecoration(
                      //    shape: BoxShape.rectangle,
                      //    border: Border.all(color: Colors.black, width: 1),
                      //),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            statData![index].type.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            statData![index].qual.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            statData![index].series.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],),
                ),
              );
            },
              itemCount: statData?.length,
            ),
            )
          ],
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  _NewsScreenState createState() {
    return new _NewsScreenState();
  }
}

class _NewsScreenState extends State<Home> {

  Cardrepository provider = Cardrepository();
  List<Stat>? card = [];
  bool isLoading = true;

  Future initCard() async {
    card = await provider.loadCards();
    print(card);
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      initCard();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("자격증"),
      ),
      body: isLoading ? Center(child: const CircularProgressIndicator(),) :
      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
      ),
          itemCount: card?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(card![index].name.toString()),
                  Text(card![index].type.toString()),
                ],
              ),
            );
          }),
    );
  }
}
*/