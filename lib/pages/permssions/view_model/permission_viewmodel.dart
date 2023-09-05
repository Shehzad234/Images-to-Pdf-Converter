import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../home/view/home_view.dart';

class PermissionViewModel extends ChangeNotifier {
  allowPermission({required BuildContext context}) async {
    final info = await DeviceInfoPlugin().androidInfo;
    final androVersion = info.version.release;
    if (int.parse(androVersion.split("")[0]) >= 13) {
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();
      await Permission.storage.request();
    } else {
      await Permission.storage.request();
      if (await Permission.storage.isGranted) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeView.path, (route) => false);
      }
    }
  }
}
