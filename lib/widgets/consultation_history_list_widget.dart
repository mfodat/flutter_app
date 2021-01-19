import 'package:flutter/material.dart';
import '../providers/tele_medicine.dart';
import '../widgets/consultation_history_widget.dart';
import 'package:provider/provider.dart';

class ConsultationHistoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer<TeleMedicine>(
      builder: (context, teleMedicine, child) {
       var memberHistoryList =  teleMedicine.memberHistoryList;
        return ListView.builder(
          itemBuilder: (context, index) {
            final task =  memberHistoryList?.elementAt(index);
            return ConsultationHistoryWidget(
              reference: task== null ? '' : task.referenceNumber ,
              date: task== null ? '' : task.submissionDate ,
              name: task== null ? '' : task.memberName ,
              status: task== null ? '' : task.status ,
              index: index,
            );
          },
          itemCount: memberHistoryList==null ? 0: memberHistoryList.length,
        );
      },
    );
  }
}
