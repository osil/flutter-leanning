import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my01_app/widgets/menu.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults = 0;
  bool isLoading = true;
  _getData() async {
    try {
      final queryParameters = {
        'country': 'th',
        'apiKey': '3fb9390ba4d54613915ffc19a3e2697e'
      };
      var url = Uri.https('newsapi.org', '/v2/top-headlines', queryParameters);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //print(response.body);
        final news = convert.jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          articles = news['articles'];
          totalResults = news['totalResults'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("error api ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuItem(),
      appBar: AppBar(
        title: totalResults > 0
            ? Text("ข่าวสาร ${totalResults.toString()}")
            : null,
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'newstack/webview',arguments: {
                          'url' : articles[index]['url'],
                          'name' : articles[index]['source']['name']
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: articles[index]['urlToImage'] != null
                                      ? Ink.image(
                                          image: NetworkImage(
                                              articles[index]['urlToImage']),
                                          fit: BoxFit.cover,
                                        )
                                      : Ink.image(
                                          image: const NetworkImage(
                                              'https://picsum.photos/500/200'),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        articles[index]['source']['name'],
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(articles[index]['title']),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    articles[index]['author'] != null
                                        ? Chip(
                                            avatar:
                                                const Icon(Icons.person_pin),
                                            label: articles[index]['author']
                                                        .length >
                                                    20
                                                ? Text(articles[index]['author']
                                                    .substring(0, 10))
                                                : Text(
                                                    articles[index]['author']),
                                          )
                                        : const Text(""),
                                    Text(DateFormat.yMMMd().add_Hms().format(
                                        DateTime.parse(
                                            articles[index]['publishedAt'])))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: articles.length),
      ),
    );
  }
}
