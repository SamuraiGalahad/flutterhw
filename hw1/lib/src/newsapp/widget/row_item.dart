import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:hw1/src/newsapp/widget/detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/news_model.dart';

class ColumnItem extends StatelessWidget {
  final News news;

  const ColumnItem(
    this.news, {
    super.key,
  });

  // Start padding + avatar width + padding to text
  static const double indent = 20 + 68 + 16;

  // End padding
  static const double endIndent = 14.0;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 14, 8),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _Avatar(news),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: _Title(news.name),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _Subtitle(news.title),
              const SizedBox(height: 8),
              _TextButton(news),
            ],
          ),
        ),
      );
}

class _Avatar extends StatelessWidget {
  final News news;

  const _Avatar(this.news);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: 370,
        height: 300,
        child: CachedNetworkImage(
          imageUrl: news.urlToImage,
          fit: BoxFit.cover,
          width: 370,
          height: 300,
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(),
          errorWidget: (context, url, error) => Image.asset(
            "./images/95_icon.png",
            fit: BoxFit.fill,
            width: 370,
            height: 300,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );
}

class _Subtitle extends StatelessWidget {
  final String text;

  const _Subtitle(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );
}

class _TextButton extends StatelessWidget {
  const _TextButton(this.news);
  final News news;

  @override
  Widget build(BuildContext context) => Button95(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                news,
              ),
            ),
          );
        },
        child: Text(AppLocalizations.of(context)?.view ?? "View"),
      );
}
