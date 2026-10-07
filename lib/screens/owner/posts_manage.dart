import 'package:flutter/material.dart';
import 'post_form.dart';

class PostsManageScreen extends StatelessWidget {
  const PostsManageScreen({super.key});

  final Color primaryColor = const Color(0xFF1B5E55);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Quản lý tin đăng',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            indicatorWeight: 2.5,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Đang hiển thị'),
              Tab(text: 'Chờ duyệt'),
              Tab(text: 'Đã ẩn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPostList('active'),
            _buildPostList('pending'),
            _buildPostList('hidden'),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostFormScreen()),
            );
          },
          backgroundColor: Colors.orange,
          icon: const Icon(Icons.edit_document, color: Colors.white),
          label: const Text(
            'Đăng tin',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildPostList(String status) {
    // Dummy Data
    final samplePosts = [
      {
        'title': 'Cho thuê phòng trọ có gác xép, full nội thất',
        'room': 'Phòng 201 - Chung cư Mini Q7',
        'price': '4.000.000đ/tháng',
        'views': 124,
        'likes': 12,
        'date': '24/09/2026',
        'status': 'active',
        'image': 'frontend/assets/images/anhPhongDemo.jpg',
      },
      {
        'title': 'Phòng giá rẻ cho sinh viên ĐH Tôn Đức Thắng',
        'room': 'Phòng 102 - Dãy trọ Lê Văn Sỹ',
        'price': '2.500.000đ/tháng',
        'views': 45,
        'likes': 2,
        'date': '20/09/2026',
        'status': 'hidden',
        'image': 'frontend/assets/images/anhPhongDemo.jpg',
      },
    ];

    final filtered = samplePosts.where((post) {
      if (status == 'active') return post['status'] == 'active';
      if (status == 'hidden') return post['status'] == 'hidden';
      return false; // Dummy logic
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Không có bài đăng nào',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final post = filtered[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    bool isActive = post['status'] == 'active';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hình ảnh bài đăng
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    post['image'],
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Thông tin chính
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['title'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        post['room'],
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        post['price'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            // Thống kê & Nút thao tác
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post['views']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post['likes']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        isActive ? Icons.visibility_off : Icons.visibility,
                        size: 18,
                      ),
                      label: Text(isActive ? 'Ẩn tin' : 'Hiện tin'),
                      style: TextButton.styleFrom(
                        foregroundColor: isActive
                            ? Colors.orange
                            : primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Sửa'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
