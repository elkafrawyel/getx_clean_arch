import 'package:getx_clean_arch/domain/entities/compound_model.dart';
import 'package:tuple/tuple.dart';

abstract class CompoundsRepository {
  Future<Tuple2<int, List<CompoundModel>>> fetchCompounds(int page);
}
