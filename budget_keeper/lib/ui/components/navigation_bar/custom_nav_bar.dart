import 'package:flutter/material.dart';

import 'custom_nav_buttons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool shouldHideActions;
  final bool shouldHideLeading;
  final void Function() refreshUpdateCallBack;
  //Button Styles

  const CustomAppBar(
      {required this.shouldHideActions,
      required this.shouldHideLeading,
      required this.refreshUpdateCallBack,
      super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 80,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 86, 200)),
      leading: (shouldHideLeading) ? null : const LeadingBackButton(),
      actions: shouldHideActions
          ? []
          : <Widget>[
              NewAccountButton(refreshHomeCallBack: refreshUpdateCallBack)
            ],
    );
  }
}
