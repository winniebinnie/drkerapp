import 'package:flutter/material.dart';
import 'package:drkerapp/pages/explore/widgets/blog_section.dart';
import 'package:drkerapp/pages/explore/widgets/library_section.dart';
import 'package:drkerapp/pages/explore/widgets/youtube_section.dart';
import 'package:drkerapp/widgets/top_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlogSection(),
                    YouTubeSection(),
                    LibrarySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
