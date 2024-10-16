import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_image.dart';
import '../../../constants/colors.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Row(
      children: [
        if (!isDesktop)
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuControllers>().controlMenu,
          ),
        if (!isMobile)
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!isMobile) const Spacer(flex: 2),
        // Uncomment if ProfileCard for notifications is needed
        // ProfileCard(
        //   image: AssetsImages.instance.notification,
        //   text: 'Send Notification',
        //   onPress: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => NotificationView()),
        //     );
        //   },
        // ),
        ProfileCard(
          text: 'Accurate Admin',
          image: AssetsImages.instance.manProfile,
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.text,
    this.onPress,
    required this.image,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPress;
  final String image;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 35,
            ),
            const SizedBox(width: 5),
            if (!isMobile)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text(text),
              ),
          ],
        ),
      ),
    );
  }
}
