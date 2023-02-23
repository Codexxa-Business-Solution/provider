import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/dark_theme.dart';
import 'package:demandium_provider/feature/service_details/model/service_faq_model.dart';
import 'package:demandium_provider/feature/service_details/widget/empty_faq_widget.dart';

class FaqScreen extends StatelessWidget {
  final List<ServiceFAQData>? faqList;
  const FaqScreen({Key? key,required this.faqList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: faqList!=null && faqList!.length!=0?
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: faqList!.length,
        itemBuilder: (context, index) {
          return CustomExpansionTile(
            collapsedTextColor: dark.backgroundColor,
            title: Text(faqList![index].question??"",
              style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
              )
            ),
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(faqList![index].answer??"",
                      textAlign: TextAlign.justify,
                      style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ) : EmptyFAQWidget(),
    );
  }
}
