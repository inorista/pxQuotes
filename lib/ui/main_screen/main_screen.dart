import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pxquotes/blocs/card_quotes/card_quotes_bloc.dart';
import 'package:pxquotes/blocs/save_to_clipboard/save_to_clipboard_bloc.dart';
import 'package:pxquotes/blocs/share_scan_result/share_scan_result_bloc.dart';
import 'package:pxquotes/constants/app_style.dart';
import 'package:pxquotes/constants/gradient_color.dart';
import 'package:pxquotes/models/quote_model.dart';
import 'package:pxquotes/utils/method_utils.dart';
import 'package:screenshot/screenshot.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CardSwiperController controller = CardSwiperController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            pinned: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app_icon.png",
                  height: 70,
                  width: 70,
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 0.72.sh,
              width: 1.sw,
              child: BlocBuilder<CardQuotesBloc, CardQuotesState>(
                builder: (context, state) {
                  if (state is CardQuotesLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state is CardQuotesLoaded) {
                    final listQuotes = state.quotes;
                    context.read<ShareScanResultBloc>().add(ChangeIndex(model: state.quotes[0]));
                    return Screenshot(
                      controller: BlocProvider.of<ShareScanResultBloc>(context).controller,
                      child: CardSwiper(
                        numberOfCardsDisplayed: state.quotes.length > 3 ? 3 : 1,
                        initialIndex: 0,
                        isLoop: true,
                        maxAngle: 20,
                        controller: controller,
                        cardsCount: listQuotes.length,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          context.read<ShareScanResultBloc>().add(ChangeIndex(model: state.quotes[currentIndex!]));
                          return true;
                        },
                        cardBuilder: (context, index) {
                          final quote = listQuotes[index];
                          return CardWidget(quote: quote);
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.2.sw,
                vertical: 30,
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 0.5.sw),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mainColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocListener<SaveToClipboardBloc, SaveToClipboardState>(
                      listener: (saveContext, saveState) {
                        if (saveState is SaveSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            MethodUtils().getSnackBar(
                              content: const Center(
                                child: Text(
                                  "Saved to Clipboard!",
                                  style: TextStyle(
                                    color: Color(0xff16141A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              dismissDirection: DismissDirection.horizontal,
                            ),
                          );
                        } else if (saveState is SaveFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            MethodUtils().getSnackBar(
                              content: const Center(
                                child: Text(
                                  "Saved Failed!",
                                  style: TextStyle(
                                    color: Color(0xff16141A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              dismissDirection: DismissDirection.horizontal,
                            ),
                          );
                        }
                      },
                      child: ActionItem(
                        icon: Icon(
                          EvaIcons.copyOutline,
                          color: listColor[12],
                        ),
                        callback: () async {
                          //context.read<SaveToClipboardBloc>().add(SaveToClipboard(text: state.listText[0]));
                        },
                      ),
                    ),
                    ActionItem(
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        color: listColor[12],
                      ),
                      callback: () async {
                        final timeCreated = "Scan ${DateFormat("dd.MM.yyyy - hh.mma").format(DateTime.now())}.jpg";
                        context.read<ShareScanResultBloc>().add(
                              ShareScanResult(
                                fileName: timeCreated,
                              ),
                            );
                      },
                    ),
                    ActionItem(
                      icon: Icon(
                        EvaIcons.downloadOutline,
                        color: listColor[12],
                      ),
                      callback: () async {
                        final timeCreated = "Scan ${DateFormat("dd.MM.yyyy - hh.mma").format(DateTime.now())}.jpg";
                        context.read<ShareScanResultBloc>().add(
                              ShareScanResult(
                                fileName: timeCreated,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.quote,
  });

  final QuoteModel quote;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      quote.color1 ?? Colors.transparent,
                      quote.color2 ?? Colors.transparent,
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        quote.imageUrl ?? "assets/images/pattern.png",
                        color: Colors.white.withOpacity(0.2),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 5,
                              ),
                              child: Container(
                                color: Colors.white.withOpacity(0.02),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/quote_icon.png",
                                    color: Colors.white,
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${quote.content}",
                                    style: AppStyle.quoteStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.white,
                                    endIndent: 0.4.sw,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${quote.author}",
                                    style: AppStyle.titleHightLightedStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            """/ Powered by Quoc Tu""",
                            style: AppStyle.quoteStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final VoidCallback callback;
  final Icon icon;
  const ActionItem({
    required this.icon,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
          ),
          child: icon,
        ),
      ),
    );
  }
}
