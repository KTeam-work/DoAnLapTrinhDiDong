import 'package:flutter/material.dart';
import 'service_form.dart';

class ServicesManageScreen extends StatefulWidget {
  const ServicesManageScreen({Key? key}) : super(key: key);

  @override
  State<ServicesManageScreen> createState() => _ServicesManageScreenState();
}

class _ServicesManageScreenState extends State<ServicesManageScreen> {
  // Màu chủ đạo
  final Color primaryColor = const Color(0xFF1E6F5C);
  final Color bgColor = const Color(0xFFF5F7F9);

  // Dữ liệu giả lập 
  final List<Map<String, dynamic>> _services = [
    {
      'id': 'SRV_001',
      'name': 'Tiền điện',
      'price': 3500,
      'unit': 'kWh',
      'icon': Icons.electric_bolt,
      'color': Colors.orange, // Màu riêng cho từng dịch vụ
    },
    {
      'id': 'SRV_002',
      'name': 'Tiền nước',
      'price': 15000,
      'unit': 'm3',
      'icon': Icons.water_drop,
      'color': Colors.blue,
    },
    {
      'id': 'SRV_003',
      'name': 'Internet / Wifi',
      'price': 100000,
      'unit': 'Tháng',
      'icon': Icons.wifi,
      'color': Colors.purple,
    },
    {
      'id': 'SRV_004',
      'name': 'Dọn phòng',
      'price': 50000,
      'unit': 'Lần',
      'icon': Icons.cleaning_services,
      'color': Colors.teal,
    },
  ];

  // Hàm format tiền tệ (Ví dụ: 3500 -> 3.500)
  String _formatCurrency(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  // Hàm xử lý xóa dịch vụ
  void _deleteService(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Xác nhận xóa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Bạn có chắc chắn muốn xóa dịch vụ "${_services[index]['name']}" không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _services.removeAt(index);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa dịch vụ thành công!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Quản lý dịch vụ khu trọ',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: _services.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return _buildServiceCard(index);
              },
            ),
      // Nút thêm dịch vụ  
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServiceFormScreen()),
          );
          if (result == true) {
            // Refresh list nếu cần (giả lập)
            setState(() {});
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Thêm dịch vụ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Widget tạo từng thẻ dịch vụ
  Widget _buildServiceCard(int index) {
    final service = _services[index];
    final Color itemColor = service['color'] ?? primaryColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Phần trên: Icon + Tên + Giá
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Khối Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: itemColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(service['icon'], color: itemColor, size: 28),
                ),
                const SizedBox(width: 16),
                // Tên và đơn vị
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Đơn vị: ${service['unit']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Giá tiền
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_formatCurrency(service['price'])} đ',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Đơn giá',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 8),

            // Phần dưới: Nút hành động
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ServiceFormScreen(serviceData: service),
                      ),
                    );
                    if (result == true) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                  label: const Text(
                    'Sửa',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _deleteService(index),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.red,
                  ),
                  label: const Text('Xóa', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị khi danh sách trống
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.miscellaneous_services_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có dịch vụ nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn nút "Thêm dịch vụ" bên dưới để bắt đầu.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
