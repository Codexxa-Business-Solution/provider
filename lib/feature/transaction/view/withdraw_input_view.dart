import 'dart:convert';
import 'dart:math';
import 'package:demandium_provider/components/custom_loader.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/transaction/model/withdraw_model.dart';
import 'package:demandium_provider/feature/transaction/widget/field_item_view.dart';
import 'package:demandium_provider/feature/transaction/widget/input_box_view.dart';
import 'package:demandium_provider/feature/transaction/widget/slider_button.dart';
import 'package:get/get.dart';

class TransactionMoneyBalanceInput extends StatefulWidget {
  final double? amount;

   TransactionMoneyBalanceInput({Key? key, this.amount = 0.0}) : super(key: key);
  @override
  State<TransactionMoneyBalanceInput> createState() => _TransactionMoneyBalanceInputState();
}

class _TransactionMoneyBalanceInputState extends State<TransactionMoneyBalanceInput> {
  final TextEditingController _inputAmountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedMethodId='';
  String _selectedMethodName ='';
  List<MethodField>? _fieldList;
  List<MethodField>? _gridFieldList;
  Map<String, TextEditingController> _textControllers =  Map();
  Map<String, TextEditingController> _gridTextController =  Map();
  final FocusNode _inputAmountFocusNode = FocusNode();

  void setFocus() {
    _inputAmountFocusNode.requestFocus();
    Get.back();
  }

  Future<void> selectPaymentMethodField (String id, String name, TransactionController transactionMoneyController) async{

    _selectedMethodId = id;
    _selectedMethodName = name;
    _gridFieldList = [];
    _fieldList = [];

    transactionMoneyController.withdrawModel?.withdrawalMethods?.firstWhere((_method) =>
    _method.id.toString() == id).methodFields!.forEach((_method) {
      _gridFieldList!.addIf(_method.inputName!.toLowerCase().contains('cvv') || _method.inputType!.toLowerCase() == 'date', _method);
    });

    transactionMoneyController.withdrawModel?.withdrawalMethods?.firstWhere((_method) =>
    _method.id.toString() == id).methodFields!.forEach((_method) {
      _fieldList!.addIf(!_method.inputName!.toLowerCase().contains('cvv') && _method.inputType != 'date', _method);
    });
    _textControllers = _textControllers =  Map();
    _gridTextController = _gridTextController =  Map();

    _fieldList!.forEach((_method) => _textControllers[_method.inputName!] = TextEditingController());
    _gridFieldList!.forEach((_method) => _gridTextController[_method.inputName!] = TextEditingController());

    transactionMoneyController.update();
  }

  void loadData() async {

    await Get.find<TransactionController>().getWithdrawMethods(isReload: true);
    _selectedMethodId = await Get.find<TransactionController>().defaultPaymentMethodId!;
    _selectedMethodName = await Get.find<TransactionController>().defaultPaymentMethodName!;
    selectPaymentMethodField(_selectedMethodId,_selectedMethodName, Get.find<TransactionController>());
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _inputAmountController.dispose();
    _noteController.dispose();
    _inputAmountFocusNode.dispose();
    _textControllers.forEach((key, _textController) {
      _textController.dispose();
    });
    _gridTextController.forEach((key, _textController) {
      _textController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(title: 'withdraw_request'.tr),
          body: GetBuilder<TransactionController>(
            builder: (transactionMoneyController) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        child: Column(children: [
                          Row(
                            children: [
                              Text('select_withdraw_method'.tr,
                                style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight),
                              ),
                            ],
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                          Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: DropdownButton(

                                borderRadius: BorderRadius.circular(5),

                                menuMaxHeight: Get.height * 0.5,

                                dropdownColor: Theme.of(context).cardColor,
                                hint: Text(_selectedMethodName!=''?_selectedMethodName:
                                  'select_a_method'.tr,
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                ),
                                items: transactionMoneyController.withdrawModel?.withdrawalMethods!.map((WithdrawalMethod withdraw) {
                                  return DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    value: withdraw,
                                    child: withdraw.isActive==1?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          withdraw.methodName ?? 'no method'.tr,
                                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                        ),
                                        if(withdraw.isDefault==1)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: Theme.of(context).primaryColorLight)
                                          ),
                                          child: Text("default".tr,
                                            style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight,
                                              fontSize: Dimensions.fontSizeSmall),
                                          ),
                                        )
                                      ],
                                    ):SizedBox(),
                                  );
                                }).toList(),
                                isExpanded: true,
                                underline: SizedBox(),
                                onChanged: (WithdrawalMethod? withdraw) {
                                  _selectedMethodName = withdraw!.methodName.toString();
                                  _selectedMethodId = withdraw.id.toString();
                                  selectPaymentMethodField(withdraw.id.toString(),withdraw.methodName.toString(), transactionMoneyController);
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          if(_fieldList != null && _fieldList!.isNotEmpty) ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _fieldList!.length,
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 10,
                            ),

                            itemBuilder: (context, index) => FieldItemView(
                              methodField:_fieldList![index],
                              textControllers: _textControllers,
                            ),
                          ),

                          if(_gridFieldList != null && _gridFieldList!.isNotEmpty)

                            GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 10,
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: _gridFieldList!.length,

                              itemBuilder: (context, index) => FieldItemView(
                                methodField: _gridFieldList![index],
                                textControllers: _gridTextController,
                              ),
                            ),

                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('note'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight)),
                               SizedBox(height: 7),
                               CustomTextFormField(
                                 inputType: TextInputType.text,
                                 controller: _noteController,
                                 hintText: "write_note_your_here".tr,
                                 capitalization: TextCapitalization.words,
                                 maxLines: 2,
                               ),
                             ],
                           ),
                         )


                        ],),
                      ),
                    InputBoxView(
                      inputAmountController: _inputAmountController,
                      focusNode: _inputAmountFocusNode,
                      amount: widget.amount,
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE*4,),

                  ],
                ),
              );
            }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GetBuilder<TransactionController>(
            builder: (transactionMoneyController) {

              return   Container(
                height: 70,
                color: Theme.of(context).cardColor,
                child: Center(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      border: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(.5)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Transform.rotate(
                      angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: SliderButton(
                          width:   Get.width - 20,
                          dismissible: false,
                          action: () async {
                            double _amount;
                            double minimumWithdrawAmount= Get.find<SplashController>().configModel.content?.minimumWithdrawAmount??0;
                            double maximumWithdrawAmount= Get.find<SplashController>().configModel.content?.maximumWithdrawAmount??0;
                            if(_inputAmountController.text.isEmpty){
                              showCustomSnackBar('please_input_amount'.tr,isError: true);
                            }else{
                              String balance =  _inputAmountController.text;
                              balance = balance.replaceAll('${PriceConverter.getCurrency(context)}', '');
                              if(balance.contains(',')){
                                balance = balance.replaceAll(',', '');
                              }
                              if(balance.contains(' ')){
                                balance = balance.replaceAll(' ', '');
                              }
                              _amount = double.parse(balance);

                              if(_amount < minimumWithdrawAmount) {
                                showCustomSnackBar('${'withdraw_amount_grater_than'.tr} ${minimumWithdrawAmount-1}');
                              }else if(_amount> maximumWithdrawAmount){
                                showCustomSnackBar('${'withdraw_amount_grater_than'.tr}');
                              }
                              else if(_amount<maximumWithdrawAmount&&_amount>widget.amount!){
                                showCustomSnackBar('insufficient_balance'.tr);
                              }
                              else {
                                String? _message;
                                WithdrawalMethod _withdrawMethod = transactionMoneyController.withdrawModel!.withdrawalMethods!.
                                firstWhere((_method) => _selectedMethodId == _method.id.toString());

                                String _validationKey = '';
                                List<Map<String,String>> methodFieldValue = [];
                                Map<String,String> value =Map();

                                _withdrawMethod.methodFields!.forEach((_method) {
                                  if(_method.inputType == 'email' ||_method.inputType == 'date') {
                                    _validationKey = _method.inputType!;
                                  }
                                });

                                _textControllers.forEach((key, textController) {
                                  value.addAll({key:textController.text});

                                  if((_validationKey == key) && !GetUtils.isEmail(textController.text)) {
                                    _message = 'please_provide_valid_email'.tr;
                                  }else if((_validationKey == key) && textController.text.contains('-')) {
                                    _message = 'please_provide_valid_date'.tr;
                                  }
                                  if(textController.text.isEmpty && _message == null) {
                                    _message = 'please fill ${key.replaceAll('_', ' ')} field';
                                  }
                                });

                                _gridTextController.forEach((key, textController) {
                                  value.addAll({key:textController.text});

                                  if(_validationKey == 'date' && textController.text.contains('-')) {
                                    _message = 'please_provide_valid_date'.tr;
                                  }
                                  if(textController.text.isEmpty && _message == null) {
                                    _message = 'Please fill ${key.replaceAll('_', ' ')} field';
                                  }
                                });
                                if(_message != null) {
                                  showCustomSnackBar(_message);
                                  _message = null;
                                }
                                else{
                                  Get.dialog(CustomLoader(), barrierDismissible: false);
                                  Map<String, String> _withdrawalMethodField = Map();

                                  _withdrawMethod.methodFields!.forEach((_method) {
                                    _withdrawalMethodField.addAll({'${_method.inputName}' : '${_method.placeholder}'});
                                  });
                                  methodFieldValue.add(value);

                                  Map<String, String> _withdrawRequestBody = Map();
                                  _withdrawRequestBody = {
                                    'amount' : '${_amount}',
                                    'withdrawal_method_id' : '${_withdrawMethod.id}',
                                    'withdrawal_method_fields' : '${base64Url.encode(utf8.encode(jsonEncode(methodFieldValue)))}',
                                    'note': _noteController.text
                                  };
                                  await Get.find<TransactionController>().withDrawRequest(placeBody: _withdrawRequestBody);
                                }
                              }
                            }
                          },

                          label: Transform.rotate(
                            angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi,
                            child: Text('send_withdraw_request'.tr,
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).primaryColor),),
                          ),
                          dismissThresholds: 0.5,
                          icon: Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(Images.arrow_button),
                          )),
                          radius: 10,
                          boxShadow: const BoxShadow(blurRadius: 0.0),
                          buttonColor: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).cardColor,
                          baseColor: Theme.of(context).primaryColorLight.withOpacity(Get.isDarkMode?0.7:1),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          )
        ),
      ),
    );
  }
}





