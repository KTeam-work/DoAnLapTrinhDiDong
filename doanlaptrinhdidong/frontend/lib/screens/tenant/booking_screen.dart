import 'package:flutter/material.dart';

import '../../main.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/tenant/calendar_widget.dart';
class booking_screen extends StatefulWidget{
  const booking_screen({super.key});
  @override
  State<booking_screen> createState() => _BookingScreenState();
}
class _BookingScreenState extends State<booking_screen> {
  // 1. CÁC BIẾN QUẢN LÝ TRẠNG THÁI NHẬP LIỆU
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // 2. DỮ LIỆU GIẢ (MOCK DATA) - Dùng cho Tuần 1 (Sẽ thay bằng API ở Tuần 7)
  final String mockAddress = "KDC Nhơn Đức, Xã Nhơn Đức, Huyện Nhà Bè, Thành phố Hồ Chí Minh";
  final String mockRoomName = "101";
  final String mockPrice = "2.800.000";

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi tắt màn hình
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi bấm nút Gửi lịch hẹn
  void _submitBooking() {
    // Basic Validation (Kiểm tra dữ liệu)
    if (_selectedDate == null || _selectedTime == null || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng chọn ngày, giờ và nhập số điện thoại!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Nếu pass, in ra console (Tuần 7 sẽ gọi API ở đây)
    print("Ngày: $_selectedDate, Giờ: $_selectedTime");
    print("SĐT: ${_phoneController.text}");
    print("Ghi chú: ${_noteController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Gửi lịch hẹn thành công!"),
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          title: const Text(
            'Đặt lịch xem phòng',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
body: SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on,color: AppColors.primaryGreen,size: 20,),
                const SizedBox(width: 8,),
                Expanded(
                    child: Text("Địa chỉ: $mockAddress",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                )
              ],
            ),
            const Divider(height: 24,thickness: 1, color: Color(0xFFE5E7EB),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mã Phòng: $mockRoomName",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                ),
                Text(
                  "$mockPrice đ/ tháng",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent, // Đổi màu nổi bật cho giá tiền
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      const SizedBox(height: 24,),
      CalendarWidget(
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        onDateSelected: (date) {
          setState(() => _selectedDate = date);
        },
        onTimeSelected: (time) {
          setState(() => _selectedTime = time);
        },
      ),
      const SizedBox(height: 24,),
      const Text("Số điện thoại liên hệ *",
      style: TextStyle(
        fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.textPrimary
      ),
      ),
      const SizedBox(height: 8,),
      TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: _buildInputDecoration(
          hint:"Nhập số điện thoại của bạn",
          icon: Icons.phone_outlined
        ),
      ),
      const SizedBox(height: 8,),
      const Text("Ghi chú cho chủ nhà: ",
        style: TextStyle(
            fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.textPrimary
        ),
      ),
      const SizedBox(height: 8,),
      TextField(
        controller: _noteController,
        maxLines: 4,
        decoration: _buildInputDecoration(
            hint:"VD: Mình đi làm về muộn, chủ nhà hỗ trợ giúp nhé...",
            icon: null
        ),
      ),
      const SizedBox(height: 40,),
    ],
  ),

),
      bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4)
                )
              ]
            ),
            child: ElevatedButton(
              onPressed: _submitBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
            ),
              child: const Text("GỬI LỊCH HẸN",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
          )
      ),
      )
    );
  }
  InputDecoration _buildInputDecoration({required String hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
      prefixIcon: icon != null ? Icon(icon, color: AppColors.textSecondary, size: 20) : null,
      filled: true,
      fillColor: AppColors.cardSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
      ),
    );
  }
}