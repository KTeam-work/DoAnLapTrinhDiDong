import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/owner/contract_form_w.dart';

class Contract_form extends StatefulWidget {
  const Contract_form({super.key});

  @override
  State<Contract_form> createState() => HopDongMoi();
}

class HopDongMoi extends State<Contract_form> {
  bool _agreeTerms = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 26, color: Colors.white),
        ),
        title: const Text(
          'Tạo Hợp Đồng Mới',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiến độ thiết lập
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tiến độ thiết lập hợp đồng',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Bước 6/6 Hoàn chỉnh',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Thanh tiến trình (Progress bar màu vàng accent)
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.accentYellow,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),

              // Dòng thông báo nguồn dữ liệu tự động điền
              const Row(
                children: [
                  Icon(Icons.verified_outlined, size: 14, color: AppColors.primaryGreen),
                  SizedBox(width: 4),
                  Text(
                    'Dữ liệu đã tự động điền từ Lịch hẹn chốt cọc',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 1. Nguồn tạo & Liên kết phòng
              ContractFormWidgets.buildSectionCard(
                step: '1',
                title: 'Nguồn tạo & Liên kết phòng',
                subtitle: 'Xác định cơ sở và căn phòng ký kết',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[300],
                              child: const Icon(Icons.home, color: AppColors.textSecondary),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Phòng 201 - Tầng 2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
                                    Text('25 m²', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  ],
                                ),
                                Text('Khu trọ Bình Thạnh (12 phòng)', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                SizedBox(height: 2),
                                Text('4.500.000 đ/tháng', style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Khu trọ áp dụng", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                    ContractFormWidgets.buildDropdownField('Khu trọ Bình Thạnh (12 phòng)'),
                    const SizedBox(height: 8),
                    const Text('Phòng thuê', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                    ContractFormWidgets.buildDropdownField('Phòng 201 - Tầng 2 (Giá niêm yết: 4.500.000)'),
                    const SizedBox(height: 8),
                    const Text('Liên kết lịch xem phòng', style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                    ContractFormWidgets.buildDropdownField('#AF-8823 - Nguyễn Văn An - 10:00 24/08/...'),
                  ],
                ),
              ),

              // 2. Thông tin người thuê & ở ghép
              ContractFormWidgets.buildSectionCard(
                step: '2',
                title: 'Thông tin Người thuê & Ở ghép',
                subtitle: 'Chủ thể ký và người đồng ký tạm trú',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('NGƯỜI ĐỨNG TÊN HỢP ĐỒNG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Chủ thuê', style: TextStyle(color: Colors.white, fontSize: 10)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: ContractFormWidgets.buildTextField('Họ và tên', 'Nguyễn Văn An', false)),
                              const SizedBox(width: 8),
                              Expanded(child: ContractFormWidgets.buildTextField('Số điện thoại', '0908123456', false)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(child: ContractFormWidgets.buildTextField('Số CCCD / CMND', '079098001234', false)),
                              const SizedBox(width: 8),
                              Expanded(child: ContractFormWidgets.buildTextField('Ngày cấp', '12/04/2021', false)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ContractFormWidgets.buildTextField('Nơi cấp', 'Cục CSQLHC về trật tự xã hội', false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Thành viên đi cùng (Khai báo tạm trú)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                        const Text('1 người', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
                            child: const Text('LH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Lê Thị Hoa', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textPrimary)),
                                Text('CCCD: 079199005678 • Vợ/Bạn', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          const Icon(Icons.close, size: 16, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add, size: 16),
                      label: const Text('Thêm người ở cùng', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.lightGreen,
                        minimumSize: const Size(double.infinity, 36),
                        side: BorderSide.none,
                        foregroundColor: AppColors.textPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Thời hạn & Tiền phòng, Đặt cọc
              ContractFormWidgets.buildSectionCard(
                step: '3',
                title: 'Thời hạn & Tiền phòng, Đặt cọc',
                subtitle: 'Cài đặt định kỳ và cam kết tài chính',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: ContractFormWidgets.buildTextField('Ngày bắt đầu', '01/09/2024', true, suffixIcon: Icons.calendar_today)),
                        const SizedBox(width: 8),
                        Expanded(child: ContractFormWidgets.buildTextField('Ngày kết thúc', '31/08/2025', true, suffixIcon: Icons.calendar_today)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                        SizedBox(width: 4),
                        Text('Thời hạn hợp đồng: 12 tháng', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: ContractFormWidgets.buildTextField('Giá thuê hàng tháng', '4.500.000', true, suffixText: 'đ')),
                        const SizedBox(width: 8),
                        Expanded(child: ContractFormWidgets.buildTextField('Tiền đặt cọc (Deposit)', '9.000.000', true, suffixText: 'đ')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.check_circle, size: 14, color: Colors.green),
                        SizedBox(width: 4),
                        Text('Đã thu đủ cọc ngày 25/08/2024', style: TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                        Spacer(),
                        Text('Đã xác nhận', style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Kỳ thanh toán tiền trọ',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    ContractFormWidgets.buildDropdownField('Hàng tháng (Từ ngày 01 đến 05)'),
                  ],
                ),
              ),

              // 4. Chỉ số điện nước ban đầu bàn giao
              ContractFormWidgets.buildSectionCard(
                step: '4',
                title: 'Chỉ số điện nước ban đầu bàn giao',
                subtitle: 'Chốt mốc bàn giao thiết bị phòng',
                content: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.flash_on, size: 16, color: AppColors.accentYellow),
                                    SizedBox(width: 4),
                                    Text('Điện ban đầu', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: TextEditingController(text: '1420'),
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('kWh', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.water_drop, size: 16, color: Colors.blue),
                                    SizedBox(width: 4),
                                    Text('Nước ban đầu', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: TextEditingController(text: '85'),
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('m³', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Ngày chốt chỉ số bàn giao:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          Text('01/09/2024', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 5. Bảng dịch vụ áp dụng riêng
              ContractFormWidgets.buildSectionCard(
                step: '5',
                title: 'Bảng dịch vụ áp dụng riêng',
                subtitle: 'Thời giá dịch vụ bám theo phòng 201',
                content: Column(
                  children: [
                    ContractFormWidgets.buildServiceRow(Icons.flash_on, 'Điện sinh hoạt', '3.800 đ / kWh'),
                    ContractFormWidgets.buildServiceRow(Icons.water_drop, 'Nước sinh hoạt', '35.000 đ / m³'),
                    ContractFormWidgets.buildServiceRow(Icons.wifi, 'Internet / Wifi', '100.000 đ / phòng / tháng'),
                    ContractFormWidgets.buildServiceRow(Icons.cleaning_services, 'Phí vệ sinh, rác', '50.000 đ / phòng'),
                    const SizedBox(height: 6),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Thêm dịch vụ khác', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.lightGreen,
                        minimumSize: const Size(double.infinity, 36),
                        side: BorderSide.none,
                        foregroundColor: AppColors.textPrimary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ],
                ),
              ),

              // 6. Điều khoản hợp đồng & Quy định trọ
              ContractFormWidgets.buildSectionCard(
                step: '6',
                title: 'Điều khoản hợp đồng & Quy định trọ',
                subtitle: 'Các cam kết an toàn & nội quy phòng trọ',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ContractFormWidgets.buildRuleItem(Icons.security, 'An toàn PCCC:', 'Nghiêm cấm đun nấu bằng bếp gas, tối toàn bộ thiết bị điện có công suất lớn khi ra khỏi phòng.'),
                          const SizedBox(height: 6),
                          ContractFormWidgets.buildRuleItem(Icons.access_time, 'Giờ giấc & Trật tự:', 'Cửa đóng tự động lúc 22:30. Giữ yên lặng chung sau 22:00, không tổ chức tiệc tùng gây mất trật tự.'),
                          const SizedBox(height: 6),
                          ContractFormWidgets.buildRuleItem(Icons.policy, 'Chính sách hoàn cọc:', 'Khách thuê muốn chấm dứt hợp đồng phải thông báo trước tối thiểu 30 ngày để nhận hoàn lại 100% tiền cọc.'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: _agreeTerms,
                            activeColor: Colors.lightBlueAccent,
                            onChanged: (val) {
                              setState(() {
                                _agreeTerms = val ?? true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('Tôi đã phổ biến và gửi kèm bộ Nội quy cho khách thuê.', style: TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Nút thao tác dưới cùng
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.mail_outline, size: 16),
                      label: const Text('Lưu bản nháp', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: AppColors.primaryGreen),
                        foregroundColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check, size: 16, color: Colors.white),
                      label: const Text('Hoàn tất & Ký', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}