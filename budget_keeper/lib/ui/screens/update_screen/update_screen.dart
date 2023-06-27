import 'package:budget_keeper/ui/screens/update_screen/update_screen_body.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/account.dart';
import '../../components/navigation_bar/custom_nav_bar.dart';
import '../../components/navigation_bar/main_screen_title.dart';

class UpdateScreen extends StatelessWidget {
  final bool shouldHideActions = true;
  final bool isNew;
  final Account? currentAccount;

  const UpdateScreen({this.currentAccount, required this.isNew, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            shouldHideActions: shouldHideActions,
            shouldHideLeading: false,
            refreshUpdateCallBack: () {}),
        body: UpdateScreenBody(currentAccount: currentAccount, isNew: isNew));
  }
}

class UpdateScreenBody extends StatelessWidget {
  final String mainScreenTitle;
  final Account? currentAccount;
  final bool isNew;

  const UpdateScreenBody({
    super.key,
    required this.currentAccount,
    required this.isNew,
  }) : mainScreenTitle = (isNew) ? 'New Account' : 'Update Account';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenMainTitle(mainScreenTitle: mainScreenTitle),
          const SizedBox(
            height: 240,
          ),
          UpdateScreenFields(currentAccount: currentAccount, isNew: isNew),
        ],
      ),
    );
  }
}
