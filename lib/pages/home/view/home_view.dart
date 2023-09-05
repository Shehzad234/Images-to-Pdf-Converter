import 'dart:io';

import '/pages/about/view/about_view.dart';
import '/pages/home/view_model/home_viewmodel.dart';
import '/pages/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const path = "homepage";

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image to Pdf Converter"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AboutView.path),
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: homeViewModel.filePickedFlag
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          // padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.brown)),
                          height: screenSize.height * 0.6,
                          child: RawScrollbar(
                            thumbColor: Colors.tealAccent,
                            thickness: 8,
                            child: ListView.builder(
                              itemCount: homeViewModel.imageFilePath!.length,
                              itemBuilder: (context, index) => Card(
                                margin: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    fit: BoxFit.cover,
                                    File(homeViewModel
                                        .imageFilePath![index].path!),
                                    height: screenSize.height * .4,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            maximumSize: const Size(250, 80),
                            minimumSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () =>
                            homeViewModel.convertimageToPdf(context),
                        child: const Text("Convert to Pdf"))
                  ],
                ),
              ),
            )
          : const Center(
              child: Text("Import your file",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeViewModel.pickimageFile(),
        child: const Icon(Icons.photo),
      ),
      drawer: const MyDrawer(),
    );
  }
}
