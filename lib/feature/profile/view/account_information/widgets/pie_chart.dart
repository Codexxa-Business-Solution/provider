import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class TransactionPieChart extends StatefulWidget {
  const TransactionPieChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  var totalBookingRequest;
  var percentOfCancelRequest=0;
  var percentOfCompletedRequest=0;
  var percentOfOngoingRequest=0;
  var percentOfAcceptedRequest=0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(builder: (userProfileController){

     totalBookingRequest =(userProfileController.totalOngoingRequest+userProfileController
          .totalCompletedRequest+userProfileController.totalCanceledRequest+userProfileController.totalAcceptedRequest);

       if(userProfileController.totalCanceledRequest!=0)
         percentOfCancelRequest = ((userProfileController.totalCanceledRequest*100.00)/totalBookingRequest).ceil();
       if(userProfileController.totalCompletedRequest!=0)
         percentOfCompletedRequest = ((userProfileController.totalCompletedRequest*100.00)/totalBookingRequest).ceil();
       if(userProfileController.totalOngoingRequest!=0)
         percentOfOngoingRequest = ((userProfileController.totalOngoingRequest*100.00)/totalBookingRequest).floor();
       if(userProfileController.totalAcceptedRequest!=0)
         percentOfAcceptedRequest = ((userProfileController.totalAcceptedRequest*100.00)/totalBookingRequest).floor();



      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                        });
                        },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: showingSections(userProfileController),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.tealAccent,size: 15,),
                      SizedBox(width: 5,),
                      Text(
                        "${'accepted'.tr} (${userProfileController.totalAcceptedRequest})",
                        style: ubuntuRegular.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.blue,size: 15,),
                      SizedBox(width: 5,),
                      Text(
                        "${'ongoing'.tr} (${userProfileController.totalOngoingRequest})",
                        style: ubuntuRegular.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle,color: Colors.green,size: 15,),
                      SizedBox(width: 5,),
                      Text(
                        "${'completed'.tr} (${userProfileController.totalCompletedRequest})",
                        style: ubuntuRegular.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle,color: Colors.red,size: 15,),
                  SizedBox(width: 8,),
                  Text(
                    "${'canceled'.tr} (${userProfileController.totalCanceledRequest})",
                    style: ubuntuRegular.copyWith(fontSize: 12)
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text(
              "${totalBookingRequest}\n${'booking'.tr}",
              textAlign: TextAlign.center,style: ubuntuBold.copyWith(color: Colors.indigo,fontSize: 14),
            ),
          )
        ],
      );
    });
  }

  List<PieChartSectionData> showingSections(UserProfileController userProfileController) {
    return totalBookingRequest>0?List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 16.0;
      final radius = isTouched ? 40.0 : 40.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.redAccent.shade100,
            value: double.tryParse(percentOfCancelRequest.toString()),
            title: percentOfCancelRequest.toString()+"%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.lightBlue,
            value: double.tryParse(percentOfOngoingRequest.toString()),
            title: percentOfOngoingRequest.toString()+"%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.tealAccent,
            value: double.tryParse(percentOfAcceptedRequest.toString()),
            title: percentOfAcceptedRequest.toString()+"%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green.shade300,
            value: double.tryParse(percentOfCompletedRequest.toString()),
            title: percentOfCompletedRequest.toString()+"%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    }):List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xffabe59e),
            value: 1.0,
            title: "",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
