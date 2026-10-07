import 'package:flutter/material.dart';

class ServiceFormScreen extends StatefulWidget {
  // Nhận dữ liệu cũ nếu là hành động Sửa (Edit)
  final Map<String, dynamic>? serviceData;

  const ServiceFormScreen({Key? key, this.serviceData}) : super(key: key);

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final Color primaryColor = const Color(0xFF1E6F5C);
  final _formKey = GlobalKey<FormState>();

  // Controllers để lấy dữ liệu từ ô nhập liệu
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;
  late TextEditingController _descController;

  bool get isEditing => widget.serviceData != null;

  @override
  void initState() {
    super.initState();
    // Nếu là sửa, điền dữ liệu cũ vào form. Nếu là thêm mới, để trống.
    _nameController = TextEditingController(
      text: isEditing ? widget.serviceData!['name'] : '',
    );
    _priceController = TextEditingController(
      text: isEditing ? widget.serviceData!['price'].toString() : '',
    );
    _unitController = TextEditingController(
      text: isEditing ? widget.serviceData!['unit'] : '',
    );
    _descController = TextEditingController(); // Giả sử chưa có desc
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      // Xử lý lưu dữ liệu ở đây (Gọi API)
      // Ví dụ: print(_nameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing ? 'Đã cập nhật dịch vụ!' : 'Đã thêm dịch vụ mới!',
          ),
        ),
      );
      Navigator.pop(context, true); // Trả về true để báo hiệu đã lưu thành công
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEditing ? 'Sửa dịch vụ' : 'Thêm dịch vụ mới',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ô nhập tên dịch vụ
              _buildLabel('Tên dịch vụ (*)'),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration(
                  'Ví dụ: Tiền điện, Wifi...',
                  Icons.miscellaneous_services,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập tên dịch vụ'
                    : null,
              ),
              const SizedBox(height: 20),

              // Ô nhập đơn giá
              _buildLabel('Đơn giá (VNĐ) (*)'),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Ví dụ: 3500', Icons.attach_money),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Vui lòng nhập đơn giá';
                  if (int.tryParse(value) == null) return 'Đơn giá phải là số';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Ô nhập đơn vị tính
              _buildLabel('Đơn vị tính (*)'),
              TextFormField(
                controller: _unitController,
                decoration: _inputDecoration(
                  'Ví dụ: kWh, m3, Tháng, Lần...',
                  Icons.straighten,
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Vui lòng nhập đơn vị'
                    : null,
              ),
              const SizedBox(height: 20),

              // Ô nhập mô tả
              _buildLabel('Mô tả thêm'),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: _inputDecoration(
                  'Ghi chú thêm về dịch vụ...',
                  null,
                ),
              ),
              const SizedBox(height: 40),

              // Nút Lưu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Cập nhật' : 'Lưu dịch vụ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget tạo label cho form
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  // Widget tạo style cho ô nhập liệu
  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      prefixIcon: icon != null ? Icon(icon) : null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }
}
