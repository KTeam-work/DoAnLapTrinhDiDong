import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../core/constants/app_colors.dart';

class review extends StatefulWidget
{
  const review({super.key});

  @override
  State<review> createState() => duyettin();


}

class duyettin extends State<review>{
  String _selectedRole = "Chờ duyệt";

  final List<Map<String, dynamic>> danhSachTinDangMau = const [
    {
      'id': '1',
      'title': 'Phòng trọ cao cấp gần HUIT',
      'price': '2.500.000',
      'address': 'Lê Trọng Tấn, Q. Tân Phú',
      'owner_name': 'Nguyễn Văn A',
      'status': 'Chờ duyệt',
      'image': 'https://picsum.photos/200/200?random=1',
    },
    {
      'id': '2',
      'title': 'Chung cư mini 1PN full nội thất',
      'price': '4.200.000',
      'address': 'Cộng Hòa, Q. Tân Bình',
      'owner_name': 'Trần Thị B',
      'status': 'Đã duyệt',
      'image': 'https://picsum.photos/200/200?random=2',
    },
    {
      'id': '3',
      'title': 'Phòng trọ sinh viên giá rẻ',
      'price': '1.800.000',
      'address': 'Tây Thạnh, Q. Tân Phú',
      'owner_name': 'Lê Văn C',
      'status': 'Từ chối',
      'image': 'https://picsum.photos/200/200?random=3',
    },
  ];
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.primaryGreen,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.maybePop(context);
          }, icon: const Icon(Icons.arrow_back, size: 26, color: Colors.white)),
          centerTitle: true,

          title:const Text(
            "Duyệt tin đăng",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),

          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Colors.white, size: 24),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.white, size: 24),
            ),
          ],




        ),


        body:SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),

                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 8),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: ["Chờ duyệt", "Đã duyệt", "Từ chối"].map((role) {
                              final isSelected = _selectedRole == role;
                              return ChoiceChip(
                                label: Text(role),
                                selected: isSelected,
                                selectedColor: AppColors.primaryGreen,
                                backgroundColor: AppColors.background,
                                showCheckmark: false,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelStyle: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 16
                                ),
                                onSelected: (selected){
                                  if(selected){
                                    setState(() {
                                      _selectedRole = role;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),

                        Expanded(child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Expanded(child: tinDang(rev: danhSachTinDangMau))

                            ],
                          ),
                        ),)
                      ],
                    )
                ),
              ),
            ],
         )
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {},
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: 'Quản lý'),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart_rounded), label: 'Thống kê'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Tài khoản'),
          ],
        ),
      ),
    );
  }
}

class tinDang extends StatelessWidget {
  final List<Map<String, dynamic>> rev;
  final Function(Map<String, dynamic> item)? onItemTap;

  const tinDang({
    super.key,
    required this.rev,
    this.onItemTap,
  });

  Color _getStatusBgColor(String? status) {
    switch (status) {
      case 'Đã duyệt':
      case 'Kích hoạt':
        return Colors.green[100]!;
      case 'Chờ duyệt':
        return Colors.orange[100]!;
      case 'Từ chối':
      case 'Đã khóa':
        return Colors.red[100]!;
      default:
        return Colors.grey[200]!;
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status) {
      case 'Đã duyệt':
      case 'Kích hoạt':
        return AppColors.primaryGreen;
      case 'Chờ duyệt':
        return Colors.orange[800]!;
      case 'Từ chối':
      case 'Đã khóa':
        return Colors.red[800]!;
      default:
        return Colors.grey[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rev.isEmpty) {
      return const Center(
        child: Text(
          "Không có tin đăng nào",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      itemCount: rev.length,
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemBuilder: (context, index) {
        final item = rev[index];
        final String title = item['title'] ?? item['room_title'] ?? 'Chưa có tiêu đề';
        final String price = item['price'] != null ? '${item['price']} VNĐ/tháng' : 'Thỏa thuận';
        final String address = item['address'] ?? item['location'] ?? 'Chưa cập nhật địa chỉ';
        final String status = item['status'] ?? 'Chờ duyệt';
        final String imageUrl = item['image'] ?? item['image_url'] ?? '';
        final String authorName = item['owner_name'] ?? item['tenant_name'] ?? 'Ẩn danh';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (onItemTap != null) {
                  onItemTap!(item);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Hình ảnh tin đăng
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                        imageUrl,
                        width: 85,
                        height: 95,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 85,
                          height: 85,
                          color: AppColors.lightGreen,
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      )
                          : Container(
                        width: 85,
                        height: 85,
                        color: AppColors.lightGreen,
                        child: const Icon(Icons.home, color: AppColors.primaryGreen, size: 32),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Thông tin chi tiết tin đăng
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),

                              // // Tag trạng thái
                              // Container(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              //   decoration: BoxDecoration(
                              //     color: _getStatusBgColor(status),
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              //   child: Text(
                              //     status,
                              //     style: TextStyle(
                              //       color: _getStatusTextColor(status),
                              //       fontSize: 11,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),

                          //hiển thị người dùng
                          Row(
                            children: [
                              const Icon(Icons.person_outline_rounded, size: 14, color: Colors.grey),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  'Đăng bởi: $authorName',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(style:ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                )
                              ),onPressed: (){}, child: const Text(
                                "Duyệt",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              ),

                              ElevatedButton(style:ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[100],
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  )
                              ),onPressed: (){}, child: const  Text("Từ chối",style: TextStyle(fontSize: 16,color: Colors.red),),

                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}