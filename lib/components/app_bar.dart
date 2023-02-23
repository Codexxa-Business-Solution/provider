import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final bool centerTitle;
  final Function()? onPressed;
  CustomAppBar({Key? key,required this.title,this.centerTitle= false,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      titleSpacing: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
      centerTitle: centerTitle,
      title: Text(title,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),),
      leading: IconButton(
        onPressed: onPressed!=null? onPressed:(){
          Get.back();
        },
          icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
      ),
    );
  }
  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}

