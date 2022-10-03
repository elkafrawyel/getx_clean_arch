abstract class ParamUseCase<ReturnType, Params> {
  Future<ReturnType> execute(Params params);
}
