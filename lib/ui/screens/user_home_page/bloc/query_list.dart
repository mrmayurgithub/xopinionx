import 'package:flutter/material.dart';
import 'package:xopinionx/core/api/models/problem_model.dart';
import 'package:xopinionx/global/global_helpers.dart';
import 'package:xopinionx/ui/global/constants.dart';
import 'package:xopinionx/ui/screens/user_home_page/components/query_container.dart';

// ignore: must_be_immutable
class QueryList extends StatelessWidget {
  final List<ProblemModel> _problems = globalProblemsList;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                if (_problems.isNotEmpty)
                  Scrollbar(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          for (ProblemModel ele in _problems)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding / 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: kSecondaryColor),
                                      bottom:
                                          BorderSide(color: kSecondaryColor),
                                    ),
                                  ),
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return QueryContainer(ele: ele);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Previous",
                                  style: TextStyle(
                                    color: currentIndex == 0
                                        ? Colors.blue.withOpacity(0.3)
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Next",
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  const SelectableText("No Questions to show"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
