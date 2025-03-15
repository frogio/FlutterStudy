import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_models.dart';
import '../services/api_service.dart';
import '../widgets/webtoon_item.dart';
import 'package:toonflix/screens/episode_screen.dart';

class HomeScreen extends StatefulWidget {
  List<String>? favoriteMarks;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _SharedPrefFavoriteKey = "FAVORITE";

  Future<void> getFavorite() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs != null) {
      setState(() {
        widget.favoriteMarks =
            sharedPrefs.getStringList(_SharedPrefFavoriteKey);
        if (widget.favoriteMarks == null) widget.favoriteMarks = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFavorite();
  }

  // List<WebtoonModel> webtoons = [];
  Widget buildList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool isFavorite = false;
            if (widget.favoriteMarks != null) {
              isFavorite =
                  widget.favoriteMarks!.contains(snapshot.data[index].id);
            }
            // print(isFavorite);
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EpisodeScreen(model: snapshot.data[index]),
                        fullscreenDialog: true,
                      )).then((_) {
                    // This runs when Screen A is shown again
                    setState(() {
                      getFavorite();
                    });
                  });
                },
                child: WebtoonItem(
                  model: snapshot.data[index],
                  isFavorite: isFavorite,
                ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 30);
          },
          itemCount: snapshot.data!.length);
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).appBarTheme.shadowColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        title: Center(
          child: Text(
            "오늘의 웹툰",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: APIService.getInstance().getTodayWebtoonList(),
                builder: buildList),
          )
        ],
      ),
    );
  }
}
