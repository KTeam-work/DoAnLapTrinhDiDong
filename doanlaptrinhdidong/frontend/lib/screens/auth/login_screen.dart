import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // =========================
  // QUÊN MẬT KHẨU
  // =========================
  void _showForgotPasswordDialog() {
    final resetEmailController = TextEditingController();
    final resetFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.lock_reset_rounded,
                color: AppColors.primaryGreen,
              ),
              SizedBox(width: 10),
              Text(
                'Quên mật khẩu',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          content: Form(
            key: resetFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập email hoặc SĐT đăng ký để nhận mã khôi phục mật khẩu.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: resetEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email hoặc SĐT',
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.lightGreen,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primaryGreen,
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập email hoặc SĐT';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Hủy',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size(100, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (resetFormKey.currentState!.validate()) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Mã khôi phục đã được gửi tới '
                        '${resetEmailController.text}',
                      ),
                      backgroundColor: AppColors.primaryGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Gửi mã',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // INPUT STYLE
  // =========================
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
      ),

      prefixIcon: Icon(
        prefixIcon,
        color: AppColors.textSecondary,
        size: 21,
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: AppColors.background,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8E5),
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.primaryGreen,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          // ==================================================
          // PHẦN NỀN XANH PHÍA TRÊN
          // ==================================================
          Container(
            height: screenHeight * 0.43,
            width: double.infinity,
            color: AppColors.primaryGreen,

            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 28),

                  // LOGO
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: AppColors.cardSurface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.home_work_rounded,
                      size: 48,
                      color: AppColors.primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'TRỌ ƠI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Tìm phòng dễ dàng - Sống thoải mái',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==================================================
          // CARD LOGIN
          // ==================================================
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: screenHeight * 0.31,
                left: 20,
                right: 20,
                bottom: 30,
              ),

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.fromLTRB(
                  22,
                  28,
                  22,
                  24,
                ),

                decoration: BoxDecoration(
                  color: AppColors.cardSurface,

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ==================================================
                      // TITLE
                      // ==================================================
                      const Text(
                        'Đăng nhập',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Chào mừng bạn quay trở lại!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ==================================================
                      // EMAIL / SĐT
                      // ==================================================
                      const Text(
                        'Email hoặc số điện thoại',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,

                        decoration: _inputDecoration(
                          hintText: 'Nhập email hoặc số điện thoại',
                          prefixIcon: Icons.person_outline_rounded,
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Vui lòng nhập Email hoặc SĐT';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // ==================================================
                      // PASSWORD
                      // ==================================================
                      const Text(
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,

                        decoration: _inputDecoration(
                          hintText: 'Nhập mật khẩu',
                          prefixIcon: Icons.lock_outline_rounded,

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword =
                                    !_obscurePassword;
                              });
                            },

                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,

                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // ==================================================
                      // GHI NHỚ + QUÊN MẬT KHẨU
                      // ==================================================
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,

                                child: Checkbox(
                                  value: _rememberMe,

                                  activeColor:
                                      AppColors.primaryGreen,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5),
                                  ),

                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe =
                                          value ?? false;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(width: 6),

                              const Text(
                                'Ghi nhớ đăng nhập',
                                style: TextStyle(
                                  color:
                                      AppColors.textSecondary,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: _showForgotPasswordDialog,

                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color:
                                    AppColors.primaryGreen,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // BUTTON LOGIN
                      // ==================================================
                      SizedBox(
                        height: 52,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.accentYellow,

                            foregroundColor:
                                AppColors.textPrimary,

                            elevation: 2,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),

                          onPressed: () {
                            if (_formKey.currentState!
                                .validate()) {
                              // TODO:
                              // Xử lý đăng nhập API
                            }
                          },

                          child: const Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // HOẶC
                      // ==================================================
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          const Padding(
                            padding:
                                EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              'HOẶC',
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    AppColors.textSecondary,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ==================================================
                      // ĐĂNG KÝ
                      // ==================================================
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          const Text(
                            'Chưa có tài khoản? ',
                            style: TextStyle(
                              color:
                                  AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                color:
                                    AppColors.primaryGreen,
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}