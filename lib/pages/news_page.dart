import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my01_app/widgets/menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults = 0;
  bool isLoading = true;
  int page = 1;
  int pageSize = 5;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      articles.clear();
      page = 1;
    });
    _getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    if (page < (totalResults / pageSize).ceil()) {
      if (mounted) {
        setState(() {
          page = ++page;
          _getData();
        });
      }
    } else {
      _refreshController.loadNoData();
      _refreshController.resetNoData();
    }

    _refreshController.loadComplete();
  }

  void _getData() async {
    try {
      var queryParameters = {
        'country': 'th',
        'apiKey': '3fb9390ba4d54613915ffc19a3e2697e',
        'page': page.toString(),
        'pageSize': pageSize.toString()
      };
      var url = Uri.https('newsapi.org', '/v2/top-headlines', queryParameters);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //print(response.body);
        final news = convert.jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          articles.addAll(news['articles']);
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
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const MaterialClassicHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const Text("กำลังโหลดข่าว...");
                    } else if (mode == LoadStatus.loading) {
                      body = const CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("release to load more");
                    } else {
                      body = const Text("No more Data");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'newstack/webview',
                                arguments: {
                                  'url': articles[index]['url'],
                                  'name': articles[index]['source']['name']
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
                                      child:
                                          articles[index]['urlToImage'] != null
                                              ? Ink.image(
                                                  image: NetworkImage(
                                                      articles[index]
                                                          ['urlToImage']),
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 20),
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
                                                avatar: const Icon(
                                                    Icons.person_pin),
                                                label: articles[index]['author']
                                                            .length >
                                                        20
                                                    ? Text(articles[index]
                                                            ['author']
                                                        .substring(0, 10))
                                                    : Text(articles[index]
                                                        ['author']),
                                              )
                                            : const Text(""),
                                        Text(DateFormat.yMMMd()
                                            .add_Hms()
                                            .format(DateTime.parse(
                                                articles[index]
                                                    ['publishedAt'])))
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
      ),
    );
  }
}
