import 'package:flutter/material.dart';

//sở dĩ dùng enum để quản lý trạng thái hiển thị của 1 card duy nhất
enum RoomUtilityStatus {
  completed, //đã chốt
  abnormal,  //bất thường
  inputting, //chờ nhập số
  pending    //chưa nhập
}

//hằng số màu sắc dùng riêng cho card
class RoomCardColors {
  static const Color primaryDarkGreen = Color(0xFF0F3E2E);
  static const Color accentGreen = Color(0xFF1B5E20);
  static const Color backgroundLight = Color(0xFFF4F8F5);
  static const Color cardBg = Colors.white;
  static const Color orangeWarning = Color(0xFFFFA726);
  static const Color redAlert = Color(0xFFE53935);
  static const Color redLightBg = Color(0xFFFFEBEE);
  static const Color greenLightBg = Color(0xFFE8F5E9);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color chipGray = Color(0xFFE0E0E0);
}

//----------------------------------------------------
//WIDGET CARD GỐC DUY NHẤT DÙNG CHUNG CHO CẢ 4 TRẠNG THÁI
//----------------------------------------------------
class RoomUtilityCard extends StatelessWidget {
  final String roomName;
  final String tenantName;
  final String? phone;
  final RoomUtilityStatus status;
  final String? totalAmount;
  final String? elecOld;
  final String? elecNew;
  final String? elecDiff;
  final String? elecCost;
  final String? waterOld;
  final String? waterNew;
  final String? waterDiff;
  final String? waterCost;
  final String? warningTag;
  final String? warningMessage;
  final int proofImagesCount;

  const RoomUtilityCard({
    Key? key,
    required this.roomName,
    required this.tenantName,
    this.phone,
    required this.status,
    this.totalAmount,
    this.elecOld,
    this.elecNew,
    this.elecDiff,
    this.elecCost,
    this.waterOld,
    this.waterNew,
    this.waterDiff,
    this.waterCost,
    this.warningTag,
    this.warningMessage,
    this.proofImagesCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAbnormal = status == RoomUtilityStatus.abnormal;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAbnormal ? const Color(0xFFFFF5F5) : RoomCardColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: isAbnormal ? Border.all(color: RoomCardColors.redAlert.withOpacity(0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //hàng tiêu đề: tên phòng + badge trạng thái + tạm tính tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(roomName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 8),
                  _buildBadge(),
                ],
              ),
              if (totalAmount != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Tạm tính điện nước', style: TextStyle(fontSize: 10, color: RoomCardColors.textSecondary)),
                    Text(totalAmount!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 4),

          //hàng hiển thị thông tin khách thuê + sđt
          Row(
            children: [
              if (status != RoomUtilityStatus.abnormal)
                Text('Khách: $tenantName', style: const TextStyle(fontSize: 12, color: RoomCardColors.textSecondary))
              else ...[
                const Icon(Icons.person_outline, size: 14, color: RoomCardColors.textSecondary),
                const SizedBox(width: 4),
                Text(tenantName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                const Icon(Icons.phone_outlined, size: 14, color: RoomCardColors.textSecondary),
                const SizedBox(width: 4),
                Text(phone ?? '', style: const TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.bold)),
              ]
            ],
          ),
          const SizedBox(height: 10),

          //box cảnh báo màu đỏ hồng nếu bất thường
          if (isAbnormal && warningMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: RoomCardColors.redLightBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: RoomCardColors.redAlert, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      warningMessage!,
                      style: const TextStyle(color: RoomCardColors.redAlert, fontSize: 11, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ],

          //chuyển đổi nội dung ô nhập/thông số theo trạng thái
          if (status == RoomUtilityStatus.inputting) ...[
            _buildInputSection(),
          ] else if (status == RoomUtilityStatus.pending) ...[
            _buildPendingSection(),
          ] else ...[
            //dạng 2 cột điện & nước (Đã chốt / Bất thường)
            Row(
              children: [
                Expanded(child: _buildMetricBox('⚡ Điện (kWh)', elecOld, elecNew, elecDiff, elecCost, isAbnormal)),
                const SizedBox(width: 8),
                Expanded(child: _buildMetricBox('💧 Nước (m³)', waterOld, waterNew, waterDiff, waterCost, false)),
              ],
            ),
            const SizedBox(height: 10),

            if (status == RoomUtilityStatus.completed) _buildCompletedFooter(),
            if (status == RoomUtilityStatus.abnormal) _buildAbnormalFooter(),
          ],
        ],
      ),
    );
  }

  //badge trạng thái
  Widget _buildBadge() {
    switch (status) {
      case RoomUtilityStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: RoomCardColors.greenLightBg, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: const [
              Icon(Icons.check_circle_outline, size: 12, color: RoomCardColors.accentGreen),
              SizedBox(width: 2),
              Text('Đã chốt', style: TextStyle(color: RoomCardColors.accentGreen, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case RoomUtilityStatus.abnormal:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: RoomCardColors.redLightBg, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              const Icon(Icons.ac_unit, size: 12, color: RoomCardColors.redAlert),
              const SizedBox(width: 2),
              Text(warningTag ?? 'Bất thường', style: const TextStyle(color: RoomCardColors.redAlert, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case RoomUtilityStatus.inputting:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: const [
              Icon(Icons.edit_note, size: 12, color: Colors.brown),
              SizedBox(width: 2),
              Text('Chờ nhập số', style: TextStyle(color: Colors.brown, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case RoomUtilityStatus.pending:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: RoomCardColors.chipGray, borderRadius: BorderRadius.circular(8)),
          child: const Text('Chưa nhập', style: TextStyle(color: RoomCardColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        );
    }
  }

  //ô thông số Cũ / Mới / Tiền
  Widget _buildMetricBox(String title, String? oldVal, String? newVal, String? diffVal, String? costVal, bool isAlert) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isAlert ? Colors.white : RoomCardColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isAlert ? RoomCardColors.redAlert : RoomCardColors.textSecondary)),
              if (diffVal != null) Text(diffVal, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isAlert ? RoomCardColors.redAlert : RoomCardColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cũ: $oldVal', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
              Text(newVal ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isAlert ? RoomCardColors.redAlert : RoomCardColors.textPrimary)),
            ],
          ),
          if (costVal != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tiền điện', style: TextStyle(fontSize: 10, color: RoomCardColors.textSecondary)),
                Text(costVal, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ]
        ],
      ),
    );
  }

  //thiết kế khung ô nhập chỉ số riêng (Chờ nhập số)
  Widget _buildInputSection() {
    return Column(
      children: [
        //khung nhập số điện riêng
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: RoomCardColors.backgroundLight, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('⚡ Chỉ số điện mới (kWh)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  Text('Số cũ: ${elecOld ?? "0"}', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: const TextField(
                        decoration: InputDecoration(hintText: 'Nhập số mới...', hintStyle: TextStyle(fontSize: 11), border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(color: RoomCardColors.primaryDarkGreen, borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('Tăng nhanh:', style: TextStyle(fontSize: 10, color: RoomCardColors.textSecondary)),
                  const SizedBox(width: 6),
                  _buildQuickChip('+100'),
                  const SizedBox(width: 4),
                  _buildQuickChip('+125'),
                  const SizedBox(width: 4),
                  _buildQuickChip('+150'),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 8),

        //khung nhập số nước riêng
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: RoomCardColors.backgroundLight, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('💧 Chỉ số nước mới (m³)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  Text('Số cũ: ${waterOld ?? "0"}', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                      child: const TextField(
                        decoration: InputDecoration(hintText: 'Nhập số mới...', hintStyle: TextStyle(fontSize: 11), border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(color: RoomCardColors.primaryDarkGreen, borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text('Tăng nhanh:', style: TextStyle(fontSize: 10, color: RoomCardColors.textSecondary)),
                  const SizedBox(width: 6),
                  _buildQuickChip('+5 m³'),
                  const SizedBox(width: 4),
                  _buildQuickChip('+8 m³'),
                  const SizedBox(width: 4),
                  _buildQuickChip('+12 m³'),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),

        //nút lưu số phòng
        SizedBox(
          width: double.infinity,
          height: 38,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save, size: 16, color: Colors.white),
            label: Text('Lưu số $roomName', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: RoomCardColors.primaryDarkGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        )
      ],
    );
  }

  //giao diện chưa nhập
  Widget _buildPendingSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: RoomCardColors.backgroundLight, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Điện cũ: ${elecOld ?? "0"} kWh', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
              Text('Nước cũ: ${waterOld ?? "0"} m³', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt_outlined, size: 16, color: RoomCardColors.primaryDarkGreen),
                label: const Text('Chụp ảnh', style: TextStyle(color: RoomCardColors.primaryDarkGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                label: const Text('Nhập số', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RoomCardColors.primaryDarkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  //footer chứng từ cho card đã chốt
  Widget _buildCompletedFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildProofThumb('OCR'),
            const SizedBox(width: 4),
            _buildProofThumb('OCR'),
            const SizedBox(width: 6),
            Text('$proofImagesCount ảnh chứng từ', style: const TextStyle(fontSize: 11, color: RoomCardColors.textSecondary)),
          ],
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit, size: 14, color: RoomCardColors.textPrimary),
          label: const Text('Sửa', style: TextStyle(color: RoomCardColors.textPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        )
      ],
    );
  }

  //footer thao tác cho card bất thường
  Widget _buildAbnormalFooter() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined, size: 14, color: RoomCardColors.textPrimary),
            label: const Text('Chụp lại công tơ', style: TextStyle(color: RoomCardColors.textPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle, size: 14, color: RoomCardColors.textPrimary),
            label: const Text('Xác nhận số đúng', style: TextStyle(color: RoomCardColors.textPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: RoomCardColors.orangeWarning,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  //chip nút tăng nhanh
  Widget _buildQuickChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black12)),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  //thumbnail ảnh chứng từ có tag OCR
  Widget _buildProofThumb(String tag) {
    return Stack(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.speed, size: 20, color: Colors.grey),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withOpacity(0.6),
            child: Text(
              tag,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}