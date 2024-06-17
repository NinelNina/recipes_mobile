import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_event.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_state.dart';
import 'package:recipes/core/domain/services/admin_service.dart';
import 'package:recipes/features/statistics/widgets/stat.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import '../../common/widgets/back_icon_widget.dart';
import '../../common/widgets/nav_bar_title_clouse.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final String title = 'Statistics';
  AdminBloc adminBloc = AdminBloc(adminService: AdminService());

  final List<String> categories = [
    'Total registered users:',
    'Recipes created by users:',
    'The most popular diet (last month):',
    'Most popular recipe (last month):'
  ];

  @override
  void initState() {
    super.initState();
    adminBloc.add(LoadStatistic());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return BlocProvider.value(value: adminBloc,
        child: Scaffold(
            drawer: CustomDrawer(),
            backgroundColor: Colors.white,
            body: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    NavBarTitleCl(
                      title: title,
                      navWidget: BackIconWidget(width: width),
                      width: width,
                      height: height,
                    ),
                    SizedBox(height: height * 0.015),
                    BlocBuilder<AdminBloc, AdminState>(
                      builder: (context, state) {
                        if (state is AdminLoading) {
                          return CircularProgressIndicator(color: Color(0xFFFF6E41));
                        } else if (state is StatisticLoaded) {
                          final answers = [
                            state.statistic.quantityUsers.toString(),
                            state.statistic.quantityUserRecipes.toString(),
                            state.statistic.popularDiet,
                            state.statistic.popularRecipe
                          ];
                          return Stat(
                            categories: categories,
                            answers: answers,
                            width: width * 0.92,
                            height: height * 0.09,
                          );
                        } else if (state is AdminError) {
                          return Text('Error: ${state.message}');
                        }
                        return Text('Press a button to load data');
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
