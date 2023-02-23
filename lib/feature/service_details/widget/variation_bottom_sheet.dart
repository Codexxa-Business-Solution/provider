import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class VariantBottomSheet extends StatefulWidget {

  @override
  State<VariantBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<VariantBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ResponsiveHelper.isDesktop(context))
      return  Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        insetPadding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    return pointerInterceptor();
  }
  pointerInterceptor(){
    return GetBuilder<ServiceDetailsController>(builder: (serviceDetailsController){
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL
        ),
        margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),

        decoration: BoxDecoration(

          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 25),
                ),
              ],
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              child: CustomImage(
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                      '${AppConstants.SERVICE_IMAGE_PATH}'
                      '${serviceDetailsController.serviceDetailsModel!.content!.thumbnail!}'
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(serviceDetailsController.serviceDetailsModel!.content!.name!,
                style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            Text("${serviceDetailsController.variantList.length}  ${'variation_available'.tr}",
              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
              maxLines: 2,

            ),

            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Expanded(
              child: ListView.builder(

                itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,left: 2,right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                        )],
                      color: Get.isDarkMode? Colors.grey.withOpacity(0.2):Theme.of(context).cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(serviceDetailsController.variantList[index].variantName.replaceAll('-', ' ').capitalizeFirst!,
                            style: ubuntuMedium.copyWith(
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                            ),
                            //maxLines: 2,
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                        Text(PriceConverter.convertPrice(double.tryParse(
                            serviceDetailsController.variantList[index].price.toString())),
                          style: ubuntuMedium.copyWith(
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: serviceDetailsController.variantList.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}
