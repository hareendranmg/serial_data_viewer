import 'package:flutter/material.dart';

import '../../../../utils/global_widgets.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: const [
          Text('Settings'),
          HEIGHT_12,
        ],
      ),
    );
  }
}
