import 'package:flutter/material.dart';
import '../../../../constant/color.dart';
import '../../../../theme/data/style_text.dart';

class SupportContentWidget extends StatelessWidget {
  const SupportContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: kPrimaryColor,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Support User Service',
                  style: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor)
              ),
              const SizedBox(height: 12),
              Text(
                  'Need help? We already to support to you by all service below:',
                  style: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor)
              ),
              const SizedBox(height: 12),
              _SupportOption(
                icon: Icons.email,
                label: 'Send email',
                onPressed: () {
                  // Hành động gửi email, mở ứng dụng email.
                },
              ),
              _SupportOption(
                icon: Icons.phone,
                label: 'Call phone',
                onPressed: () {
                  // Hành động gọi điện thoại.
                },
              ),
              _SupportOption(
                icon: Icons.chat,
                label: 'Chat online with Helper',
                onPressed: () {
                  // Hành động mở cửa sổ chat hỗ trợ.
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Or you can read FAQ on the website ! Thanks !',
                style: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SupportOption({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: kDefaultColor,
      leading: Icon(icon, color: Colors.white),
      title: Text(
          label,
          style: TextStyleApp.textStyleForm(16, FontWeight.w500, kDefaultColor)
      ),
      trailing: const Icon(Icons.arrow_forward_ios,color: kCardTitleColor,),
      onTap: onPressed,
    );
  }
}