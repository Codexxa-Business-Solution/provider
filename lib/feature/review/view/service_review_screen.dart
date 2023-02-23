import 'package:demandium_provider/feature/review/widget/review_heading.dart';
import 'package:demandium_provider/feature/review/widget/review_linear_chart.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/review/model/review_model.dart';
import 'package:demandium_provider/feature/review/widget/empty_review_widget.dart';
import 'package:demandium_provider/feature/review/widget/service_review_item.dart';

class ServiceDetailsReview extends StatelessWidget {
  const ServiceDetailsReview({
    Key? key,
    required this.reviewList,
    required this.rating,
    required this.scrollController
  }) : super(key: key);

  final List<ReviewData> reviewList;
  final Rating rating;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {

    if(reviewList.length >0)
      return  SliverToBoxAdapter(
        child: Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
              minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
            ) : null,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReviewHeading(rating: rating),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  ReviewLinearChart(rating:rating),

                  const Divider(),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviewList.length,
                    itemBuilder: (context, index){
                      return ServiceReviewItem(reviewData: reviewList.elementAt(index),);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    return SliverToBoxAdapter(child: EmptyReviewWidget());
  }
}