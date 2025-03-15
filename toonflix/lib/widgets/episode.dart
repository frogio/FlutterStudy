import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode.dart';
import '../models/webtoon_models.dart';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatefulWidget {
  WebtoonEpisode episode;
  WebtoonModel model;
  int animationOrder;

  Episode(
      {super.key,
      required this.model,
      required this.episode,
      required this.animationOrder});

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void onTabEpisode() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=${widget.model.id}&no=${widget.episode.id}");
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween(begin: 700.0 * (widget.animationOrder % 3 + 1), end: 0.0)
        .animate(controller);
    animation.addListener(() {
      // print(animation.value);
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabEpisode,
      child: Transform.translate(
        offset: Offset(animation.value, 0),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color.fromARGB(0x55, 0x00, 0x00, 0x00),
                  offset: Offset(10, 10),
                )
              ],
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade200),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Image.network(
                width: double.infinity,
                fit: BoxFit.cover,
                widget.episode.thumb,
                headers: {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                  child: Container(
                      width: double.infinity,
                      height: 30,
                      color: Colors.black.withOpacity(0)),
                ),
              ),
              Positioned(
                left: 15,
                top: 3,
                child: Text(
                  widget.episode.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize:
                          Theme.of(context).textTheme.displayMedium!.fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
