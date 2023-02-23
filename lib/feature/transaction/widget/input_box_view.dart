import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';
class InputBoxView extends StatefulWidget {
  final TextEditingController? inputAmountController;
  final FocusNode? focusNode;
  final double? amount;

  const InputBoxView({
    Key? key,
    @required this.inputAmountController, this.focusNode,this.amount
  }) : super(key: key);

  @override
  State<InputBoxView> createState() => _InputBoxViewState();
}

class _InputBoxViewState extends State<InputBoxView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  bool isTextFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    double maxWithdrawAmount = 878787888888;
    double minimumWithdrawAmount = Get.find<SplashController>().configModel.content?.minimumWithdrawAmount??100;
    List<double> suggestInputAmountList = [];
    if(widget.amount!=null){
      suggestInputAmountList.add(minimumWithdrawAmount);
      if(widget.amount!>500&& 500<=maxWithdrawAmount){
        suggestInputAmountList.add(500);
      }
      if(widget.amount!>1000 && 1000<=maxWithdrawAmount){
        suggestInputAmountList.add(1000);
      }
      if(widget.amount!>5000&& 5000<=maxWithdrawAmount){
        suggestInputAmountList.add(5000);
      }
      if(widget.amount!>10000&& 10000<=maxWithdrawAmount){
        suggestInputAmountList.add(10000);
      }
      if(widget.amount!>20000&& 20000<=maxWithdrawAmount){
        suggestInputAmountList.add(20000);
      }
      if(widget.amount!>50000&& 50000<=maxWithdrawAmount){
        suggestInputAmountList.add(50000);
      }
      if(widget.amount!>100000&& 100000<=maxWithdrawAmount){
        suggestInputAmountList.add(100000);
      }
      if(widget.amount!>500000&& 500000<=maxWithdrawAmount){
        suggestInputAmountList.add(500000);
      }
      if(widget.amount! < maxWithdrawAmount){
        suggestInputAmountList.add(widget.amount!);
      }
      suggestInputAmountList.sort();
    }
    bool _isRightSide = Get.find<SplashController>().configModel.content?.currencySymbolPosition == 'right';

    return GetBuilder<TransactionController>(
        builder: (transactionMoneyController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<TransactionController>(
                builder: (controller) => Column(children: [
                  Stack(children: [
                    Container(color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5):Theme.of(context).cardColor,
                      child: Column(
                        children: [
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Row(mainAxisAlignment : MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: SizedBox()),
                            if(!_isRightSide)
                            Text("${PriceConverter.getCurrency(context)}",
                              style: ubuntuBold.copyWith(
                                fontSize: 20,
                                color: isTextFieldEmpty
                                    ?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)
                                    :Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: IntrinsicWidth(
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20),
                                  ],
                                keyboardType: TextInputType.number,
                                controller: widget.inputAmountController,
                                focusNode: widget.focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border : InputBorder.none,
                                    isCollapsed: true,
                                    hintText: "0.0",
                                    hintStyle: ubuntuBold.copyWith(
                                        fontSize: 20,
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)
                                    )
                                  ),
                                  style: ubuntuBold.copyWith(fontSize: 20,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
                                  onChanged: (String value){
                                    setState(() {
                                      if(value.length>0){
                                        isTextFieldEmpty = false;
                                      }else{
                                        isTextFieldEmpty = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            if(_isRightSide)
                            Text("${PriceConverter.getCurrency(context)}",
                              style: ubuntuBold.copyWith(
                                fontSize: 20,
                                color: isTextFieldEmpty ?
                                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5) :
                                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),

                            Expanded(child: SizedBox()),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("available_balance".tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),),
                            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            Text(PriceConverter.convertPrice(widget.amount),
                              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),)
                          ],
                        ),
                          if(Get.find<SplashController>().configModel.content?.minimumWithdrawAmount!=null)
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                          if(Get.find<SplashController>().configModel.content?.minimumWithdrawAmount!=null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("minimum_withdraw_amount".tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),),
                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                              Text(PriceConverter.convertPrice(Get.find<SplashController>().configModel.content?.minimumWithdrawAmount),
                                style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),)
                            ],
                          ),

                          if(Get.find<SplashController>().configModel.content?.maximumWithdrawAmount!=null)
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                          if(Get.find<SplashController>().configModel.content?.maximumWithdrawAmount!=null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("maximum_withdraw_amount".tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),),
                              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                              Text(PriceConverter.convertPrice(Get.find<SplashController>().configModel.content?.maximumWithdrawAmount),
                                style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),)
                            ],
                          ),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Column(
                          children: [
                            Divider(color: Theme.of(context).hintColor.withOpacity(0.2)),
                            GetBuilder<TransactionController>(
                              builder: (transactionController) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(height: 30,
                                    child: ListView.builder(itemCount: suggestInputAmountList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (cnt, index){
                                      return GestureDetector(
                                        onTap: (){
                                          transactionController.setIndex(index, suggestInputAmountList[index].toString());
                                          widget.inputAmountController!.text = suggestInputAmountList[index].toString();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Get.find<TransactionController>().selectAmount != null ?
                                            suggestInputAmountList[index].toString() == Get.find<TransactionController>().selectAmount
                                                ? Theme.of(context).primaryColorLight
                                                : Theme.of(context).cardColor :  Theme.of(context).cardColor,

                                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                                            border: Border.all(width: 0.5,color: Theme.of(context).primaryColorLight),
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                            ),
                                            child: Text(_isRightSide?suggestInputAmountList[index].toString()+PriceConverter.getCurrency(context)
                                                :PriceConverter.getCurrency(context)+suggestInputAmountList[index].toString(),
                                              style: ubuntuRegular.copyWith(
                                                  fontSize: Dimensions.fontSizeDefault,
                                                  color: suggestInputAmountList[index].toString() == transactionController.selectAmount
                                                      ? Theme.of(context).cardColor
                                                      : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                                              ),
                                            ),
                                          ),
                                        ),

                                      );
                                    }),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                        ],
                      ),
                    ),
                  ],
                  ),
                ],
                ),
              ),
            ],
          );
        }
    );
  }
}
