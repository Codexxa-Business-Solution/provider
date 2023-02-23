import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/transaction/model/transactions_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "transactions".tr),
      body: GetBuilder<TransactionController>(
        builder: (transactionController){
        List<TransactionData>? _transactionsList = transactionController.transactionsList;
        return transactionController.isLoading && _transactionsList!.length ==0?
        CustomShimmer():
        transactionController.transactionsList!.length==0?
        NoDataScreen(text: "no_transaction_found",type: NoDataType.TRANSACTION,):
        RefreshIndicator(
          color: Theme.of(context).primaryColorLight,
          backgroundColor: Theme.of(context).cardColor,
          onRefresh: () async {
            Get.find<TransactionController>().getTransactionList(1,false);
          },
          child: Column(
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
              Expanded(child: Column(

                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                        mainAxisExtent: Get.find<LocalizationController>().isLtr?140: 160
                      ),
                      controller: transactionController.scrollController,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        child: Container(width: Get.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                            boxShadow: shadow,
                          ),
                          padding:  EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_SMALL,
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35,
                                    child: Text((index+1).toString()+".",
                                      style: ubuntuMedium.copyWith(color: Theme.of(context).errorColor),
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${'withdrawn_amount'.tr}",
                                          style: ubuntuMedium.copyWith(
                                            color: Theme.of(context).primaryColorLight,
                                          ),
                                        ),
                                     ],
                                   ),
                                 ),
                                  Center(
                                    child: Text(" ${PriceConverter.convertPrice(
                                        double.tryParse(_transactionsList![index].amount!))}",
                                      style: ubuntuBold.copyWith(color: Theme.of(context).primaryColorLight),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                              Row(children: [
                                 SizedBox(width: 35),
                                 Expanded(child:
                                   Row(
                                     children: [
                                       Text("${'payment_status'.tr} : ",
                                         style: ubuntuRegular.copyWith(
                                           fontSize: 12,
                                           color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                                         )
                                       ),
                                       Text("${_transactionsList[index].isPaid==1?"paid".tr:"unpaid".tr}",
                                         style: ubuntuMedium.copyWith(fontSize: Dimensions.PADDING_SIZE_SMALL,
                                           color: _transactionsList[index].isPaid==1?
                                           Colors.green:Theme.of(context).errorColor
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),

                                Container(width: 70, height: 22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:Get.isDarkMode?Colors.grey.withOpacity(0.2):ColorResources
                                        .buttonBackgroundColorMap[_transactionsList[index].requestStatus]
                                  ),
                                  child: Center(
                                    child: Text("${_transactionsList[index].requestStatus}".tr,
                                      style: ubuntuRegular.copyWith(fontSize: 11,
                                        color: ColorResources.buttonTextColorMap[_transactionsList[index].requestStatus]
                                      )
                                    ),
                                  ),
                                )
                              ]),

                              SizedBox(height: 3,),

                              Row(children: [
                                SizedBox(width: 35),
                                Expanded(child: Row(children: [
                                  Text("${'date'.tr}: ",
                                    style: ubuntuRegular.copyWith(fontSize: 12,
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(" ${DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(
                                      _transactionsList[index].createdAt??""))}",
                                    style: ubuntuRegular.copyWith(fontSize: 12,
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                                    ),
                                    textDirection: TextDirection.ltr
                                  )
                                ]))
                              ]),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                              if(_transactionsList[index].requestUpdater!.userType!='provider-admin')
                              Column(children: [
                                Row(
                                  children: [
                                    SizedBox(width: 35,),
                                    Text('${_transactionsList[index].requestStatus.toString().tr} ${'by'.tr} : ',
                                      style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                                      ),
                                    ),
                                    Text('${_transactionsList[index].requestUpdater!.firstName??""} '
                                        '${_transactionsList[index].requestUpdater!.lastName??""}',
                                      style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                              ],
                              ),

                              Row(
                                children: [
                                  Text('${'note'.tr}  : ',
                                    style: ubuntuMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    _transactionsList[index].note??"",
                                    style: ubuntuMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      },
                      itemCount: _transactionsList!.length,
                    ),
                  ),
                  transactionController.paginationLoading!?
                  CircularProgressIndicator(color: Theme.of(context).hoverColor
                  ):SizedBox.shrink()
                ],
              ),)
            ],
          ),
        );
      }),

    );
  }
}


