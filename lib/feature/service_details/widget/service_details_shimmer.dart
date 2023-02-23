import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ServiceDetailsShimmer extends StatelessWidget {
  const ServiceDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 3),
      interval: Duration(seconds: 5),
      colorOpacity: 0, //Default value
      enabled: true, //Default value
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        height: context.height,
        width: context.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                height: 100,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: Theme.of(context).shadowColor,
                ),

              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                height: 100,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: Theme.of(context).shadowColor,
                ),

              ),
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: Get.width*0.40,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: Get.width*0.40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Theme.of(context).shadowColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                ),
                child: Container(
                  height: Get.height*.33,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                  ),

                ),
              ),
              SizedBox(height:10),

              Container(
                height: 35,
                width: double.infinity,
                color: Theme.of(context).shadowColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}