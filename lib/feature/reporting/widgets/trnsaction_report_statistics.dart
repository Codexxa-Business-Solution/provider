import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/model/transaction_report_model.dart';
import 'package:get/get.dart';

class TransactionReportStatistics extends StatelessWidget {
  final TransactionReportAccountInfo accountInfo;
  const TransactionReportStatistics({Key? key, required this.accountInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> _itemsTitle =[];
    List<String> _itemsAmount =[];
    List<String> _infoText =[];
    List<String> _bg =[];

    double providerBalance = accountInfo.totalWithdrawn! + accountInfo.receivedBalance!;

    _itemsTitle = ['provider_balance'.tr, 'pending_balance'.tr, 'already_withdrawn'.tr, 'account_payable'.tr,'account_receivable'.tr];
    _bg = ['0xFF286FC6', '0xFF5ABD88', '0xFFD0517F', '0xFF2BA361', '0xFFFF6D6D'];
    _infoText =['provider_balance_info','pending_balance_info','already_withdrawn_info','account_payable_info','account_receivable_info'];
    _itemsAmount =[
      providerBalance.toString(),accountInfo.balancePending.toString(),accountInfo.totalWithdrawn.toString(),
      accountInfo.accountPayable.toString(),accountInfo.accountReceivable.toString()
    ];

    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5) :Theme.of(context).cardColor,
          //boxShadow: shadow
      ),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width*0.5,
              margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                border: Border.all(
                  color:Color(int.parse(_bg[index]))
                )
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PriceConverter.convertPrice(double.tryParse(_itemsAmount[index])),
                          style: ubuntuBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Color(int.parse(_bg[index]))
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                        Text(
                          _itemsTitle[index],
                          style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.35,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                           bottomLeft: Radius.circular(20),
                           topRight: Radius.circular(270),
                        ),
                          color:Color(int.parse(_bg[index])).withOpacity(0.1)
                      ),
                    ),
                  ),

                  Positioned(
                    top: -10,
                    right: -10,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.info_outline_rounded,color:Color(int.parse(_bg[index])),),
                      //onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return {_infoText[index]}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice.tr),
                          );
                        }).toList();
                      },
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
