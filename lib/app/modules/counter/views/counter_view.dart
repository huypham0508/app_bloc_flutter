import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_bloc.dart';
import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_events.dart';
import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_state.dart';
import 'package:app_bloc_flutter/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late CounterBloc counterBloc;
  @override
  void initState() {
    super.initState();
    counterBloc = BlocProvider.of<CounterBloc>(context)
      ..add(InitialCounterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App with BLoC'),
      ),
      body: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => loading(),
            );
          } else {
            context.pop();
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Counter Value:',
                ),
                Text(
                  '${state.count}',
                  style: const TextStyle(fontSize: 40),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => counterBloc.add(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          BlocBuilder<LoToBloc, LotoState>(
            builder: (context, state) {
              return Text(state.count.toString());
            },
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () => counterBloc.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  loading() {
    return const Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
