import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '';
  double height = 0;
  double weight = 0;
  int resultIndex = 0;
  // declare a custom radio button
  int currentIndex = 0;

  // declare inputController to get input value
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  // make function to calculate BMI
  void calculateBMI(double height, double weight) {
    double finalResult = weight / (height * (height / 10000));
    String bmi = finalResult.toStringAsFixed(2);

    resultIndex = finalResult.toInt();

    setState(() {
      result = bmi;
    });
  }

  // declare function to change value index while pressed
  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // result text
  Widget resultText(resultIndex) {
    if (resultIndex <= 16 && resultIndex > 0) {
      return Center(
        child: Text("UnderWeight",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'PoppinsExBold',
                color: (resultIndex <= 16 || resultIndex >= 27)
                    ? Colors.red
                    : Colors.green)),
      );
    }
    if (resultIndex >= 27) {
      return Center(
        child: Text("OverWeight",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'PoppinsExBold',
                color: (resultIndex <= 16 || resultIndex >= 27)
                    ? Colors.red
                    : Colors.green)),
      );
    }
    if (resultIndex == 0) {
      return Text("a", style: TextStyle(color: Colors.white));
    } else {
      return Center(
        child: Text("Normal",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'PoppinsExBold',
                color: (resultIndex <= 16 || resultIndex >= 27)
                    ? Colors.red
                    : Colors.green)),
      );
    }
  }

  // make a custom widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: FlatButton(
          onPressed: () {
            // button when clicked get currentIndex == index
            changeIndex(index);
          },
          // change colors when the button clicked
          color: currentIndex == index ? color : Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Text(value,
              style: TextStyle(
                  color: currentIndex == index ? Colors.white : color,
                  fontFamily: 'PoppinsBold')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text("BMI Calculator",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'PoppinsExBold'))),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Man", Colors.blue, 0),
                  radioButton("Woman", Colors.pink, 1),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Height',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'PoppinsBold')),
                        TextSpan(
                            text: '(CM)',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'PoppinsReg')),
                      ],
                    ),
                  )),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,

                // add controller
                controller: heightController,

                decoration: InputDecoration(
                  hintText: "Your Height in CM",
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Weight',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'PoppinsBold')),
                        TextSpan(
                            text: '(KG)',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'PoppinsReg')),
                      ],
                    ),
                  )),
              SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,

                // add controller
                controller: weightController,

                decoration: InputDecoration(
                  hintText: "Your Weight in KG",
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 14,
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          height = double.parse(heightController.value.text);
                          weight = double.parse(weightController.value.text);
                        });
                        calculateBMI(height, weight);
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text("Calculate",
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'PoppinsBold'))),
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text('Your Result: ',
                      style: TextStyle(
                          fontSize: 24.0, fontFamily: 'PoppinsBold'))),
              SizedBox(height: 10),
              Center(
                  child: Text('$result',
                      style: TextStyle(
                          fontSize: 68.0,
                          fontFamily: 'PoppinsExBold',
                          color: (resultIndex <= 16 || resultIndex >= 27)
                              ? Colors.red
                              : Colors.green))),
              SizedBox(height: 5),
              resultText(resultIndex),
            ],
          ),
        ),
      ),
    );
  }
}
