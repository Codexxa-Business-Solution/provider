import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ServiceOverview extends StatelessWidget {
  final ServiceDetailsController serviceDetailsController;
  const ServiceOverview({Key? key,required this.serviceDetailsController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child:  Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Center(
          child: HtmlWidget(
          serviceDetailsController.serviceDetailsModel!.content!.description!,
            textStyle: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
          ),
        ),
      ),
    );
  }
}