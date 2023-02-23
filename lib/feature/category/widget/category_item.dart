import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.title, required this.selectedCategory,required this.image}) : super(key: key);
  final String title;
  final String image;
  final String selectedCategory;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: 3),
      height: 90,
      width:85,
      decoration: BoxDecoration(
        color: selectedCategory == title  ? Theme.of(context).primaryColor : Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
        boxShadow: shadow,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),

          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CustomImage(
              height: 30,
              width: 30,
              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                  '${AppConstants.CATEGORY_IMAGE_PATH}${image}'
            ),
          ),
          SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Container(
            width: 85,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(
              "${title}",
              textAlign: TextAlign.center,
              style:ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color:  selectedCategory == title ? light.cardColor : Theme.of(context).hintColor,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
          ),
          //Color(0xFF758590)
        ],
      ),
    );
  }
}
