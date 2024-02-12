import 'package:flutter/material.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  var list = [
    Step(
        title: Text("address"),
        content: Center(
          child: Text("address details"),
        )),
    Step(
        title: Text("account"),
        content: Center(
          child: Text("account details"),
        )),
    Step(
        title: Text("overview"),
        content: Center(
          child: Text("success"),
        )),
  ];
  var _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stepper(
      // steps: list,
      // currentStep: currentState,
      // onStepTapped: (step) => setState(() => _currentStep = step),
      onStepTapped: (step) {
        setState(() {
          _currentStep = step;
        });
      },
      onStepContinue: () {
        setState(() {
          if (_currentStep < list.length - 1) {
            _currentStep += 1;
          } else {
            _currentStep = 0;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep -= 1;
          } else {
            _currentStep = 0;
          }
        });
      },
      steps: list,
      currentStep: _currentStep,
    ));
  }
}
