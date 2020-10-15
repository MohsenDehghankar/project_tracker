import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_tracker/blocs/main_bloc.dart';
import 'package:project_tracker/blocs/project_detail_bloc.dart';

/// bottom app bar for projects page
class BottomAppBarBuilder {
  Widget build(Color color, BuildContext context, bool mainPage) {
    return new BottomAppBar(
      color: color,
      shape: CircularNotchedRectangle(),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          mainPage
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<MainBloc>(context).add(MainEventLogout());
                  },
                  icon: Icon(Icons.logout),
                )
              : IconButton(icon: Icon(Icons.keyboard_return), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: mainPage
                  ? () {
                      Scaffold.of(context).removeCurrentSnackBar();
                      BlocProvider.of<MainBloc>(context)
                          .add(MainEventRefresh());
                    }
                  : () {
                      Scaffold.of(context).removeCurrentSnackBar();
                      BlocProvider.of<ProjectDetailBloc>(context)
                          .add(DetailEventReloadData());
                    })
        ],
      ),
    );
  }
}
