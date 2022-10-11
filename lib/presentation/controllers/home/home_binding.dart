import 'package:get/get.dart';
import 'package:getx_clean_arch/data/repositories/compounds_repository.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompoundsRepositoryIml());
    Get.lazyPut(() => HomeController(Get.find<CompoundsRepositoryIml>()));
  }
}
