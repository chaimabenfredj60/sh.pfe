import 'package:flutter/material.dart';

class CooptaliteTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CooptaliteTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Spacer(),

          // ── Right: icons + user ────────────────────────────────────────
          Icon(Icons.language, size: 18, color: const Color(0xFF9E9E9E)),
          const SizedBox(width: 4),
          const Text(
            'English',
            style: TextStyle(fontSize: 13, color: Color(0xFF555555)),
          ),
          const SizedBox(width: 16),
          Icon(Icons.dark_mode_outlined,
              size: 18, color: const Color(0xFF9E9E9E)),
          const SizedBox(width: 16),

          // User profile
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Membre',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333)),
                  ),
                  Text(
                    'member',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF00B4A6),
                    child: const Text(
                      'BW',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
