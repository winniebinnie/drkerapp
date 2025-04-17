import 'package:drkerapp/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'dart:convert';
import 'read_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExplorePage(),
    ReadPage(),
    const SearchPage(),
    Center(child: Text('Search Page')), // Placeholder
    Center(child: Text('Profile Page')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF006FFD),
        unselectedItemColor: const Color(0xFF71727A),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Read'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBlogSection(),
                _buildYouTubeSection(),
                _buildLibrarySection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              height: 40,
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ค้นหา...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              print("Menu icon tapped");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlogSection() {
    return FutureBuilder<String>(
      future: BlogService.fetchLatestBlogPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text('เกิดข้อผิดพลาดในการโหลดบทความ: \${snapshot.error}'),
          );
        } else {
          return Container(
            width: double.infinity,
            height: 300,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'โพสต์ล่าสุดใน DrKerBlog',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF1F2024),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF494A50),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildYouTubeSection() {
    return _buildHorizontalCardList(
      title: 'DrKerYouTube',
      cards: [
        _buildVideoCard(
          title: 'พระธรรมกันดารวิถี บทที่ 2',
          imageUrl: 'https://placehold.co/200x112',
        ),
        _buildVideoCard(
          title: 'คำเทศนา พระคุณอันยิ่งใหญ่',
          imageUrl: 'https://placehold.co/200x112',
        ),
        _buildVideoCard(
          title: 'พระธรรมโยบ บทที่ 19',
          imageUrl: 'https://placehold.co/200x112',
        ),
      ],
    );
  }

  Widget _buildLibrarySection() {
    return _buildHorizontalCardList(
      title: 'DrKerLibrary',
      cards: [
        _buildVideoCard(
          title: '“ไม้ทั้งท่อนที่อยู่ในตา” หมายถึงอะไร?',
          imageUrl: 'https://placehold.co/200x112',
        ),
        _buildVideoCard(
          title: 'ความถ่อมตัว คืออะไร?',
          imageUrl: 'https://placehold.co/198x111',
        ),
        _buildVideoCard(
          title: 'จะแยกแยะได้อย่างไรว่า...',
          imageUrl: 'https://placehold.co/200x112',
        ),
      ],
    );
  }

  Widget _buildHorizontalCardList({
    required String title,
    required List<Widget> cards,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
                const Text(
                  'See more',
                  style: TextStyle(
                      color: Color(0xFF006FFD),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => cards[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard({required String title, required String imageUrl}) {
    return Container(
      width: 213,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2024),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogService {
  static const String apiUrl = 'https://drkerministry.home.blog/wp-json/wp/v2/posts';

  static Future<String> fetchLatestBlogPost() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final post = data[0];
        final title = post['title']['rendered'];
        final content = post['content']['rendered'];
        return '\${title}\n\n\${_stripHtml(content)}';
      }
    }
    throw Exception('ไม่สามารถโหลดโพสต์ล่าสุดได้');
  }

  static String _stripHtml(String htmlContent) {
    final document = html_parser.parse(htmlContent);
    return document.body?.text.trim() ?? '';
  }
}