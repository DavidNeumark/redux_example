import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:redux_example/user.dart';


enum Actions { Increment , Decrement }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  } else if (action == Actions.Decrement) {
    return state -1;
  }

  return state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  var user = User(email:'john', phoneNumber: '055');
  print(user.email);

User userReducer(User state, dynamic action) {
  if (action == User) {
    return action;
  }
  return state;
}

  final userStore = Store<User>(userReducer, initialState: user);

  runApp(FlutterReduxApp(
    title: 'User Redux Login',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        theme: ThemeData.light(),
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have pushed the button this many times:',
                ),
                StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, count) {
                    return Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: StoreConnector<int, VoidCallback>(
                        builder: (context, callback) {
                          return OutlineButton(
                            padding: EdgeInsets.all(12.0),
                            onPressed: callback,
                            child: Icon(Icons.add),
                          );
                        },
                        converter: (store) {
                          return () => store.dispatch(Actions.Increment);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: StoreConnector<int, VoidCallback>(
                        builder: (context, callback) {
                          return OutlineButton(
                            padding: EdgeInsets.all(12.0),
                            onPressed: callback,
                            child: Icon(Icons.remove),
                            );
                        },
                        converter: (store) {
                          return () => store.dispatch(Actions.Decrement);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




}
