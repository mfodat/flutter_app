import 'package:flutter/material.dart';
import '../providers/tele_medicine.dart';
import './telemedicine_consultation_screen.dart';
import '../util/exception_handler.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/filter_modal_bottom_sheet.dart';
import '../widgets/tasks_list.dart';
import '../widgets/header.dart';
import 'package:provider/provider.dart';


class ShowHistoryScreen extends StatefulWidget {
  @override
  _ShowHistoryScreenState createState() => _ShowHistoryScreenState();
}

class _ShowHistoryScreenState extends State<ShowHistoryScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
       try{
        Provider.of<TeleMedicine>(context).fetchHistory().then((_) {
          setState(() {
            _isLoading = false;
          });
        }).catchError((error) {
          setState(() {
            _isLoading = false;
          });
            var errorMessage = ExceptionHandler.handelException(error);
            _showErrorDialog(errorMessage);
          });


       } catch (error) {
         setState(() {
           _isLoading = false;
         });
         var errorMessage = ExceptionHandler.handelException(error);
         _showErrorDialog(errorMessage);
       }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => displayModalBottomSheet(context),
                child: Icon(
                  Icons.filter_alt_outlined,
                  size: 26.0,
                ),
              )),
        ],
        //backgroundColor: Colors.lightBlueAccent[100],
      ),
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        //  backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return TelemedicineConsultation();
              }),
            );
          }),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header(),
                Expanded(
                  child: TasksList(),
                ),
              ],
            ),
      bottomNavigationBar: MedicalPolicesBottomNavigationBar(),
    );
  }

  void displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return FilterModalBottomSheet();
        });
  }
}
