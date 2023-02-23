import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class CommissionViewScreen extends StatelessWidget {
  const CommissionViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "commission".tr),

      body: GetBuilder<UserProfileController>(builder: (userProfileController){

        int commissionStatus = userProfileController.providerModel!.content!.providerInfo!.commissionStatus!;

        return Column(children: [
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,horizontal: Dimensions.PADDING_SIZE_SMALL),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: shadow
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("commission_information".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                Row(
                  children: [
                    Text("${'commission_percentage'.tr} : ".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                    Text("${commissionStatus==1?
                    userProfileController.providerModel!.content!.providerInfo!.commissionPercentage:
                    Get.find<SplashController>().configModel.content!.defaultCommission} %",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Text(commissionStatus==1?
                "custom_commission_text".tr:
                "default_commission_text".tr,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
          )

        ],
        );
      })

    );
  }
}
