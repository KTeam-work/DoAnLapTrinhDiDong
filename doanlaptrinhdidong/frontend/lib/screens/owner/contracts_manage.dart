import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/owner/contract_card.dart';


class Contracts_manager extends StatefulWidget
{
  const Contracts_manager({super.key});

  @override
  State<StatefulWidget> createState() => HienThiQuanLyHopDong();


}


class HienThiQuanLyHopDong extends State<Contracts_manager>{
  String _selectedRole = "Tất cả";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      appBar: AppBar(
        backgroundColor:AppColors.primaryGreen,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,size: 26,color: Colors.white,)),
        title: const Text('Quản lý hợp đồng', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20,),
              //thanh tìm kiếm
              Row(
                children: [
                  Expanded(child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm mã HĐ, tên hoặc SĐT khách thuê...',
                      hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                      prefixIcon: Icon(Icons.search,color: Colors.grey,),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none
                      )
                    ),

                  )),

                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.black54),
                  ),
                ],

              ),

              const SizedBox(height: 10,),
              //thẻ thống kê
              Row(
                children: [
                  //tổng hợp đồng
                  Expanded(child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('HỢP ĐỒNG', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                            Icon(Icons.shield_outlined, color: Colors.white54, size: 18),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('18', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('Đang hoạt động', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  )),

                  const SizedBox(width: 12),

                  //danh thu dự kiến
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DOANH THU DỰ KIẾN', style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('72.500.000đ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Tổng tiền thuê / tháng', style: TextStyle(color: Colors.black45, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["Tất cả","Đang hiệu lục","Sắp hết hạn"].map((role){
                  final select = _selectedRole == role;
                  return ChoiceChip(label: Text(role), selected: select,
                    selectedColor: AppColors.primaryGreen,
                    backgroundColor: AppColors.background,
                    side: BorderSide.none,
                    showCheckmark: false, //ẩn dấu tích
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)
                    ),
                    labelStyle:TextStyle(
                      color:select ?AppColors.background : Colors.grey,
                      fontSize: 16,
                      fontWeight:  select ? FontWeight.bold : FontWeight.normal
                    ) ,
                    onSelected: (selected){
                       if(selected){
                         setState(() {
                           _selectedRole = role;
                         });
                       }
                    },

                  );
                }).toList()
              ),

              const SizedBox(height: 16),


              //card 1: Đang hiệu lực
              ContractCard(
                room: 'Phòng 201 • Tầng 2',
                address: 'Khu trọ Bình Thạnh • 35 m²',
                status: 'Đang hiệu lực',
                statusBgColor: Colors.green.shade100,
                statusTextColor: Colors.green.shade800,
                code: 'HD-2024-P201',
                timeText: 'Còn 6 tháng',
                timeColor: Colors.green,
                tenantName: 'Nguyễn Văn An',
                tenantPhone: '0908 123 456',
                rentPrice: '4.500.000đ',
                depositPrice: '9.000.000đ',
                duration: '📅 01/03/2024 - 28/02/2025',
                cycleText: 'Kỳ thu: Ngày 05',
                noteText: '2 người ở ghép (An, Hoa • Đã khai báo tạm trú)',
                primaryBtnText: 'Gia hạn / Thanh lý',
                primaryBtnColor: AppColors.primaryGreen,
                onTapDetail: () {},
                onTapPrimaryBtn: () {},
              ),

              const SizedBox(height: 16),

              //card2:xấp hết hạn
              ContractCard(
                room: 'Phòng 302 • Tầng 3',
                address: 'Khu trọ Bình Thạnh • Ban công',
                status: 'Sắp hết hạn',
                statusBgColor: Colors.orange.shade100,
                statusTextColor: const Color(0xFFE68A00),
                code: 'HD-2024-P302',
                timeText: 'Hết hạn sau 5 ngày!',
                timeColor: Colors.red,
                tenantName: 'Trần Thị Bích',
                tenantPhone: '0933 555 789',
                rentPrice: '5.200.000đ',
                depositPrice: '10.400.000đ',
                duration: '📅 15/09/2023 - 15/09/2024',
                cycleText: 'Cần xử lý hoàn cọc',
                primaryBtnText: 'Gia hạn hợp đồng',
                primaryBtnColor: const Color(0xFFFFA726),
                onTapDetail: () {},
                onTapPrimaryBtn: () {},
              ),

              const SizedBox(height: 16),

              //card3:bản nháp
              ContractCard(
                room: 'Phòng 105 • Studio',
                address: 'Chưa kích hoạt hiệu lực',
                status: 'Bản nháp',
                statusBgColor: Colors.grey.shade200,
                statusTextColor: Colors.grey.shade700,
                code: 'HD-2024-P105',
                timeText: 'Tạo từ lịch hẹn #AP-8823',
                timeColor: Colors.grey,
                tenantName: 'Phạm Hoàng Nam',
                tenantPhone: 'Chờ điền CCCD & ngày dọn vào',
                rentPrice: '6.000.000đ',
                depositPrice: '6.000.000đ',
                primaryBtnText: 'Gửi ký điện tử',
                primaryBtnColor: AppColors.primaryGreen,
                onTapDetail: () {},
                onTapPrimaryBtn: () {},
              ),

              const SizedBox(height: 20),


            ],
          ),
        ),

      ),
    );
  }
}