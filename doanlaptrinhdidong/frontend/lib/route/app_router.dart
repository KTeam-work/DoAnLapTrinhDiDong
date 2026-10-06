import 'package:flutter/material.dart';
import 'app_routes.dart';

// Import màn hình từ frontend/lib/screens/
import '../screens/admin/admin_dashboard.dart';
// import '../screens/admin/admin_stats.dart';
import '../screens/admin/users_manage.dart';
import '../screens/admin/rewview_new.dart';
import '../screens/admin/content_moderation.dart';

import '../screens/owner/contracts_manage.dart';
import '../screens/owner/contract_form.dart';
import '../screens/owner/contract_detail_owner.dart';
import '../screens/owner/contract_members.dart';
import '../screens/owner/termination_screen.dart';
import '../screens/owner/invoices_manage..dart';
import '../screens/owner/invoice_form.dart';
import '../screens/owner/ invoice_detail_owner.dart';
import '../screens/owner/utility_readings.dart';
import '../screens/owner/utility_history.dart';
import '../screens/owner/maintenance_manage.dart';
import '../screens/owner/maintenance_detail.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      // case AppRoutes.adminStats:
      //   return MaterialPageRoute(builder: (_) => const AdminStatsScreen());
      case AppRoutes.usersManage:
        return MaterialPageRoute(builder: (_) => const User());
      case AppRoutes.maintenanceManage:
        return MaterialPageRoute(builder: (_) => const MaintenanceManageScreen());
      case AppRoutes.rewview:
        return MaterialPageRoute(builder: (_)=> const review());

      case AppRoutes.contractsManage:
        return MaterialPageRoute(builder: (_) => const Contracts_manager());
      case AppRoutes.contractForm:
        return MaterialPageRoute(builder: (_) => Contract_form()); // địa chỉ
      case AppRoutes.invoicesManage:
        return MaterialPageRoute(builder: (_) => const Invoice_mana());
      case AppRoutes.invoiceForm:
        return MaterialPageRoute(builder: (_) => Invoice_form()); //địa chỉ

      case AppRoutes.utilityReadings:
        return MaterialPageRoute(builder: (_) => const InvoiceCreateScreen());
      case AppRoutes.utilityHistory:
        return MaterialPageRoute(builder: (_) => const LandlordUtilityScreen());
      case AppRoutes.termination:
        return MaterialPageRoute(builder: (_) => ContractLiquidationScreen()); // id
      case AppRoutes.maintenanceDetail:
        return MaterialPageRoute(builder: (_) => MaintenanceDetailScreen()); // id
      case AppRoutes.contentModeration:
        return MaterialPageRoute(builder: (_) => const RoomApprovalDetailScreen());
      case AppRoutes.contractDetailOwner:
        return MaterialPageRoute(builder: (_) => ContractDetailScreen());// id
      case AppRoutes.contractMembers:
        return MaterialPageRoute(builder: (_) => TenantManagementScreen());// id
      case AppRoutes.invoiceDetailOwner:
        return MaterialPageRoute(builder: (_) => InvoiceDetailScreen());// id

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Lỗi Route')),
            body: Center(child: Text('Không tìm thấy trang: ${settings.name}')),
          ),
        );
    }
  }
}