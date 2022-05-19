import 'package:flutter/material.dart';
import 'package:hivee/service/currency_service.dart';
import 'package:hivee/widget/mycontainer_widget.dart';

class BoxPage extends StatelessWidget {
  const BoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Currencies (offline)",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: CurrencyService.box!.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        return ContainerWidget(
                          title:
                              CurrencyService.box!.getAt(i)!.title.toString(),
                          subtitle:
                              CurrencyService.box!.getAt(i)!.cbPrice.toString(),
                        );
                      },
                      itemCount: CurrencyService.box!.length,
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
