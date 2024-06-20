import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/authentication/authorization/authorization_bloc.dart';
import 'package:recipes/core/domain/services/authentication_service.dart';
import 'package:recipes/features/approve_recipes/widgets/recipes_to_check_template.dart';
import 'package:recipes/features/common/widgets/custom_drawer.dart';
import 'package:recipes/core/domain/presentation/bloc/admin/admin_bloc.dart';
import 'package:recipes/core/domain/services/admin_service.dart';
import 'package:recipes/features/common/widgets/unauthenticated_widget.dart';
import '../../common/widgets/back_icon_widget.dart';
import '../../common/widgets/nav_bar_text_search.dart';

class ApplicationsForApproval extends StatefulWidget {
  @override
  _ApplicationsForApprovalState createState() =>
      _ApplicationsForApprovalState();
}

class _ApplicationsForApprovalState extends State<ApplicationsForApproval> {
  final AuthenticationBloc authenticationBloc =
      AuthenticationBloc(authenticationService: AuthenticationService());
  late AdminBloc adminBloc;

  @override
  void initState() {
    super.initState();
    adminBloc = new AdminBloc(
        adminService: AdminService(), authenticationBloc: authenticationBloc);
    //adminBloc.add(FetchRecipesToCheck(page: 0, number: 10));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: adminBloc),
        BlocProvider.value(value: authenticationBloc)
      ],
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              NavBarWithTextAndSearch(
                title: 'Application for approval',
                navWidget: BackIconWidget(width: width),
                width: width,
                height: height,
              ),
              Expanded(child:
                  RecipesToCheckTemplate()
              ),
              UnauthenticatedWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
