import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hw1/src/newsapp/theme/theme_provider.dart';
import 'package:hw1/src/newsapp/web_module.dart';
import 'package:provider/provider.dart';
import '../model/news_model.dart';
import 'row_item.dart';

class NewsScreen extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const NewsScreen({super.key, required this.onThemeChanged});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Big Brother News",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          actions: [
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              activeColor: Colors.indigo,
            ),
          ],
          centerTitle: true,
          backgroundColor: HexColor("#00807f"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 5.0,
            ),
          ),
        ),
        body: BodyWidget(scrollController: _scrollController,),
        bottomNavigationBar: TabBar(controller: _tabController, tabs: [
          Tab(
              icon: Icon(
            Icons.upgrade_sharp,
            color: HexColor("#00807f")
              ),
          ),
        ],
        onTap: (index) {_scrollController.jumpTo(0);}
        ),
      );
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  WebModule module = WebModule();

  late Future<List<News>> l = Future.value([]);

  void getNews() async {
    module.getNews();
    setState(() {
      l = Future.value(module.readNewsFromPrefs());
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
    widget.scrollController.addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) => FutureBuilder<List<News>>(
      future: l,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<News>? newsList = snapshot.data;
          return ListView.separated(
            itemBuilder: (context, index) => ColumnItem(newsList[index]),
            controller: widget.scrollController,
            separatorBuilder: (context, index) => const Divider(
              height: 70,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemCount: newsList!.length,
          );
        }
      });

  void _scrollListener() {
    if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent) {
      getNews();
      setState(() {});
    }
  }
}
