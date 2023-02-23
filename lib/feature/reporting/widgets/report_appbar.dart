import 'package:demandium_provider/feature/reporting/view/report_search_filter.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ReportAppBarView extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Function()? onPressed;
  final String fromPage;
  const ReportAppBarView({
    Key? key,
    this.title,this.centerTitle=false, this.onPressed, required this.fromPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 5,
      titleSpacing: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
      centerTitle: centerTitle,
      title: Text(title!,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),),
      leading: IconButton(
        onPressed: onPressed!=null? onPressed:(){
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
      ),
      actions: [
        InkWell(
          onTap: (){

            Get.to(()=>ReportSearchFilter(fromPage: fromPage,));
          },
          child:Icon(
            Icons.filter_list,
            size: 30,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}
