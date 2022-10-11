import 'package:getx_clean_arch/data/models/compounds_response.dart';
import 'package:getx_clean_arch/data/providers/network/api_provider.dart';
import 'package:getx_clean_arch/domain/entities/models/compound_model.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';
import 'package:tuple/tuple.dart';

class CompoundsRepositoryIml extends CompoundsRepository {
  @override
  Future<Tuple2<int, List<CompoundModel>>> fetchCompounds(int page) async {
    final response = await APIProvider.instance.get('/getAllCompounds?page=$page');
    final CompoundsResponse compoundsResponse = CompoundsResponse.fromJson(response.data);
    return Tuple2(
      compoundsResponse.meta?.lastPage ?? 0,
      compoundsResponse.data ?? [],
    );
  }
}
