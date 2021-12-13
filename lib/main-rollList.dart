// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// // #docregion MyApp
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       theme: ThemeData(
//         // Add the 5 lines from here...
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//       ), // ... to here.
//       home: RandomWords(),
//     );
//   }
// }
// // #enddocregion build

// // #enddocregion MyApp

// // #docregion RWS-var
// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18.0);
//   final _biggerFont1 = const TextStyle(fontSize: 28.0);
//   final _saved = <WordPair>{}; // NEW
//   void _pushSaved() {
//     Navigator.of(context).push(
//       // Add lines from here...
//       MaterialPageRoute<void>(
//         builder: (context) {
//           final tiles = _saved.map(
//             (pair) {
//               return ListTile(
//                 title: Text(
//                   pair.asPascalCase,
//                   style: _biggerFont,
//                 ),
//               );
//             },
//           );
//           final divided = tiles.isNotEmpty
//               ? ListTile.divideTiles(
//                   context: context,
//                   tiles: tiles,
//                 ).toList()
//               : <Widget>[];

//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('收藏列表'),
//             ),
//             body: ListView(children: divided),
//           );
//         },
//       ), // ...to here.
//     );
//   }

//   // #enddocregion RWS-var
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('总列表'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.list),
//             onPressed: _pushSaved,
//             tooltip: '总列表',
//           ),
//         ],
//       ),
//       body: _buildSuggestions(),
//     );
//   }

//   // #docregion _buildSuggestions
//   Widget _buildSuggestions() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: /*1*/ (context, i) {
//           if (i.isOdd) return const Divider(); /*2*/

//           final index = i ~/ 2; /*3*/
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//           }
//           // if (i % 2 == 0) {
//           //   return _buildRow1(_suggestions[index + 1]);
//           // }
//           return _buildRow(_suggestions[index]);
//         });
//   }
//   // #enddocregion _buildSuggestions

//   // #docregion _buildRow
//   Widget _buildRow(WordPair pair) {
//     final alreadySaved = _saved.contains(pair); // 是否存在该元素
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//       trailing: Icon(
//         alreadySaved ? Icons.favorite : Icons.favorite_border, // 切换图形
//         color: alreadySaved ? Colors.red : null, // 切换颜色
//         semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
//       ),
//       onTap: () {
//         // NEW lines from here...
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(pair);
//           } else {
//             _saved.add(pair);
//           }
//         });
//       },
//     );
//   }

//   Widget _buildRow1(WordPair pair) {
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont1,
//       ),
//     );
//   }
//   // #enddocregion _buildRow

//   // #docregion RWS-build
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text('Startup Name Generator'),
//   //     ),
//   //     body: _buildSuggestions(),
//   //   );
//   // }
//   // #enddocregion RWS-build
//   // #docregion RWS-var
// }
// // #enddocregion RWS-var

// class RandomWords extends StatefulWidget {
//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }
