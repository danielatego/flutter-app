import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningflutter/blocComponents/counter_cubit.dart';
import 'package:learningflutter/blocComponents/counter_page.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CounterCubit>(
        create: (BuildContext context) => CounterCubit(),
        child: const CounterPage(),
      ),
    );
  }
}
