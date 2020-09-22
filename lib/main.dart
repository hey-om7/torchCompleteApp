import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torch_compat/torch_compat.dart';
import 'package:vibration/vibration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screen/screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TorchMain(),
      ),
    );
  }
}
//////////////////////
bool torchStatus =false;
bool flip=false;

class TorchMain extends StatefulWidget {
  @override
  _TorchMainState createState() => _TorchMainState();
}

class _TorchMainState extends State<TorchMain> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.jpg')
          )
      ),
      child: BlurryContainer(
        blur: 9,
        child: Center(
          child: GestureDetector(
            onLongPress: (){
              Vibration.vibrate(duration: 25,);
              _settingModalBottomSheet(context);
            },
            onTap: (){
              Vibration.vibrate(duration: 10,);
              setState(() {
                torchStatus=!torchStatus;
              });

              torchStatus?TorchCompat.turnOn():TorchCompat.turnOff();
            },
            child: BlurryContainer(
              bgColor: torchStatus?CupertinoColors.white:CupertinoColors.black,
              child: Image.asset('assets/images/torch.png',width: 90,height: 90,),
            ),
          ),
        ),
      ),
    );
  }
}




class FlipFrontScreen extends StatefulWidget {
  @override
  _FlipFrontScreenState createState() => _FlipFrontScreenState();
}

class _FlipFrontScreenState extends State<FlipFrontScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Screen.keepOn(true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));

    return MaterialApp(


      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        body: Container(color: CupertinoColors.white,),
      ),
    );
  }
}


//////////////////////


// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool torchStatus =false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme:ThemeData() ,
//       debugShowCheckedModeBanner: false,
//
//       home: Scaffold(
//
//         body: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage('assets/images/background.jpg')
//               )
//           ),
//           child: BlurryContainer(
//             blur: 9,
//             child: Center(
//               child: GestureDetector(
//                 onLongPress: (){
//                   Vibration.vibrate(duration: 25,);
//                 },
//                 onTap: (){
//                   Vibration.vibrate(duration: 10,);
//                   setState(() {
//                     torchStatus=!torchStatus;
//                   });
//                   //_settingModalBottomSheet(context);
//                   torchStatus?TorchCompat.turnOn():TorchCompat.turnOff();
//                 },
//                 child: BlurryContainer(
//                   bgColor: torchStatus?CupertinoColors.white:CupertinoColors.black,
//                   child: Image.asset('assets/images/torch.png',width: 90,height: 90,),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



void _settingModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
    return BottomSheetDialog();

      }
      );
}


class BottomSheetDialog extends StatefulWidget {
  @override
  _BottomSheetDialogState createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height*0.5,

      decoration: BoxDecoration(
        // color: Colors.red,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Colors.grey,
                CupertinoColors.white
              ]
          ),
          borderRadius: BorderRadius.only(topRight: Radius.circular(60),topLeft: Radius.circular(60))
      ),
      child: Column(
        children: [
          Text('Torch App',
            style: GoogleFonts.getFont('PT Sans',
                fontSize: 30,
                fontWeight: FontWeight.w500),),
          Spacer(),
          GestureDetector(
            onTap: (){
              print('Flipped');
              setState(() {
                Screen.setBrightness(1.0);
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context)=>FlipFrontScreen()));


              });
            },

            child: Container(
              width: 155,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Flip',style: GoogleFonts.getFont('Comfortaa',fontWeight: FontWeight.w600,
                  fontSize: 24),),
                  SizedBox(width: 10,),
                  Icon(Icons.repeat)
                ],
              ),
            ),
          ),
          Spacer(),
          RaisedButton(

            onPressed: (){

            },
            color: Colors.blue,
            child: Text('Get Premium',style: TextStyle(
              color: CupertinoColors.white,
            ),),
          ),
          Text('v1.0')
        ],
      ),
    );
  }
}
