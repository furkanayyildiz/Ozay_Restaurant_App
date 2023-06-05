import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});
  TextEditingController _tableNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              LineAwesomeIcons.arrow_left,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("PAYMENT"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                      " Please fill the card information and required fields",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _tableNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                        ]),
                        decoration: const InputDecoration(
                          labelText: "Table Number",
                          hintText: "Table Number",
                          border: OutlineInputBorder(),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Icon(Icons.table_chart),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: _descriptionController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                          ]),
                          decoration: const InputDecoration(
                            labelText: "Description",
                            hintText: "Description",
                            border: OutlineInputBorder(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Icon(Icons.description),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _cardNumberController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                        ]),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                        ],
                        decoration: const InputDecoration(
                          labelText: "Card Number",
                          hintText: "Card Number",
                          border: OutlineInputBorder(),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Icon(Icons.credit_card),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: _nameController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                          ]),
                          decoration: const InputDecoration(
                            labelText: "Name",
                            hintText: "Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cvvController,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                              ]),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: const InputDecoration(
                                labelText: "CVV",
                                hintText: "CVV",
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.credit_card),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              controller: _expiryDateController,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                MinLengthValidator(5,
                                    errorText: "Invalid Date"),
                              ]),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                              ],
                              decoration: const InputDecoration(
                                labelText: "MM/YY",
                                hintText: "MM/YY",
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.calendar_month),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: "Payment Successful!",
                        onConfirmBtnTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Text("Pay"),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.tertiary,
                      //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
