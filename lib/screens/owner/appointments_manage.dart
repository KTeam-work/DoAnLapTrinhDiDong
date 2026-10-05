import 'package:flutter/material.dart';

class AppointmentsManageScreen extends StatefulWidget {
  const AppointmentsManageScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsManageScreen> createState() =>
      _AppointmentsManageScreenState();
}

class _AppointmentsManageScreenState extends State<AppointmentsManageScreen> {
  final Color primaryColor = const Color(0xFF1E6F5C);

  // Controller tìm kiếm
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Khai báo danh sách dữ liệu
  late List<Map<String, dynamic>> _allAppointments;

  @override
  void initState() {
    super.initState();
    // Khởi tạo dữ liệu mẫu bên trong initState để luôn load mới khi mở màn hình
    _allAppointments = [
      {
        'id': 'APT_001',
        'customerName': 'Nguyễn Thị Hạnh',
        'date': '10/10/2026',
        'time': '09:00 - 10:00',
        'room': 'Phòng 301 - Tân Bình',
        'phone': '0987654321',
        'status': 'pending', // Sắp tới (Chờ duyệt)
        'isUpcoming': true,
      },
      {
        'id': 'APT_002',
        'customerName': 'Trần Văn Nam',
        'date': '12/10/2026',
        'time': '14:00 - 15:30',
        'room': 'Phòng 101 - Q.7',
        'phone': '0912345678',
        'status': 'confirmed', // Sắp tới (Đã xác nhận)
        'isUpcoming': true,
      },
      {
        'id': 'APT_003',
        'customerName': 'Lê Thị Mai',
        'date': '15/10/2026',
        'time': '09:30 - 10:30',
        'room': 'Phòng 302 - Q.10',
        'phone': '0333444555',
        'status': 'confirmed', // Sắp tới (Đã xác nhận)
        'isUpcoming': true,
      },
      {
        'id': 'APT_004',
        'customerName': 'Phạm Văn An',
        'date': '01/10/2026',
        'time': '10:00 - 11:00',
        'room': 'Phòng 202 - Gò Vấp',
        'phone': '0905123456',
        'status': 'completed', // Đã qua (Hoàn thành)
        'isUpcoming': false,
      },
      {
        'id': 'APT_005',
        'customerName': 'Hoàng Minh Tuấn',
        'date': '28/09/2026',
        'time': '15:00 - 16:00',
        'room': 'Phòng 102 - Tân Bình',
        'phone': '0978123456',
        'status': 'cancelled', // Đã qua (Đã hủy)
        'isUpcoming': false,
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateStatus(String id, String newStatus) {
    setState(() {
      final index = _allAppointments.indexWhere(
        (element) => element['id'] == id,
      );
      if (index != -1) {
        _allAppointments[index]['status'] = newStatus;
        if (newStatus == 'cancelled' || newStatus == 'completed') {
          _allAppointments[index]['isUpcoming'] = false;
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã cập nhật trạng thái lịch hẹn $id')),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Chờ duyệt';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'completed':
        return 'Đã xem';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  List<Map<String, dynamic>> _filterList(bool isUpcoming) {
    return _allAppointments.where((item) {
      final matchesTab = item['isUpcoming'] == isUpcoming;
      final query = _searchQuery.toLowerCase();
      final matchesSearch =
          item['customerName'].toLowerCase().contains(query) ||
          item['room'].toLowerCase().contains(query) ||
          item['phone'].contains(query);
      return matchesTab && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text(
            'Lịch xem phòng',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                // Thanh tìm kiếm
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Tìm theo tên khách, phòng, SĐT...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Tab Bar (Sắp tới / Đã qua)
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryColor,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    tabs: const [
                      Tab(text: 'Sắp tới'),
                      Tab(text: 'Đã qua'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildAppointmentList(isUpcoming: true),
            _buildAppointmentList(isUpcoming: false),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList({required bool isUpcoming}) {
    final list = _filterList(isUpcoming);

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              isUpcoming
                  ? 'Không có lịch hẹn sắp tới nào'
                  : 'Không có lịch sử lịch hẹn',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final appt = list[index];
        final statusColor = _getStatusColor(appt['status']);

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Tên khách & Trạng thái
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: primaryColor.withOpacity(0.1),
                          child: Text(
                            appt['customerName'].substring(0, 1),
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appt['customerName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              appt['phone'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        _getStatusText(appt['status']),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
                // Thông tin chi tiết
                _buildInfoRow(
                  Icons.calendar_today,
                  'Ngày: ${appt['date']} (${appt['time']})',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.home_work_outlined, appt['room']),

                // Nút thao tác nhanh (Chỉ hiện ở tab Sắp tới)
                if (isUpcoming) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _updateStatus(appt['id'], 'cancelled'),
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'Hủy',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (appt['status'] == 'pending')
                        ElevatedButton.icon(
                          onPressed: () =>
                              _updateStatus(appt['id'], 'confirmed'),
                          icon: const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Xác nhận',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      if (appt['status'] == 'confirmed')
                        ElevatedButton.icon(
                          onPressed: () =>
                              _updateStatus(appt['id'], 'completed'),
                          icon: const Icon(
                            Icons.done_all,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Hoàn thành',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
