import 'package:flutter/material.dart';

import '../../../../utils/global_widgets.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: const [
          Text('Home'),
          HEIGHT_12,
        ],
      ),
    );
  }
}
