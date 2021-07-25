import 'dart:io';

import 'package:app_manager/global/icon_store.dart';
import 'package:app_manager/theme/app_colors.dart';
import 'package:app_manager/utils/app_utils.dart';
import 'package:app_manager/utils/platform_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:global_repository/global_repository.dart';

class AppIconHeader extends StatefulWidget {
  const AppIconHeader({Key key, this.packageName}) : super(key: key);
  final String packageName;

  @override
  _AppIconHeaderState createState() => _AppIconHeaderState();
}

class _AppIconHeaderState extends State<AppIconHeader> {
  bool imgExist = false;
  List<int> _bytes = [];
  @override
  void initState() {
    super.initState();
    loadAppIcon();
    // checkImageExist();
  }

  // Future<void> checkImageExist() async {
  //   if (File('${RuntimeEnvir.filesPath}/AppManager/.icon/${widget.packageName}')
  //       .existsSync()) {
  //     imgExist = true;
  //     setState(() {});
  //   } else {
  //     await PlatformChannel.GetAppIcon.invokeMethod<void>(widget.packageName);
  //     checkImageExist();
  //   }
  // }
  Future<void> loadAppIcon() async {
    if ((_bytes = IconStore().loadCache(widget.packageName)).isEmpty) {
      _bytes = IconStore().cache(
        widget.packageName,
        await AppUtils.loadAppIcon(widget.packageName),
      );
      Log.w('loadAppIcon $_bytes');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_bytes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitThreeBounce(
          color: AppColors.accentColor,
          size: 16.0,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.memory(
          _bytes,
        ),
      );
    }
  }
}
