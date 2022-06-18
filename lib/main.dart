import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotable/view/screens/home_page.dart';
import 'package:quotable/view_model/bloc/quote_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotable',
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context)=>QuoteBloc()),
          ],
          child: HomePage()),
    );
  }
}
