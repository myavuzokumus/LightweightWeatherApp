import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieRandomPage extends StatefulWidget {
  const LottieRandomPage({Key? key}) : super(key: key);

  @override
  _LottieRandomPageState createState() => _LottieRandomPageState();
}

class _LottieRandomPageState extends State<LottieRandomPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _random = Random();
  final List<String> _lottieUrls = [
    'https://assets1.lottiefiles.com/private_files/lf30_QLsD8M.json',
    'https://assets1.lottiefiles.com/private_files/lf30_yQtj4O.json',
    'https://assets1.lottiefiles.com/private_files/lf30_5wlof9.json',
    'https://assets1.lottiefiles.com/private_files/lf30_3scgfuxu.json',
    'https://assets1.lottiefiles.com/private_files/lf30_4gjwtx3q.json',
    'https://assets1.lottiefiles.com/private_files/lf30_ed0ywf.json',
    'https://assets1.lottiefiles.com/private_files/lf30_blhvlf8w.json',
    'https://assets1.lottiefiles.com/private_files/lf30_uf2bl8lf.json',
    'https://assets1.lottiefiles.com/private_files/lf30_9tqf8pkv.json',
    'https://assets1.lottiefiles.com/private_files/lf30_7heskkis.json',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottie Random Page'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 500,
              height: 500,
              color: Colors.grey[200],
            ),
            ..._lottieUrls.map((url) => _buildLottieWidget(url)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieWidget(String url) {
    return Positioned(
      left: _random.nextInt(400).toDouble(),
      top: _random.nextInt(400).toDouble(),
      child: Lottie.network(
        url,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..repeat();
        },
      ),
    );
  }
}
