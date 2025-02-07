import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_design_system/colors/colors.dart';
import 'package:flutter_design_system/components/widgets/tabs/dynamic_tabs_state.dart';

class DSDynamicTabs extends StatelessWidget {
  final TabController tabController;
  final List<String> tabList;

  const DSDynamicTabs({
    super.key,
    required this.tabController,
    required this.tabList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicTabBloc, DynamicTabState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: tabList.map((tab) {
              final int index = tabList.indexOf(tab);
              final bool isSelected = state.selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    context
                        .read<DynamicTabBloc>()
                        .add(DynamicTabChanged(index));
                    tabController.animateTo(index);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? DSColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tab,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: DSColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
