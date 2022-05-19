import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hivee/model/currency_model.dart';
import 'package:hivee/screens/box_page.dart';
import 'package:hivee/service/currency_service.dart';
import 'package:hivee/widget/baseview_widget.dart';
import 'package:hivee/widget/mycontainer_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: HomeScreen(),
        OnPageBuilder: (context, widget) {
          return Scaffold(
            body: FutureBuilder(
              future: CurrencyService.getCurrencies(),
              builder: (context, AsyncSnapshot<List<CurrencyModel>?> snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snap.hasError) {
                  return const Center(
                    child: Text("ERORR"),
                  );
                } else {
                  var data = snap.data;
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 50),
                          alignment: Alignment.center,
                          child: const Text(
                            "Currencies (Online)",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: SmartRefresher(
                          controller: _refreshController,
                          child: ListView.builder(
                            itemBuilder: (context, i) {
                              return ContainerWidget(
                                title: data![i].title.toString(),
                                subtitle: data[i].cbPrice.toString(),
                              );
                            },
                            itemCount: data!.length,
                          ),
                          onRefresh: _onRefresh,
                          onLoading: onLoading,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          );
        });
  }
void onLoading()async{
  await Future.delayed(Duration(seconds: 2));
  _refreshController.refreshFailed();
}
  

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

}
