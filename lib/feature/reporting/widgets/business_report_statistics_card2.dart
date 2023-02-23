import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';
class BusinessReportStatisticsCard2 extends StatelessWidget {
  final bool withCurrencySymbol;
  final String icon;
  final String titleAmount;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String? subtitle3;
  final String? subtitle4;
  final String subtitleAmount1;
  final String subtitleAmount2;
  final String? subtitleAmount3;
  final String? subtitleAmount4;

  const BusinessReportStatisticsCard2({
    Key? key,
    required this.icon,
    required this.titleAmount,
    required this.title, 
    required this.subtitle1,
    required this.subtitle2,
    this.subtitle3,
    required this.subtitleAmount1,
    required this.subtitleAmount2,
    this.subtitleAmount3, 
    required this.withCurrencySymbol,
    this.subtitle4,
    this.subtitleAmount4
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon,width: 35,),
              SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    withCurrencySymbol
                        ? PriceConverter.convertPrice(double.tryParse(titleAmount))
                        : titleAmount,
                    style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
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
              //SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
            ],
          ),
          SizedBox(height: Dimensions.fontSizeSmall,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _subTitleView(
                amount: subtitleAmount1,
                subTitle: subtitle1,
                titleColor: Theme.of(context).errorColor,
                withCurrencySymbol: withCurrencySymbol,
              ),
              _subTitleView(
                amount: subtitleAmount2,
                subTitle: subtitle2,
                titleColor: Theme.of(context).primaryColorLight,
                withCurrencySymbol: withCurrencySymbol,
              ),
              if(subtitle3!=null)
                _subTitleView(
                  amount: subtitleAmount3!=null?subtitleAmount3!:'0',
                  subTitle: subtitle3!,
                  titleColor: Colors.blue,
                  withCurrencySymbol: withCurrencySymbol,
                ),

              if(subtitle4!=null)
                _subTitleView(
                  amount: subtitleAmount4!=null?subtitleAmount4!:'0',
                  subTitle: subtitle4!,
                  titleColor: Colors.green,
                  withCurrencySymbol: withCurrencySymbol,
                )
            ],
          )
        ],
      ),
    );
  }
}

class _subTitleView extends StatelessWidget {
  final String amount;
  final String subTitle;
  final Color titleColor;
  final bool withCurrencySymbol;
  const _subTitleView({
    Key? key,
    required this.amount,
    required this.subTitle, 
    required this.titleColor,
    required this.withCurrencySymbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.fontSizeSmall),
      child: Column(
        children: [
          Text(
            withCurrencySymbol
                ? PriceConverter.convertPrice(double.tryParse(amount),isShowLongPrice: true)
                :amount,
            style: ubuntuBold.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: titleColor.withOpacity(0.8)
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
          Text(
            subTitle.tr,
            style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
