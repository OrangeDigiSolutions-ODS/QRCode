import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:qrcode/category/category.dart";
import "package:qrcode/category/image.dart";
import "package:qrcode/category/pdf.dart";
import "package:qrcode/components/bottombar.dart";
import "package:qrcode/components/topbar.dart";
import "package:qrcode/desktopview/desktopdesign.dart";
import "package:qrcode/desktopview/image.dart";
import "package:qrcode/desktopview/pdf.dart";
import "package:qrcode/main.dart";
import "package:network_image_mock/network_image_mock.dart";
import "package:qrcode/qrviewer/qr.dart";
import "package:qrcode/screen/sliderpage.dart";
import "package:qrcode/screen/splashscreen.dart";

void main() {
  testWidgets("Material App testing", (_) async {
    await _.pumpWidget(const QRCode());
    expect(find.byType(MaterialApp), findsWidgets);
  });

  testWidgets("splash App testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: SplashScreen(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Slider App testing", (_) async {
    mockNetworkImagesFor(() async {
      await _.pumpWidget(const MaterialApp(
        home: SliderPage(),
      ));
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
  testWidgets("Bottom Bar App testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: BottomBar(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Category testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: Category(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Top Bar App testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: TopBar(
        title: "IMAGE TO QR CODE",
      ),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Image to QR testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: ImageToQr(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Pdf to QR testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: PdfToQr(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("QRPage testing", (_) async {
    await _.pumpWidget(MaterialApp(
      home: QRPage(
        url: "hello",
      ),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Desktop design testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: DesktopDesign(),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Desktop image testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: DesktopViewImage(
        title: "IMAGE TO QR CODE",
        browse: "Browse",
        generate: "Generate",
        icon1: Icons.insert_drive_file,
        icon2: Icons.check,
      ),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets("Desktop Pdf testing", (_) async {
    await _.pumpWidget(const MaterialApp(
      home: DesktopViewPdf(
        title: "PDF TO QR CODE",
        browse: "Upload PDF",
        generate: "Create Qr",
        icon1: Icons.cloud_upload,
        icon2: Icons.check,
      ),
    ));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
