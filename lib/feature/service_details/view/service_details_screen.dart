import 'package:demandium_provider/feature/review/controller/review_controller.dart';
import 'package:demandium_provider/feature/review/view/service_review_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/service_details/model/service_details_model.dart';
import 'package:demandium_provider/feature/service_details/repo/service_details_repo.dart';
import 'package:demandium_provider/feature/review/widget/empty_review_widget.dart';
import 'package:demandium_provider/feature/service_details/widget/service_details_shimmer.dart';
import 'package:demandium_provider/feature/service_details/widget/variation_bottom_sheet.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String serviceId;
  final Discount discount;
  const ServiceDetailsScreen({Key? key,required this.serviceId, required this.discount}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ServiceDetailsController(
        serviceDetailsRepo: ServiceDetailsRepo(apiClient: Get.find(), sharedPreferences: Get.find())
    ));
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "service_details".tr,),
      body: GetBuilder<ServiceDetailsController>(
        initState: (state)  {
          Get.find<ServiceDetailsController>().getServiceDetailsData(widget.serviceId);
          },
          builder: (serviceDetailsController){

          return serviceDetailsController.isLoading?
          ServiceDetailsShimmer() :
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                floating: true,
                delegate: BannerDelegate(serviceDetailsController: serviceDetailsController),
              ),

              SliverToBoxAdapter(
                child:Stack(children: [
                  Container(
                     padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                     decoration: BoxDecoration(
                       color: Theme.of(context).cardColor,
                       boxShadow: shadow,
                     ),
                    child: Column(
                      children: [
                        SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_LARGE),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(5),
                              child: CustomImage(height: 60, width: 60,
                                image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants
                                    .SERVICE_IMAGE_PATH}''${serviceDetailsController.serviceDetailsModel!.content!.thumbnail??""}',
                              )
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 18,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 3,),
                                        Image(image: AssetImage(Images.starIcon)),
                                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        Text(double.tryParse(serviceDetailsController.serviceDetailsModel!
                                            .content!.avgRating.toString())!.toStringAsFixed(1),
                                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                              color: Theme.of(context).colorScheme.tertiary)
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width:Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text("(${serviceDetailsController.serviceDetailsModel!.content!.ratingCount.toString()})",
                                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("start_form".tr,
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                                    ),
                                  ),

                                ],
                              ),
                            ]),

                            serviceDetailsController.variantList.length>0?
                            Container(width: Get.width*.30, child:
                              Column(
                                children: [
                                  if(widget.discount.discountAmount!>0)
                                  Text( PriceConverter.convertPrice(
                                        double.tryParse(serviceDetailsController.variantList[0].price.toString())),
                                    style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).errorColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),

                                  Text(PriceConverter.convertPrice(
                                    double.parse(serviceDetailsController.variantList[0].price.toString()),
                                    discount:  double.parse('${widget.discount.discountAmount}'),
                                    discountType:  widget.discount.discountAmountType!=null?
                                    widget.discount.discountAmountType!:"").toString(),
                                    style: ubuntuBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).primaryColor,decoration: TextDecoration.none
                                    ),
                                  ),
                                ],
                              )
                            ) :SizedBox.shrink(),

                            SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),

                            CustomButton(
                              height: 25,
                              width: 60,
                              fontSize: 10,
                              btnTxt: 'see_all'.tr,
                              onPressed: ()=>Get.bottomSheet(VariantBottomSheet()),
                            ),
                          ],
                        ),

                        SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        Text(serviceDetailsController.serviceDetailsModel!.content!.shortDescription!,
                          textAlign: TextAlign.justify,
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                          ),
                        ),
                        SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
                      ],
                    ),
                  ),

                  widget.discount.discountAmount! > 0.0?
                  Positioned(top: 0, right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: 3),
                      child: Center(
                        child: Text(PriceConverter.percentageCalculation(
                          '', widget.discount.discountAmount.toString(),
                          widget.discount.discountAmountType.toString(),
                        ),
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: light.cardColor),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ):SizedBox.shrink()],
                ),
              ),

              SliverPersistentHeader(pinned: true, floating: false, delegate: TabBarDelegate()),

             GetBuilder<ReviewController>(builder: (reviewController){
               return  GetBuilder<ServiceDetailsController>(
                 initState: (_){
                   Get.find<ServiceDetailsController>().getServiceFAQData(widget.serviceId);
                   reviewController.getServiceReview(widget.serviceId);
                 },
                 builder: (serviceController) {
                   if(serviceController.servicePageCurrentState == ServiceTabControllerState.serviceOverview){
                     return ServiceOverview(serviceDetailsController: serviceDetailsController);
                   }else if(serviceController.servicePageCurrentState == ServiceTabControllerState.faq){
                     return FaqScreen(faqList: serviceDetailsController.serviceFaqModel!=null
                         ?serviceDetailsController.serviceFaqModel!.content!.data!:[]
                     );
                   }else if(reviewController.serviceReviewList!=null && reviewController.serviceRating!=null){
                     return ServiceDetailsReview(
                       reviewList: reviewController.serviceReviewList!,
                       rating : reviewController.serviceRating!,
                       scrollController: reviewController.scrollController,
                     );
                   }else{
                     return  SliverToBoxAdapter(child: EmptyReviewWidget());
                   }
                 },
               );
             }),
            ],
          );
      },),
    );
  }
}

class BannerDelegate extends SliverPersistentHeaderDelegate {
  final ServiceDetailsController serviceDetailsController;
  BannerDelegate({required this.serviceDetailsController});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Stack(
      children: [
        Container(color: light.cardColor, width: Get.width, height: 120),

        CustomImage(
          width: Get.width,
          height: 120,
          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants.SERVICE_IMAGE_PATH}'
               '${serviceDetailsController.serviceDetailsModel!.content!.coverImage!}',
        ),

        Container(
          height: 120,
          width: Get.width,
          color: Colors.black.withOpacity(0.4),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Center(
            child: Text(serviceDetailsController.serviceDetailsModel!.content!.name.toString(),
              textAlign: TextAlign.justify,
              maxLines: 2,
              style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: light.cardColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  double get maxExtent => 120;
  @override
  double get minExtent => 120;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      child: GetBuilder<ServiceDetailsController>(
        builder: (serviceTabController){
          return  Container(
            height: 50,
            width: Get.width,
            color: Theme.of(context).backgroundColor,
            padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.7), width: 0.5),),
              ),

              child: Center(
                child: TabBar(
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  controller: serviceTabController.controller!,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor:  Theme.of(context).primaryColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                  onTap: (int? index) {
                    switch (index) {
                      case 0:serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.serviceOverview);
                      break;
                      case 1:serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.faq);
                      break;
                      case 2:serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                      break;
                    }
                  },
                  tabs: serviceTabController.myTabs,
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}