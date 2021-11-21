library dashboard;

import 'package:daily_task/app/constans/app_constants.dart';
import 'package:daily_task/app/shared_components/header_text.dart';
import 'package:daily_task/app/shared_components/list_task.dart';
import 'package:daily_task/app/shared_components/search_field.dart';
import 'package:daily_task/app/shared_components/selection_button.dart';
import 'package:daily_task/app/shared_components/simple_selection_button.dart';
import 'package:daily_task/app/shared_components/simple_user_profile.dart';
import 'package:daily_task/app/shared_components/task_progress.dart';
import 'package:daily_task/app/shared_components/user_profile.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daily_task/app/utils/helpers/app_helpers.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component
part '../components/add_button.dart';
part '../components/main_menu.dart';
part '../components/task_menu.dart';
part '../components/member.dart';
part '../components/weekly_task.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: _buildSidebar(context),
          ),
          Flexible(
            flex: 10,
            child: _buildContent(),
          ),
          Flexible(
            flex: 4,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UserProfile(
            data: controller.dataProfil,
            onPressed: controller.onPressedProfil,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _MainMenu(onSelected: controller.onSelectedMenu),
        ),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 60,
        ),
        _Member(member: controller.member),
        const SizedBox(height: kSpacing),
        _TaskMenu(
          onSelected: (index, label) {},
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: _AddButton(
            onPressed: controller.add,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Text(
            "2021 Teamwork lisence",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Row(
          children: [
            HeaderText(
              DateTime.now().formatdMMMMY(),
            ),
            const Spacer(),
            SizedBox(
              width: 200,
              child: TaskProgress(data: controller.dataTask),
            ),
          ],
        ),
        SearchField(
          onSearch: controller.searchTask,
          hintText: "Search Task .. ",
        ),
        const SizedBox(height: kSpacing),
        _WeeklyTask(
          data: controller.weeklyTask,
          onPressed: controller.onPressedTask,
          onPressedAssign: controller.onPressedAssignTask,
          onPressedMember: controller.onPressedMemberTask,
        )
      ],
    );
  }
}
