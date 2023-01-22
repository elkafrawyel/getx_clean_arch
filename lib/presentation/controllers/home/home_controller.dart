import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/domain/entities/models/compound_model.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';
import '../../../data/models/compounds_response.dart';

class HomeController extends GetxController {
  HomeController(this._compoundsRepository);

  final CompoundsRepository _compoundsRepository;

  int _currentPage = 0;
  int _lastPage = 1;
  bool _isLoadMore = false;
  bool _isLoadMoreEnd = false;
  CompoundsResponse? compoundsResponse;
  final List<CompoundModel> _compounds = [];
  Exception? exception;

  get compounds => _compounds;

  bool get isLoadMore => _isLoadMore;

  bool get isLoadMoreEnd => _isLoadMoreEnd;

  fetchData() async {
    _currentPage = 1;
    Either<Exception, CompoundsResponse> result = await _compoundsRepository.fetchCompounds(_currentPage);
    result.fold(
      (l) => exception =l,
      (t) {
        _lastPage = t.meta?.lastPage ?? 1;
        _compounds.addAll(t.data ?? []);
      },
    );

    update();
  }

  loadMore() async {
    if (_isLoadMore) return;

    if (_currentPage >= _lastPage) {
      _isLoadMoreEnd = true;
      update();
    }
    _isLoadMore = true;
    update();
    _currentPage += 1;
    Either<Exception, CompoundsResponse> result = await _compoundsRepository.fetchCompounds(_currentPage);
    result.fold(
      (l) => exception = l,
      (t) {
        _lastPage = t.meta?.lastPage ?? 1;
        _compounds.addAll(t.data ?? []);
      },
    );
    _isLoadMore = false;
    update();
  }
}
