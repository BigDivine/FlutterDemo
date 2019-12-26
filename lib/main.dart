import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(title: 'Welcome to Flutter', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final words = <WordPair>[];
  final Set<WordPair> saved = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.list),
              onPressed: pushSaved,
            )
          ],
        ),
        body: ListView.builder(itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          if (index >= words.length) {
            words.addAll(generateWordPairs().take(10));
          }
          return ListTile(
            title: Text(words[index].asLowerCase),
            trailing: Icon(
              saved.contains(words[index])
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: saved.contains(words[index]) ? Colors.red : null,
            ),
            onTap: () {
              // 调用 setState() 会为 State 对象触发 build() 方法，从而导致对 UI 的更新
              setState(() {
                if (saved.contains(words[index])) {
                  saved.remove(words[index]);
                } else {
                  saved.add(words[index]);
                }
              });
            },
          );
        }));
  }

  void pushSaved() {
    Route route = new MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = saved.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();
        return Scaffold(
            appBar: AppBar(
              title: Text('child Page'),
            ),
            body: ListView(
              children: divided,
            ));
      },
    );
    Navigator.push(context, route);
  }
}
