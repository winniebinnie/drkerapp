import 'package:flutter/material.dart';
import 'package:drkerapp/pages/explore/widgets/youtube_section.dart';
import 'package:drkerapp/pages/explore/widgets/library_section.dart';
import 'package:drkerapp/pages/explore/widgets/blog_section.dart';
import 'package:drkerapp/widgets/top_bar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
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
