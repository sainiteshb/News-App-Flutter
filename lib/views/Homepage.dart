import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/widgets.dart';
import 'package:provider/provider.dart';
import '../services/theme.dart';
import '../services/news.dart';
import 'package:flutter_fadein/flutter_fadein.dart';


class HomePage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Trends',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.red, fontSize: 30.0),
              )),
          centerTitle: true,
          actions: [
            IconButton(
                splashRadius: 25.0,
                icon: theme.myTheme == MyTheme.Light
                    ? Icon(
                        Icons.wb_sunny,
                      )
                    : Icon(FontAwesomeIcons.solidMoon),
                onPressed: () => theme.switchTheme()),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  child: Text(
                    'Latest News Headlines',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 25.0)),
                  ),
                ),
              ),
              FutureBuilder(
                future: news.getNews(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final newslist = snapshot.data;
                    return Container(
                      margin: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: newslist.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FadeIn(
                                child: NewsTile(
                                  imgUrl: newslist[index].urlToImage ?? "",
                                  title: newslist[index].title ?? "",
                                  desc: newslist[index].description ?? "",
                                  content: newslist[index].content ?? "",
                                  posturl: newslist[index].articleUrl ?? "",
                                ),
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("There was some error"),
                    );
                  }
                  // Loading
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerWidget(
                                  200.0, MediaQuery.of(context).size.width),
                              SizedBox(
                                height: 8.0,
                              ),
                              shimmerLine(MediaQuery.of(context).size.width),
                              SizedBox(
                                height: 10.0,
                              ),
                              shimmerLine(
                                  MediaQuery.of(context).size.width * 0.5)
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerWidget(
                                  200.0, MediaQuery.of(context).size.width),
                              SizedBox(
                                height: 8.0,
                              ),
                              shimmerLine(MediaQuery.of(context).size.width),
                              SizedBox(
                                height: 10.0,
                              ),
                              shimmerLine(
                                  MediaQuery.of(context).size.width * 0.5)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}