import 'package:flutter/material.dart';
import '../models/webtoon_models.dart';

class WebtoonItem extends StatefulWidget {
  final WebtoonModel model;
  bool isFavorite;

  WebtoonItem({super.key, required this.model, required this.isFavorite});

  @override
  State<WebtoonItem> createState() => _WebtoonItemState();
}

class _WebtoonItemState extends State<WebtoonItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.model.id,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 330,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color.fromARGB(0x55, 0x00, 0x00, 0x00),
                        offset: Offset(10, 10),
                      )
                    ],
                  ),
                  child: Image.network(
                    widget.model.thumb,
                    headers: {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(widget.model.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
            ],
          ),
        ),
        widget.isFavorite
            ? Positioned(
                left: 330,
                top: 120,
                child: Icon(Icons.favorite, size: 60, color: Colors.red))
            : Container(),
      ],
    );
  }
}
