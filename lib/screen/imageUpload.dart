import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

int iii = 0;
List<String> durl = [];
Map<String, String> all = {};
String downUrl = "";
Future imageUpload1(images, dateToday) async {
  // print(images.length);
  List image = [];
  image.add(await images);

  Reference firebaseStorage =
      FirebaseStorage.instance.ref().child("$dateToday").child("$iii.png");
  UploadTask uploadTask;
  iii++;
  for (var img in image) {
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    uploadTask = firebaseStorage.putData(img, metadata);
    await uploadTask.whenComplete(() async {
      downUrl = await firebaseStorage.getDownloadURL();
      durl.add(downUrl);
      // print("hello1234 $durl");
      // print(all.length);
    });

    for (int ii = 0; ii < durl.length; ii++) {
      all.addAll({"$ii": durl[ii]});

      // print(all);
    }

    await FirebaseFirestore.instance
        .collection("images")
        .doc("$dateToday")
        .collection("value")
        .doc("links")
        .set(all);
    await FirebaseFirestore.instance
        .collection("images")
        .doc("$dateToday")
        .set({"image": iii});
    String date = dateToday.toString();
    String replacesp = date.replaceAll(" ", "%20");
    String replaceo = replacesp.replaceAll(":", "%3A");
    await FirebaseFirestore.instance
        .collection("id")
        .doc("$replaceo")
        .set({"datetime": "$dateToday"});
  }
}
