import 'package:flutter/material.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  Color background = Colors.white; // const Color.fromRGBO(241, 249, 251, 1);
  Color numberColor = Colors.white; // const Color.fromRGBO(155, 216, 219, 1);
  Color calc = Colors.pink.shade50; // const Color.fromRGBO(60, 148, 158, 1);
  Color operator = Colors.pink.shade50;
  Color equal = Colors.pinkAccent;
  Color ccolorfont = Colors.pinkAccent;
  Color nucolorfont = Colors.black54;

  String mainDisplay = " ";
  String subDisplay = " ";

  String display = " ";
  double sum = 0;
  String input = " ";
  List output = [];
  String numberIcon = " ";
  int sumint = 0;
  String previousDisplay = " ";

  Widget text(String data, Color fontColor) {
    if (data == "<") {
      return Icon(
        Icons.backspace_outlined,
        color: fontColor,
      );
    }
    if (data == "*") {
      return Icon(
        Icons.close,
        color: fontColor,
      );
    }

    return Text(
      data,
      style: TextStyle(fontSize: 25, color: fontColor),
    );
  }

  errorbanner() =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: const Text(
            "Invalid Expression",
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
          actions: [
            TextButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).clearMaterialBanners(),
                child: const Text(
                  "Dissmis",
                  style: TextStyle(fontSize: 15),
                ))
          ]));

  Widget myButton(
      String number, Color buttoncolour, Color fontc, double hei, double wid) {
    return InkWell(
      onTap: () => setState(() {
        if (number == "C") {
          display = " ";
          sum = 0;
          input = " ";
          output = [];
          previousDisplay = " ";
        }

        if (number == '<') {
          previousDisplay = " ";
          display = display.substring(0, display.length - 1);
          if (input.endsWith(" ")) {
            input = input.substring(0, input.length - 3);
          } else {
            {
              input = input.substring(0, input.length - 1);
            }
          }
        }

        // to prevent consecutive operators
        bool endsWithOperator = display.endsWith('%') ||
            display.endsWith('/') ||
            display.endsWith('*') ||
            display.endsWith('-') ||
            display.endsWith('+');
        // entered number is again a operator except clear
        bool enterdNumberIsAgainAOperator =
            (int.tryParse(number) == null) && number != "C" && number != "<";

        bool firstNumberIsOperator = number == "%" ||
            number == "/" ||
            number == "*" ||
            number == "-" ||
            number == "+";

        if (!(firstNumberIsOperator && display == " ")) {
          if (!(endsWithOperator && enterdNumberIsAgainAOperator)) {
            if (number != "=" && number != "<" && number != "C") {
              if (number == "*") {
                display = display + "x";
              } else {
                display = display + number;
              }
            }

            if (number != "C" && number != "<") {
              // to solve the qiven expression
              if (number == "=") {
                output = input.split(" ");
                output.removeAt(0);

                if (!input.endsWith(" ")) {
                  while (output.contains('%')) {
                    sum = double.parse(output[(output.indexOf('%') - 1)]) %
                        double.parse(output[(output.indexOf('%') + 1)]);
                    output[(output.indexOf('%') - 1)] = sum.toString();
                    output.removeAt((output.indexOf('%') + 1));
                    output.removeAt((output.indexOf('%')));
                  }

                  while (output.contains('/')) {
                    sum = double.parse(output[(output.indexOf('/') - 1)]) /
                        double.parse(output[(output.indexOf('/') + 1)]);
                    output[(output.indexOf('/') - 1)] = sum.toString();
                    output.removeAt((output.indexOf('/') + 1));
                    output.removeAt((output.indexOf('/')));
                  }

                  while (output.contains('*')) {
                    sum = double.parse(output[(output.indexOf('*') - 1)]) *
                        double.parse(output[(output.indexOf('*') + 1)]);
                    output[(output.indexOf('*') - 1)] = sum.toString();
                    output.removeAt((output.indexOf('*') + 1));
                    output.removeAt((output.indexOf('*')));
                  }

                  while (output.contains('-')) {
                    sum = double.parse(output[(output.indexOf('-') - 1)]) -
                        double.parse(output[(output.indexOf('-') + 1)]);
                    output[(output.indexOf('-') - 1)] = sum.toString();
                    output.removeAt((output.indexOf('-') + 1));
                    output.removeAt((output.indexOf('-')));
                  }

                  while (output.contains('+')) {
                    sum = double.parse(output[(output.indexOf('+') - 1)]) +
                        double.parse(output[(output.indexOf('+') + 1)]);
                    output[(output.indexOf('+') - 1)] = sum.toString();
                    output.removeAt((output.indexOf('+') + 1));
                    output.removeAt((output.indexOf('+')));
                  }

                  if (sum.toInt() == sum) {
                    input = " " + sum.toInt().toString();
                  } else {
                    if (sum.toString().length >= 22) {
                      sum = double.parse(sum.toString().substring(0, 20));
                    } else {
                      input = " " + sum.toString();
                    }
                  }

                  previousDisplay = display;
                  display = " " + sum.toString();

                  if (sum.toInt() == sum) {
                    display = sum.toInt().toString();
                  } else {
                    if (display.length >= 22) {
                      display = display.substring(0, 20);
                    }
                  }
                } else {
                  errorbanner();
                }
              } else {
                // to and the number to the expression
                if (int.tryParse(number) != null || number == ".") {
                  input = input + number;
                } else {
                  if (number != "<" && number != ".") {
                    input = input + " " + number + " ";
                  }
                }
              }
            }
          } else {
            errorbanner();
          }
        } else {
          errorbanner();
        }

        // if (output.isEmpty) {
        //   mainDisplay = display;

        //   subDisplay = " ";
        // } else {
        //   mainDisplay = sum.toString();
        //   if (sum.toInt() == sum) {
        //     mainDisplay = sum.toInt().toString();
        //   } else {
        //     if (mainDisplay.length >= 22) {
        //       mainDisplay = mainDisplay.substring(0, 20);
        //     }
        //   }
        mainDisplay = display;
        subDisplay = previousDisplay;
        // }
      }),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: buttoncolour,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(250, 251, 255, 1),
                    blurRadius: 10,
                    offset: Offset(-5, 10)),
                BoxShadow(
                    color: Color.fromRGBO(22, 27, 29, 0.10),
                    blurRadius: 10,
                    offset: Offset(5, 10)),
              ]),
          height: hei,
          width: wid,
          child: Center(child: text(number, fontc))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
            flex: 6,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                children: [
                  Text(
                    mainDisplay,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 50),
                  ),
                  Text(
                    subDisplay,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton("C", calc, ccolorfont, 65, 65),
              myButton("<", calc, ccolorfont, 65, 65),
              myButton("%", calc, ccolorfont, 65, 65),
              myButton("/", operator, ccolorfont, 65, 65),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton("7", numberColor, nucolorfont, 65, 65),
              myButton("8", numberColor, nucolorfont, 65, 65),
              myButton("9", numberColor, nucolorfont, 65, 65),
              myButton("*", operator, ccolorfont, 65, 65),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton("4", numberColor, nucolorfont, 65, 65),
              myButton("5", numberColor, nucolorfont, 65, 65),
              myButton("6", numberColor, nucolorfont, 65, 65),
              myButton("-", operator, ccolorfont, 65, 65),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              myButton("1", numberColor, nucolorfont, 65, 65),
              myButton("2", numberColor, nucolorfont, 65, 65),
              myButton("3", numberColor, nucolorfont, 65, 65),
              myButton("+", operator, ccolorfont, 65, 65),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // myButton("", numberColorColor, nucolorfont),

              myButton("0", numberColor, nucolorfont, 65, 65),

              myButton(".", numberColor, nucolorfont, 65, 65),

              myButton("=", equal, Colors.black, 60, 167),
            ],
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
