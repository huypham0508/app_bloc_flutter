CounterState counterInitialState = const CounterState(
  count: 1,
  oldCount: 1,
  loading: false,
);

class CounterState {
  final int count;
  final int oldCount;
  final bool loading;

  const CounterState({
    required this.count,
    required this.oldCount,
    required this.loading,
  });

  CounterState copyWith({
    int? count,
    int? oldCount,
    bool? loading,
  }) {
    return CounterState(
      count: count ?? this.count,
      oldCount: oldCount ?? this.oldCount,
      loading: loading ?? this.loading,
    );
  }
}
