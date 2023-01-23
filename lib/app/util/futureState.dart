/// simple class that represents state of a future for purposes of ui rendering correct states
class FutureState {
  FutureStateOptions initialState;

  FutureState([this.initialState = FutureStateOptions.initiating]);

  bool get isInitiating => initialState == FutureStateOptions.initiating;

  bool get isLoading => initialState == FutureStateOptions.loading;

  bool get isLoadingMore => initialState == FutureStateOptions.loadingMore;

  bool get isLoadingMoreEnd => initialState == FutureStateOptions.loadingMoreEnd;

  bool get isComplete => initialState == FutureStateOptions.completed;

  bool get isFailed => initialState == FutureStateOptions.failed;

  ///set state to loading. use this or change state directly. this is quick shortcut
  void load() => initialState = FutureStateOptions.loading;

  ///set state to loading more data. use this or change state directly. this is quick shortcut
  void loadingMore() => initialState = FutureStateOptions.loadingMore;

  void loadingMoreEnd() => initialState = FutureStateOptions.loadingMoreEnd;

  ///set state to completed. use this or change state directly. this is quick shortcut
  void complete() => initialState = FutureStateOptions.completed;

  ///set state to completed. use this or change state directly. this is quick shortcut
  void fail() => initialState = FutureStateOptions.failed;

  void empty() => initialState = FutureStateOptions.empty;
}

enum FutureStateOptions {
  ///didn't even start
  initiating,
  loading,
  loadingMore,
  loadingMoreEnd,
  empty,
  failed,
  completed
}
