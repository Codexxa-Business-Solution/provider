import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';
class BusinessReportStatisticsCard extends StatelessWidget {
  final String icon;
  final String titleAmount;
  final String title;
  const BusinessReportStatisticsCard({
    Key? key,
    required this.icon,
    required this.titleAmount,
    required this.title
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5) :Theme.of(context).cardColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(icon,width: 35,),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                PriceConverter.convertPrice(double.tryParse(titleAmount),isShowLongPrice: true),
                style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Text(
                title.tr,
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT*3,)
        ],
      ),
    );
  }
}
