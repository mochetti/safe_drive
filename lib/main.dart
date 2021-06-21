import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart'; 
import 'camera_view.dart';

List<CameraDescription> cameras = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FaceDetectorView(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   void dale() async {
//     final camera; // your camera instance
//     final WriteBuffer allBytes = WriteBuffer();
//     for (Plane plane in cameraImage.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();

//     final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

//     final InputImageRotation imageRotation =
//         InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
//             InputImageRotation.Rotation_0deg;

//     final InputImageFormat inputImageFormat =
//         InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
//             InputImageFormat.NV21;

//     final planeData = cameraImage.planes.map(
//       (Plane plane) {
//         return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width,
//         );
//       },
//     ).toList();

//     final inputImageData = InputImageData(
//       size: imageSize,
//       imageRotation: imageRotation,
//       inputImageFormat: inputImageFormat,
//       planeData: planeData,
//     );

//     final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

//     final faceDetector = GoogleMlKit.vision.faceDetector();
//     final List<Face> faces = await faceDetector.processImage(inputImage);

//     for (Face face in faces) {
//       final Rect boundingBox = face.boundingBox;

//       final double rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
//       final double rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

//       // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
//       // eyes, cheeks, and nose available):
//       final FaceLandmark leftEar = face.getLandmark(FaceLandmarkType.leftEar);
//       if (leftEar != null) {
//         final Point<double> leftEarPos = leftEar.position;
//       }

//       // If classification was enabled with FaceDetectorOptions:
//       if (face.smilingProbability != null) {
//         final double smileProb = face.smilingProbability;
//       }

//       // If face tracking was enabled with FaceDetectorOptions:
//       if (face.trackingId != null) {
//         final int id = face.trackingId;
//       }
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: ,
//       //   tooltip: 'Increment',
//       //   child: Icon(Icons.add),
//       // ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class FaceDetectorView extends StatefulWidget {
  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Face Detector',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    print('Found ${faces.length} faces');
    // if (inputImage.inputImageData?.size != null &&
    //     inputImage.inputImageData?.imageRotation != null) {
    //   final painter = FaceDetectorPainter(
    //       faces,
    //       inputImage.inputImageData!.size,
    //       inputImage.inputImageData!.imageRotation);
    //   customPaint = CustomPaint(painter: painter);
    // } else {
    //   customPaint = null;
    // }
    // isBusy = false;
    // if (mounted) {
    //   setState(() {});
    // }
  }
}
