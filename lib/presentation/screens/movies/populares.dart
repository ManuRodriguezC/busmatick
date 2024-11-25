import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/shared/custom_bottom_navbar.dart';

class PopularScreen extends StatelessWidget {
  static const name = 'popular-screen';
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _PopularScreen(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _PopularScreen extends StatefulWidget {
  const _PopularScreen({super.key});

  @override
  State<_PopularScreen> createState() => __PopularScreenState();
}

class __PopularScreenState extends State<_PopularScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
