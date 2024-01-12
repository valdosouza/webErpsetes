import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/dashboard/data/model/analytic_info_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({Key? key, required this.info}) : super(key: key);

  final AnalyticInfo info;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Container(
        height: 105,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: kBoxDecorationAnalyticCard,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  info.title!,
                  maxLines: 1,
                  maxFontSize: 18,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding / 2),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: info.color!.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    color: info.color,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            AutoSizeText(
              maxLines: 1,
              maxFontSize: 28,
              minFontSize: 16,
              info.value!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kSecondaryColor,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
