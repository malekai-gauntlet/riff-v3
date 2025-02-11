import 'package:flutter/material.dart';

class FeedToggle extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onToggle;

  const FeedToggle({
    super.key,
    required this.selectedIndex,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // _buildToggleButton('Following', 0),
        // const SizedBox(width: 24),
        
        _buildToggleButton('Electric', 4),
        const SizedBox(width: 24),
        _buildToggleButton('Fingerstyle', 3),
        const SizedBox(width: 24),
        _buildToggleButton('Acoustic', 2),
        const SizedBox(width: 24),
        _buildToggleButton('For You', 1),
      ],
    );
  }

  Widget _buildToggleButton(String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onToggle(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 2),
          // Animated indicator line
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 24,
            height: 2,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
} 