import 'package:flutter/material.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({Key? key}) : super(key: key);

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  int currentStep = 0;
  bool isCompleted = false;

  Widget buildCompleted() {
    return Column(
      children: [
        Center(
          child: Container(
            child: Image.asset("assets/images/completed.jpg"),
          ),
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            isCompleted = false;
            currentStep=0;
            firstNameController.clear();
            lastNameController.clear();
            addressController.clear();
            postCodeController.clear();
          });
        },
          child: const Text("Reset"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Stepper Page")),
        body: isCompleted ? buildCompleted() : Stepper(
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              setState(() {
                isCompleted = true;
              });
              print("completed");

              /// This is the step to send data to server

            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          // type: StepperType.horizontal,
          type: StepperType.vertical,
          elevation: 25,
          steps: getSteps(),
          currentStep: currentStep,
          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            // final isLastStep = currentStep == getSteps().length - 1;

            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: const Text("NEXT"),
                    onPressed: onStepContinue,
                  )),
                  const SizedBox(width: 15),
                  if (currentStep != 0)
                    Expanded(
                        child: ElevatedButton(
                      child: const Text("BACK"),
                      onPressed: onStepCancel,
                    ))
                ],
              ),
            );
          },
        ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 0,
          title: const Text("Account"),
          content: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "First Name",
                  hintText: 'First Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Last Name",
                  hintText: 'Last Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "address",
                  hintText: 'address',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: postCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "PostCode",
                  hintText: 'PostCode',
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 1,
          title: const Text("Address"),
          content: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: postCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Post Code",
                  hintText: 'Post Code',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Please enter a text";
                  }
                  return null;
                },
                controller: postCodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Street",
                  hintText: 'Street',
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 2,
          title: const Text("Congratulations! "),
          content: Container(),
        ),
      ];


}
