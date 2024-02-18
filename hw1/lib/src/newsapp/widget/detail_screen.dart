import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../model/news_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsScreen extends StatelessWidget {
  final News news;

  // Конструктор для передачи данных
  const DetailsScreen(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title, style: const TextStyle(fontSize: 12)),
      ),
      body: Center(
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
              _Subtitle(news.content),
              const SizedBox(height: 8),
              _TextButton(news),
            ],
          ),
        ),
      ),
    );
  }
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
          fit: BoxFit.fill,
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
  final String price;

  const _Subtitle(this.price);

  @override
  Widget build(BuildContext context) => Text(
        price,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      );
}

class _TextButton extends StatelessWidget {
  final News news;

  const _TextButton(this.news);

  Future<void> _launchURL() async {
    await launchUrlString(news.url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) => TextButton.icon(
        onPressed: () {
          _launchURL();
        },
        icon: const Icon(Icons.insert_link),
        label: Text(AppLocalizations.of(context)?.visit ?? "Visit source"),
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color?>(
                Theme.of(context).textTheme.bodyLarge?.color)),
      );
}
