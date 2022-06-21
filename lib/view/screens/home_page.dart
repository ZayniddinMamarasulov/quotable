import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotable/view_model/bloc/quote_bloc.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

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

  int _getRandomNub() {
    var rng = Random();
    return rng.nextInt(1000);
  }

  NetworkImage getNewImage() {
    return NetworkImage(
        "https://picsum.photos/200/400/?image=${_getRandomNub()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 100,
        controller: PageController(
          initialPage: 0,
          keepPage: true,
          viewportFraction: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return buildContent();
        },
        onPageChanged: (index) {
          _fetchRandom();
        },
      ),
    );
  }

  Widget buildMain(state) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.dstATop),
          image: getNewImage(),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.quote.content!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 28,
                  height: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    return Column(
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
            return Container(color: Colors.black38, child: buildMain(state));
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
