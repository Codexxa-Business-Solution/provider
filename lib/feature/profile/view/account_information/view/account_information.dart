import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);
  @override
  State<AccountInformation> createState() => _AccountInformationState();
}
class _AccountInformationState extends State<AccountInformation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<UserProfileController>().getProviderInfo(reload: true);

  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).cardColor,
      onRefresh: ()async => Get.find<UserProfileController>().getProviderInfo(reload: true),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(title: "account_information".tr),
        body: SingleChildScrollView(
          child: GetBuilder<UserProfileController>(
              builder: (userProfileController){
            return Column(
              children: [

                CollectCashCard(),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    children: [
                      TransactionCard(
                        amount: "${PriceConverter.convertPrice(double.tryParse(userProfileController
                            .providerModel!.content!.providerInfo!.owner!.account!.balancePending!))}",
                        amountTextColor: Colors.blue, title: "pending_withdrawn".tr, borderColor: Colors.blue.shade100,
                        backgroundColor: Get.isDarkMode?Theme.of(context).cardColor:Colors.blue.shade50,
                      ),
                      SizedBox(width: 8),
                      TransactionCard(
                        amount: "${PriceConverter.convertPrice(double.tryParse(userProfileController
                            .providerModel!.content!.providerInfo!.owner!.account!.totalWithdrawn!))}",
                        amountTextColor: Colors.green, title: "already_withdrawn".tr, borderColor: Colors.green.shade100,
                        backgroundColor: Get.isDarkMode?Theme.of(context).cardColor:Colors.green.shade50,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    children: [
                      TransactionCard(
                        amount: "${PriceConverter.convertPrice((double.tryParse(userProfileController
                            .providerModel!.content!.providerInfo!.owner!.account!.totalWithdrawn!))!
                            +(double.tryParse(userProfileController.providerModel!.content!.providerInfo!
                                .owner!.account!.receivedBalance!)!
                            )
                        )}",
                        amountTextColor: Colors.orangeAccent,
                        title: "total_earning".tr,
                        borderColor: Colors.orangeAccent.shade100,
                        backgroundColor: Get.isDarkMode?Theme.of(context).cardColor:Colors.orange.shade50,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                TransactionChart(),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                CustomButton(
                  height: 35,
                  width: 200,
                  fontSize: Dimensions.fontSizeSmall,
                  btnTxt: "see_transaction_history".tr,
                  onPressed: ()=> Get.toNamed(RouteHelper.transactions),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
