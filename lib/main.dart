import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/views/Homepage.dart';
import 'package:provider/provider.dart';
import 'services/theme.dart';

void main() async {
  Box box = await _openCacheBox();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => NewsNotifier(box: box)..getNews()),
  ], child: MyApp()));
}

// This function performs initial setup for this app.
Future<Box> _openCacheBox() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final cachedDataBox = await Hive.openBox('cachedResponses');
  return cachedDataBox;
}

// Change the API key in the news.dart file to have more APi calls , since this key is already in use . You may not get quick response or get no response.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      home: HomePage(),
    );
  }
}
