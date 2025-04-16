import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
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
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
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
          // Menu Icon
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
    return Container(
      width: double.infinity,
      height: 300, // Fixed height
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
              child: const Text(
                '''3 ข้อล้ำลึก ใน สุภาษิต 20

คน​เกียจ​คร้าน​ไม่​ไถ​นา​ใน​หน้า​นา
พอถึงฤดู​เกี่ยว ​เขา​จะ​มอง​หา​พืช​ผล​ แต่​ไม่​พบ​อะไร​เลย (ข้อ 4)
ถ้าไม่หว่าน ก็จะไม่ได้เก็บเกี่ยว

วันนี้ ถ้าเราไม่ลงทุนในฝ่ายวิญญาณ
เมื่อวันแห่งการให้บำเหน็จมาถึง ไม่ว่าเราจะพยายามมองหาเพียงใด
อาจไม่พบบำเหน็จเลยก็เป็นได้
[อยากได้รับผลในฝ่ายวิญญาณ ต้องลงทุนในฝ่ายวิญญาณ]

แผน​งาน​ของคนคนเดียว ย่อมมีช่องโหว่มาก
แต่โดยการรับฟัง​คำ​แนะ​นำ คำชี้แนะ แผนงานนั้นจะรัดกุมขึ้น (ข้อ 18)

วันนี้ แผนงานของความคิดของเรา ย่อมมีช่องโหว่
แต่โดยการพึ่งพาพระคำของพระเจ้า มาเป็นแนวทางในการเลือกตัดสินใจ
ย่อมทำให้แผนงานนั้นเกิดผลดี อย่างงดงาม
[แผนงานที่สอดคล้องกับพระคำของพระเจ้า จะเกิดผลเป็นพร]

มร​ดก​ที่​ได้​มา​อย่าง​ชิง​สุก​ก่อน​ห่าม ที่​สุด​จะไม่​เป็น​ผลดี (ข้อ 21)
แม้มรดกเป็นสิ่งดี ที่ในที่สุดก็จะได้รับอยู่แล้ว
แต่การได้รับก่อนเวลาอันควร กลับไม่เป็นผลดี

วันนี้ การที่พระเจ้ายังไม่ได้ประทานบางสิ่งแก่เรา
เพราะพระเจ้ามีเวลาที่ดีที่สุดสำหรับเรา
การเร่งรีบอยากได้รับ ในสิ่งที่พระเจ้าเห็นว่า ยังไม่ควรจะได้รับ
จะสร้างปัญหาให้เกิดขึ้นในชีวิต
[พระเจ้ามีเวลาที่ดีที่สุด ที่จะให้เราได้รับสิ่งดีที่ทรงเตรียมไว้สำหรับเรา]''',
                style: TextStyle(
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

  Widget _buildVideoCard({
    required String title,
    required String imageUrl,
  }) {
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

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: const Color(0xFF006FFD),
      unselectedItemColor: const Color(0xFF71727A),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Read'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
