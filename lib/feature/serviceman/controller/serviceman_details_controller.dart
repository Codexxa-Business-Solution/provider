import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';

class ServicemanDetailsController extends GetxController implements GetxService{
  final ServicemanRepo servicemanRepo;
  ServicemanDetailsController({required this.servicemanRepo});

  DashboardServicemanModel? _servicemanModel;
  DashboardServicemanModel? get servicemanModel => _servicemanModel;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  Future<void> getServicemanDetails(String id) async {
    _isLoading  = true;
    update();
    Response response = await servicemanRepo.getServicemanDetails(id);

    if(response.statusCode==200){
      _servicemanModel = DashboardServicemanModel.fromJson(response.body['content']);
    }
    _isLoading  = false;
    update();
  }

  void updateActiveStatus(){
    int status = servicemanModel!.user!.isActive==1?0:1;
    servicemanModel!.user!.isActive=status;
    update();
  }


}