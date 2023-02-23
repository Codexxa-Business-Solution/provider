import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';


class ServiceReviewItem extends StatelessWidget {

  final ReviewData reviewData;
  const ServiceReviewItem({Key? key, required this.reviewData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int day = DateTime.now().difference(
        DateConverter.dateTimeString(DateConverter.isoStringToLocalDate( reviewData.createdAt!).toString())
    ).inDays;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),
            if(reviewData.customer != null)
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
              child: CustomImage(
                height: 40,
                width: 40,
                image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}"
                    "${AppConstants.CUSTOMER_PROFILE_IMAGE_PATH}"
                    "${reviewData.customer!.profileImage}" ,
              ),
            ),
            SizedBox(width:Dimensions.PADDING_SIZE_DEFAULT),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(reviewData.customer != null)
                    Text(reviewData.customer!.firstName! + " " + reviewData.customer!.lastName!,
                      style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                      ),
                    ),
                  if(reviewData.customer == null)
                    Text("customer_not_available".tr,
                      style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                      ),
                    ),
                  Container(
                    height: 20,
                    child: Row(
                      children: [
                        RatingBar(rating: reviewData.reviewRating),
                        SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          reviewData.reviewRating!.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              day==0?"today".tr:
              day.toString() + "${day>1?  "days_ago".tr :"day_ago".tr}",
              style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
          ],
        ),
        SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(reviewData.reviewComment!,
            style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
            textAlign: TextAlign.justify,
          )
        ),
        SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
      ],
    );
  }
}
