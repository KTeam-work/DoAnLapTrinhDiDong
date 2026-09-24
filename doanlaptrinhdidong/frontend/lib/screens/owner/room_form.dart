import 'package:flutter/material.dart';

class RoomFormScreen extends StatefulWidget {
  const RoomFormScreen({super.key});

  @override
  State<RoomFormScreen> createState() => _RoomFormScreenState();
}

class _RoomFormScreenState extends State<RoomFormScreen> {
  final Color primaryColor = const Color(0xFF1B5E55);
  final _formKey = GlobalKey<FormState>();

  // Trạng thái phòng mặc định
  String _selectedStatus = 'Còn trống';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Thêm phòng mới',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // tải ảnh phòng lên
                    _buildSectionTitle('Hình ảnh phòng'),
                    const SizedBox(height: 8),
                    _buildImagePickerSection(),
                    const SizedBox(height: 20),

                    // thông tin cơ bản
                    _buildSectionTitle('Thông tin cơ bản'),
                    const SizedBox(height: 8),
                    _buildCardGroup(
                      children: [
                        _buildTextField(
                          label: 'Tên phòng',
                          hint: 'VD: Phòng 101',
                          icon: Icons.meeting_room_outlined,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: 'Diện tích',
                                hint: '25',
                                suffixText: 'm²',
                                keyboardType: TextInputType.number,
                                icon: Icons.square_foot_outlined,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                label: 'Tầng thứ',
                                hint: '2',
                                keyboardType: TextInputType.number,
                                icon: Icons.layers_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: 'Giá thuê phòng',
                          hint: '4.000.000',
                          suffixText: 'đ/tháng',
                          keyboardType: TextInputType.number,
                          icon: Icons.payments_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // trạng thái phòng
                    _buildSectionTitle('Trạng thái phòng'),
                    const SizedBox(height: 8),
                    _buildStatusSelector(),
                    const SizedBox(height: 20),

                    // mô tả
                    _buildSectionTitle('Mô tả thêm'),
                    const SizedBox(height: 8),
                    _buildCardGroup(
                      children: [
                        _buildTextField(
                          label: 'Mô tả ngắn hoặc ghi chú',
                          hint: 'Nhập thông tin nội thất, điện nước...',
                          maxLines: 3,
                          icon: Icons.description_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // thêm phòng ngay
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Thêm phòng ngay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //tiêu đề cho mỗi Section
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  //khung card nhóm các input
  Widget _buildCardGroup({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(children: children),
    );
  }

  //hàm ô nhập dữ liệu
  Widget _buildTextField({
    required String label,
    required String hint,
    IconData? icon,
    String? suffixText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffixText,
        prefixIcon: icon != null ? Icon(icon, color: primaryColor) : null,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF9F9FB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }

  // Khu vực tải ảnh phòng
  Widget _buildImagePickerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Icon(Icons.add_a_photo_outlined, color: primaryColor),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thêm hình ảnh thực tế phòng',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Hỗ trợ JPG, PNG (Tối đa 5 ảnh)',
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  //Khung chọn trạng thái phòng
  Widget _buildStatusSelector() {
    final statuses = ['Còn trống', 'Đang cho thuê', 'Bảo trì'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: statuses.map((status) {
          final isSelected = _selectedStatus == status;
          return ChoiceChip(
            label: Text(status),
            selected: isSelected,
            selectedColor: primaryColor,
            backgroundColor: Colors.grey[100],
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            showCheckmark: false,
            onSelected: (selected) {
              if (selected) {
                setState(() {
                  _selectedStatus = status;
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
