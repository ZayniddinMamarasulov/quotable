import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotable/view_model/bloc/quote_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    _fetchRandom();
  }

  void _fetchRandom() {
    context.read<QuoteBloc>().add(GetRandom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<QuoteBloc, QuoteState>(builder: (context, state) {
              if (state is QuoteLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is QuoteError) {
                return Center(child: Text(state.message));
              }
              if (state is QuoteSuccess) {
                return Center(
                    child: Text(
                  state.quote.content!,
                  style: const TextStyle(fontSize: 24, height: 1.5),
                ));
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 96),
            IconButton(
              onPressed: _fetchRandom,
              icon: const Icon(
                Icons.refresh,
                size: 48,
              ),
            )
          ],
        ),
      ),
    );
  }
}
