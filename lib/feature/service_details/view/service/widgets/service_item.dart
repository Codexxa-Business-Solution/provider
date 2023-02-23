import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class ServiceItem extends StatelessWidget {
  final Service service;
  const ServiceItem({Key? key,required this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _discount = PriceConverter.discountCalculation(service);
    print(_discount.discountAmountType);
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: InkWell(
        onTap: () => Get.to(ServiceDetailsScreen(serviceId: service.id!, discount: _discount)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            boxShadow: shadow
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
                      child: CustomImage(
                        height: 105,
                        width: 160,
                        fit: BoxFit.cover,
                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}'
                            '${AppConstants.SERVICE_IMAGE_PATH}'
                            '${service.thumbnail!}',
                      ),
                    ),
                    _discount.discountAmount! > 0.0?
                    Positioned(top: 0, right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: 3),
                        child: Center(
                          child: Text(PriceConverter.percentageCalculation(
                            '', _discount.discountAmount.toString(),
                            _discount.discountAmountType.toString(),
                          ),
                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: light.cardColor),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ):SizedBox.shrink()
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
                          child: Text(
                            service.name.toString(),
                            style: ubuntuMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}