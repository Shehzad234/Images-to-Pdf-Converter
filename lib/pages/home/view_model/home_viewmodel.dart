import 'dart:developer';
import 'dart:io';

import '../../converted/view/converted_view.dart';
import '/utils/loading_popup.dart';
import '/utils/show_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeViewModel extends ChangeNotifier {
  List<PlatformFile>? imageFilePath;
  String? pdfFileName;
  String? pdfFilepath;
  bool filePickedFlag = false;
  List<File>? image;

  pickimageFile() async {
    final file = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        dialogTitle: "Pick image File");
    if (file != null) {
      log(file.files.first.path!);
      // if (file.files.first.path!.endsWith(".image") == false &&
      //     file.files.first.path!.endsWith(".jpg") == false &&
      //     file.files.first.path!.endsWith(".jpeg") == false) {
      //   showMessage("Only Png,Jpg,Jpeg format supported");
      //   return;
      // }

      imageFilePath = file.files;

      // imageFileName = file.files.first.name;

      filePickedFlagPositive();
      // log("$imageFileName $imageFilePath");
    }
  }

  convertimageToPdf(context) async {
    loadingPopup(context);
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final pdf = pw.Document();

      for (var i in imageFilePath!) {
        final image = pw.MemoryImage(File(i.path!).readAsBytesSync());
        pdf.addPage(
            pw.Page(build: (context) => pw.Center(child: pw.Image(image))));
      }

      List temp = imageFilePath!.first.path!.split("/");
      temp.removeLast();
      pdfFileName = "${DateTime.now().millisecond}.pdf";
      pdfFilepath = "${temp.join("/")}/$pdfFileName";

      final file = File(pdfFilepath!);
      await file.writeAsBytes(await pdf.save()).then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(ConvertedView.path);
        showMessage("Sucessfully Converted");
        filePickedFlagNagative();
      });
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context).pop();
    }
  }

  filePickedFlagPositive() {
    filePickedFlag = true;
    notifyListeners();
  }

  filePickedFlagNagative() {
    filePickedFlag = false;
    notifyListeners();
  }

  //---------------------FOR DRAWER-------------------------------

}
