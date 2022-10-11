import 'package:get/get.dart';
import 'package:getx_clean_arch/domain/entities/models/compound_model.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';
import 'package:tuple/tuple.dart';

class HomeController extends GetxController {
  HomeController(this._compoundsRepository);

  final CompoundsRepository _compoundsRepository;

  int _currentPage = 0;
  int _lastPage = 1;
  bool _isLoadMore = false;
  bool _isLoadMoreEnd = false;
  final List<CompoundModel> _compounds = [];

  get compounds => _compounds;

  bool get isLoadMore => _isLoadMore;

  bool get isLoadMoreEnd => _isLoadMoreEnd;

  fetchData() async {
    _currentPage = 1;
    Tuple2<int, List<CompoundModel>> tuple2 = await _compoundsRepository.fetchCompounds(_currentPage);
    _lastPage = tuple2.item1;
    _compounds.assignAll(tuple2.item2);
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
    Tuple2<int, List<CompoundModel>> tuple2 = await _compoundsRepository.fetchCompounds(_currentPage);
    _lastPage = tuple2.item1;
    _compounds.addAll(tuple2.item2);
    _isLoadMore = false;
    update();
  }
}
