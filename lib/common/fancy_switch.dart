import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/riverpod_management.dart';

class FancySwitch extends ConsumerStatefulWidget {
  final bool value;
  final double height;
  final String activeModeBackgroundImage;
  final String inactiveModeBackgroundImage;
  final Color activeThumbColor;
  final Image? activeThumbImage;
  final Color inactiveThumbColor;
  final Image? inactiveThumbImage;

  const FancySwitch({
    super.key,
    required this.value,
    required this.height,
    required this.inactiveModeBackgroundImage,
    required this.activeModeBackgroundImage,
    this.activeThumbColor = Colors.white,
    this.activeThumbImage,
    this.inactiveThumbColor = Colors.white,
    this.inactiveThumbImage,
  });

  @override
  ConsumerState<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends ConsumerState<FancySwitch> {
  @override
  Widget build(BuildContext context) {
    const aspectRatio = (57 / 25);
    return GestureDetector(
      onTap: () => ref.read(themeRiverpod).toggleDarkMode(!widget.value),
      child: SizedBox(
        height: widget.height,
        width: aspectRatio * widget.height,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular((16 / 25) * widget.height),
              child: Image.asset(
                widget.value
                    ? widget.activeModeBackgroundImage
                    : widget.inactiveModeBackgroundImage,
                height: widget.height,
                width: aspectRatio * widget.height,
                fit: BoxFit.cover,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding:
                  EdgeInsets.symmetric(horizontal: (2 / 25) * widget.height),
              alignment:
                  widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: ClipOval(
                child: SizedBox(
                  height: (4 / 5) * widget.height,
                  width: (4 / 5) * widget.height,
                  child: widget.value
                      ? widget.activeThumbImage
                      : widget.inactiveThumbImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
