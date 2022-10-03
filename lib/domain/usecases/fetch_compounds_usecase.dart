import 'package:getx_clean_arch/app/core/usecases/pram_usecase.dart';
import 'package:getx_clean_arch/domain/entities/compound_model.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';
import 'package:tuple/tuple.dart';

class FetchCompoundsUseCase extends ParamUseCase<Tuple2<int, List<CompoundModel>>, int> {
  final CompoundsRepository _repo;

  FetchCompoundsUseCase(this._repo);

  @override
  Future<Tuple2<int, List<CompoundModel>>> execute(int params) {
    return _repo.fetchCompounds(params);
  }
}
