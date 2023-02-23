import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/service_details/widget/rating_bar.dart';


class ProviderReviewItem extends StatelessWidget {
  final ReviewData reviewData;
  const ProviderReviewItem({
    Key? key,
    required this.reviewData
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    List<String> variationName =[];
    String serviceName ='';

    reviewData.booking?.detail?.forEach((element) {
      if(reviewData.serviceId==element.serviceId){
        serviceName = element.serviceName??"";
        variationName.add(element.variantKey??'');
      }
    });
    String variation = variationName.toString().replaceAll('[', '').replaceAll(']', '');

    int day = DateTime.now().difference(
        DateConverter.dateTimeString(DateConverter.isoStringToLocalDate( reviewData.createdAt!).toString())
    ).inDays;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(reviewData.customer != null)
                        Text(reviewData.customer!.firstName! + " " + reviewData.customer!.lastName!,
                          style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                          ),
                        ),

                        Text(
                          day==0?"today".tr:
                          day.toString() + "${day>1?  "days_ago".tr :"day_ago".tr}",
                          style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                        ),
                      ],
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
                        RatingBar(rating: reviewData.reviewRating,size: 15,),
                        SizedBox(width:Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                  if(reviewData.booking!=null)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text("booking".tr +" # ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                            ),
                          ),
                          Text(reviewData.booking?.readableId.toString()??"",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(reviewData.booking!=null && reviewData.booking!.detail!=null)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Text("service_name".tr +" : ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                            ),
                          ),
                          Flexible(
                            child: Text(serviceName,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(reviewData.booking!=null && reviewData.booking!.detail!=null)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("variant".tr +" : ",
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                            ),
                          ),
                          Flexible(
                            child: Text(variation,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
          ],
        ),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: Dimensions.PADDING_SIZE_SMALL),
            child: Text(reviewData.reviewComment!,
              style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
              textAlign: TextAlign.justify,
            )
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
