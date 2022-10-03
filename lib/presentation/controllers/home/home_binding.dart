import 'package:get/get.dart';
import 'package:getx_clean_arch/data/repositories/compounds_repository.dart';
import 'package:getx_clean_arch/domain/usecases/fetch_compounds_usecase.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompoundsRepositoryIml());
    Get.lazyPut(() => FetchCompoundsUseCase(Get.find<CompoundsRepositoryIml>()));
    Get.lazyPut(() => HomeController(Get.find<FetchCompoundsUseCase>()));
  }
}
