import 'package:fpdart/fpdart.dart';
import '../../data/models/compounds_response.dart';

abstract class CompoundsRepository {
  Future<Either<Exception, CompoundsResponse>> fetchCompounds(int page);
}
