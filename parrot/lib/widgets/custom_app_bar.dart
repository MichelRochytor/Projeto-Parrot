import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Color(0xFF104862)),
                onPressed: onBack ?? () => Navigator.pop(context),
              )
            else
              IconButton(
                icon: const Icon(Icons.menu, size: 28, color: Color(0xFF104862)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/image/imagem.png',
                  height: 38,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Placeholder para manter o logo centralizado
            const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}
