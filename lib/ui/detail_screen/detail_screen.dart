import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pxquote/models/quote_model.dart';
import 'package:pxquote/ui/main_screen/main_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.card, super.key});
  final QuoteModel card;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: 1.sh,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                height: 1.sh,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      card.color1!.withOpacity(0.75),
                      card.color1!.withOpacity(0.6),
                      card.color2!.withOpacity(0.5),
                      card.color2!.withOpacity(0.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.white.withOpacity(0.01),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.65.sh,
              width: 0.95.sw,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: CardWidget(
                  quote: card,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
