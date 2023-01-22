import 'package:fpdart/fpdart.dart';
import 'package:getx_clean_arch/domain/repositories/compounds_repository.dart';

import '../models/compounds_response.dart';
import '../providers/network/api_client.dart';

class CompoundsRepositoryIml extends CompoundsRepository {
  final apiClient = ApiClient();

  @override
  Future<Either<Exception, CompoundsResponse>> fetchCompounds(int page) async {
    final response = await apiClient.get('/getAllCompounds?page=$page');
    return response.fold(
      (exception) => left(exception),
      (data) => right(CompoundsResponse.fromJson(data)),
    );
  }
}
