import 'package:digital_menu/common/app_constants.dart';
import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactSupport extends ConsumerStatefulWidget {
  const ContactSupport({super.key});

  @override
  ConsumerState<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends ConsumerState<ContactSupport> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    return Scaffold(
      appBar: AppConstant().mobileAppBarWithLabel(themeProvider.darkMode, 'Support'),
      body: SafeArea(
          child: Container(
        color: themeProvider.darkMode
            ? AppConstant.darkPrimary
            : AppConstant.lightBg,
        padding: const EdgeInsets.all(20),
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Support",
              style: TextStyle(fontFamily: "Questrial", fontSize: 26),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenSize.width,
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/images/support.svg',
                width: 250,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                'We regret to inform you that currently there are few issues with this feature. we will try to bring it back soon meanwhile please mail at "digitalmenu.support@gmail.com" for any queries, we will get back to you as soon as possible',
                style: GoogleFonts.workSans(fontSize: 14, color: Colors.black))
          ],
        ),
      )),
    );
  }
}
