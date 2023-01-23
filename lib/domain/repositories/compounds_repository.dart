import 'package:fpdart/fpdart.dart';
import '../../data/models/compounds_response.dart';
import '../../data/providers/network/exception.dart';

abstract class CompoundsRepository {
  Future<Either<ApiException, CompoundsResponse>> fetchCompounds(int page);
}
