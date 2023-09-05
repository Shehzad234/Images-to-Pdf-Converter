import '/pages/permssions/view_model/permission_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PermissionView extends StatelessWidget {
  static const path = "permission_view";
  const PermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Images to Pdf Converter"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      // backgroundColor: const Colors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.03),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/icon.png",
                      ),
                    )),
              ],
            ),
            Column(
              children: [
                const Text("Let's Convert your Image to Pdf",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const SizedBox(height: 10),
                Consumer<PermissionViewModel>(
                  builder: (context, value, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(250, 80),
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () => value.allowPermission(context: context),
                      child: const Text("Allow Permission")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
