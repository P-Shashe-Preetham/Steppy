import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_theme.dart';

class SteppyIconButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onTap;
  final bool hasNotification;
  final String? tooltip;

  const SteppyIconButton({
    super.key,
    required this.iconAsset,
    this.onTap,
    this.hasNotification = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.iconButtonBg,
              width: 44,
              height: 44,
            ),
            SvgPicture.asset(
              iconAsset,
              width: 20,
              height: 20,
            ),
            if (hasNotification)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.notificationRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
