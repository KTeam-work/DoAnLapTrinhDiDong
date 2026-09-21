import 'package:flutter/material.dart';
import 'owner_dashboard.dart';
import 'property_form.dart';

class PropertiesManageScreen extends StatelessWidget {
  const PropertiesManageScreen({super.key});

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
            'Quản lý phòng',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,

          // THANH TAB BAR
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Đang cho thuê'),
              Tab(text: 'Còn trống'),
              Tab(text: 'Tất cả'),
            ],
          ),
        ),

        // danh sách phòng
        body: TabBarView(
          children: [
            _buildRoomList(), // Danh sách phòng "Đang cho thuê"
            _buildRoomList(), // Danh sách phòng "Còn trống"
            _buildRoomList(), // Danh sách "Tất cả"
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PropertyFormScreen(),
              ),
            );
          },
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Trang chủ', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OwnerDashboard(),
                  ),
                );
              }),
              _buildNavItem(Icons.apartment, 'Phòng', true, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PropertiesManageScreen(),
                  ),
                );
              }),
              const SizedBox(width: 40),
              _buildNavItem(Icons.people_outline, 'Người thuê', false, () {}),
              _buildNavItem(Icons.person_outline, 'Cá nhân', false, () {}),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm demo các phòng
  Widget _buildRoomList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildRoomCard(
          roomName: 'Phòng 201',
          detail: '25 m² - Tầng 2',
          price: '4.000.000đ',
          status: 'Đang cho thuê',
          images: "frontend/assets/images/anhPhongDemo.jpg",
        ),
        _buildRoomCard(
          roomName: 'Phòng 202',
          detail: '25 m² - Tầng 2',
          price: '4.500.000đ',
          status: 'Còn trống',
          images: "frontend/assets/images/anhPhongDemo.jpg",
        ),
        _buildRoomCard(
          roomName: 'Phòng 301',
          detail: '30 m² - Tầng 3',
          price: '5.000.000đ',
          status: 'Đang cho thuê',
          images: "frontend/assets/images/anhPhongDemo.jpg",
        ),
        _buildRoomCard(
          roomName: 'Phòng 302',
          detail: '20 m² - Tầng 3',
          price: '4.000.000đ',
          status: 'Bảo trì',
          images: "frontend/assets/images/anhPhongDemo.jpg",
        ),
      ],
    );
  }

  // Widget Thẻ phòng
  Widget _buildRoomCard({
    required String roomName,
    required String detail,
    required String price,
    required String status,
    required String images,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              images,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 85,
                height: 85,
                color: Colors.grey[200],
                child: const Icon(Icons.apartment, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Cột thông tin phòng
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),

                //trạng thái phòng
                _buildStatusBadge(status),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo Badge màu tương ứng từng trạng thái
  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Đang cho thuê':
        bgColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF2E7D32);
        break;
      case 'Còn trống':
        bgColor = const Color(0xFFFFF8E1);
        textColor = const Color(0xFFF57F17);
        break;
      case 'Bảo trì':
        bgColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFC62828);
        break;
      default:
        bgColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? primaryColor : Colors.grey),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? primaryColor : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
