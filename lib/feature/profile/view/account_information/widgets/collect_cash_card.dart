import 'package:demandium_provider/feature/transaction/view/withdraw_input_view.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class CollectCashCard extends StatelessWidget {
  const CollectCashCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Stack(
        children: [
          Container(height: 160, width:  MediaQuery.of(context).size.width*.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(300),bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
              gradient: LinearGradient(begin:Alignment.bottomCenter,end: Alignment.topCenter,
                colors: Get.isDarkMode?[Colors.transparent,Colors.transparent]:[Colors.blue.shade50,Colors.white],
              ),
            ),
          ),
          Container(height: 160, width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.lightBlue.shade100,width:Get.isDarkMode? 0.6:1),
            ),
            child: GetBuilder<UserProfileController>(builder: (userProfileController) {
              double withDrawableAmount = double.tryParse(userProfileController.providerModel!.content!
                  .providerInfo!.owner!.account!.accountReceivable!)!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Text(
                    "collect_cash_from_admin".tr,
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),

                  Text("${PriceConverter.convertPrice(double.tryParse(userProfileController.providerModel!
                      .content!.providerInfo!.owner!.account!.accountReceivable!))}",
                    style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeOverLarge,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  // CustomButton(width: 200, height: 35,
                  //   fontSize: Dimensions.fontSizeSmall,
                  //   btnTxt: "collect_cash".tr,
                  //   onPressed:withDrawableAmount<=0.0?  null: ()=> Get.dialog(CollectCashDialog()),
                  // ),
                  CustomButton(width: 200, height: 35,
                    fontSize: Dimensions.fontSizeSmall,
                    btnTxt: "collect_cash".tr,
                    onPressed:withDrawableAmount<=0.0?  null: ()=> Get.to(TransactionMoneyBalanceInput(amount: withDrawableAmount,)),
                  )
                ],
              );
            })
          ),
        ],
      ),
    );
  }
}
