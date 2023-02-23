import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';
import 'package:get/get.dart';

class ReviewHeading extends StatelessWidget {
  final Rating rating;
  const ReviewHeading({Key? key,required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: shadow
      ),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft,
            child: Text("reviews".tr,
              style: ubuntuMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                  fontSize: Dimensions.fontSizeDefault
              ),
            ),
          ),
          Text(rating.averageRating.toString(),
              style: ubuntuBold.copyWith(
                  color:Theme.of(context).primaryColorLight, fontSize: 30
              )
          ),
          SizedBox(height: 8,),
          RatingBar(rating: double.parse('${rating.averageRating}',),size: 22,),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${rating.ratingCount.toString()} ${'ratings'.tr}",
                style: ubuntuRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                  fontSize: Dimensions.fontSizeSmall
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
              Text(
                "${rating.ratingCount.toString()} ${'reviews'.tr}",
                  style: ubuntuRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                      fontSize: Dimensions.fontSizeSmall
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
