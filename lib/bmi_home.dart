import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BmiHome extends StatefulWidget {
  @override
  _BmiHomeState createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  double result = 0;
  String text = "";

  double _sliderValueH = 0;
  double _sluderValueW = 0;
  int val;
  bool _value = false;
  String title = "";
  double w = 0.0;
  double h = 0.0;

  void calculator() {
    setState(() {
      _value = !_value;
      w = MediaQuery.of(context).size.width * 0.7;
      h = MediaQuery.of(context).size.height * 0.3;
      result = _sluderValueW / ((_sliderValueH / 100) * (_sliderValueH / 100));
      if (result > 25) {
        text = "وزنك زياده محتاج تخس 😔";
      } else if (result < 25 && result > 18.5) {
        text = "😉 عاش حافظ علي الوزن ده";
      } else {
        text = "انت مش بتاكل ولا ايه كل شوي ياعم 🤨 ";
      }
      print(val);
      if (val == 1) {
        title = "Female";
      }
      if (val == 2) {
        title = "ذكر";
      } else {
        title = "انثي";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.cyan[400]),
        ),
        centerTitle: true,
        backgroundColor: NeumorphicTheme.baseColor(context),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
//=> Start Slider ================================/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("الطول"),
              Icon(
                Icons.height,
                color: Colors.cyan[400],
              )
            ],
          ),
          Slider(
            value: _sliderValueH,
            activeColor: Colors.cyan[400],
            min: 0,
            max: 300,
            divisions: 300,
            label: _sliderValueH.round().toString(),
            onChanged: (double value) {
              setState(() {
                _sliderValueH = value;
              });
            },
          ),
          Title('الطول : ${_sliderValueH.round().toInt()}'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("الوزن"),
              ),
              FaIcon(
                FontAwesomeIcons.weight,
                size: 20,
                color: Colors.cyan[400],
              ),
            ],
          ),
          Slider(
            activeColor: Colors.cyan[400],
            value: _sluderValueW,
            min: 0,
            max: 180,
            divisions: 180,
            label: _sluderValueW.round().toString(),
            onChanged: (double value) {
              setState(() {
                _sluderValueW = value;
              });
            },
          ),
          Title('kg الوزن : ${_sluderValueW.round().toInt()}'),
//=> end Slider ================================/
          SizedBox(
            height: 20,
          ),
//=> Start Radio ================================/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              Text("Female"),
              Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                    });
                  }),
              Text("Male"),
            ],
          ),
//=> end Radio ================================/
//=> Start Neumorphic Button ================================/
          Neumorphic(
              margin: EdgeInsets.only(top: 12),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 2,
                intensity: 2,
                surfaceIntensity: 3,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: NeumorphicTheme.baseColor(context),
                  elevation: 0,
                  minimumSize: Size(50, 45),
                ),
                onPressed: () {
                  setState(() {
                    calculator();
                  });
                },
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.cyan[400], fontSize: 24),
                ),
              )),
//=> end Neumorphic Button ================================/
          SizedBox(
            height: 40,
          ),
//=> Start Animated Conatainer ===================/
          AnimatedContainer(
            duration: Duration(seconds: 5),
            width: _value ? MediaQuery.of(context).size.width * 0.7 : w,
            height: _value ? MediaQuery.of(context).size.height * 0.3 : h,
            curve: Curves.fastOutSlowIn,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: -4,
                intensity: 4,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
              ),
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 1,
                        child: TextData(
                          fontSize: 20,
                          text: "الجنس : $title  ",
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextData(
                          text: result.toStringAsFixed(0),
                          fontSize: 25,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextData(
                            text: text,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
//=> End Animated Conatainer ===================/
        ],
      ),
    );
  }

  Title(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget TextData({String text, double fontSize, Color color}) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ));
  }
}
