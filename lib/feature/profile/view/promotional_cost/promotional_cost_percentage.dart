import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class PromotionalCostPercentageScreen extends StatelessWidget {
  const PromotionalCostPercentageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(title: "promotional_cost".tr),

        body: GetBuilder<UserProfileController>(builder: (userProfileController){


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

                  Text("promotional_cost_information".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  if(userProfileController.providerModel?.content?.promotionalCostPercentage?.discount!=null)
                  Row(
                    children: [
                      Text("${'discount_cost_percentage'.tr} : ".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      Text("${userProfileController.providerModel?.content?.promotionalCostPercentage?.discount} %",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  if(userProfileController.providerModel?.content?.promotionalCostPercentage?.campaign!=null)
                  Row(
                    children: [
                      Text("${'campaign_cost_percentage'.tr} : ".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      Text("${userProfileController.providerModel?.content?.promotionalCostPercentage?.campaign} %",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  if(userProfileController.providerModel?.content?.promotionalCostPercentage?.coupon!=null)
                  Row(
                    children: [
                      Text("${'coupon_cost_percentage'.tr} : ".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      Text("${userProfileController.providerModel?.content?.promotionalCostPercentage?.coupon} %",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                      ),
                    ],
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
