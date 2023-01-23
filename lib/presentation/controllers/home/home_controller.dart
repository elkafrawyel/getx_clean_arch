import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/futureState.dart';
import 'package:getx_clean_arch/domain/entities/models/compound_model.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';
import '../../../data/models/compounds_response.dart';
import '../../../data/providers/network/exception.dart';

class HomeController extends GetxController {
  HomeController(this._compoundsRepository);

  final CompoundsRepository _compoundsRepository;

  int _currentPage = 0;
  int _lastPage = 1;
  final FutureState futureState = FutureState(FutureStateOptions.initiating);
  CompoundsResponse? compoundsResponse;
  final List<CompoundModel> _compounds = [];
  ApiException? exception;

  get compounds => _compounds;

  fetchData() async {
    _currentPage = 1;
    Either<ApiException, CompoundsResponse> result = await _compoundsRepository.fetchCompounds(_currentPage);
    result.fold(
      (l) => exception = l,
      (t) {
        _lastPage = t.meta?.lastPage ?? 1;
        _compounds.addAll(t.data ?? []);
      },
    );

    update();
  }

  loadMore() async {
    if (futureState.isLoadingMore) return;

    if (_currentPage >= _lastPage) {
      futureState.loadingMoreEnd();
      update();
      return;
    }
    futureState.loadingMore();
    update();
    _currentPage += 1;
    Either<ApiException, CompoundsResponse> result = await _compoundsRepository.fetchCompounds(_currentPage);
    result.fold(
      (l) => exception = l,
      (t) {
        _lastPage = t.meta?.lastPage ?? 1;
        _compounds.addAll(t.data ?? []);
      },
    );
    futureState.complete();
    update();
  }
}
