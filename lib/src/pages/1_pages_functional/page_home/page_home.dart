import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_make_service_order/page_make_service_order.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_my_service_orders.dart';
import 'package:servicemangerapp/src/pages/widgets/buttomHomePageWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/statusServiceWidget.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 100,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   title: Image.asset(
      //     'lib/assets/logo-app.png',
      //     fit: BoxFit.fitHeight,
      //     height: 130,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/logo-app.png',
                  fit: BoxFit.fitHeight,
                  height: 130,
                ),
                const StatusServiceWidget(),
                ButtomHomePageWidget(
                  func: (() {
                    Get.to(() => PageListClientes());
                  }),
                  nameButtom: 'Clientes',
                ),
                ButtomHomePageWidget(
                  func: (() {
                    int numberServiceOrder = Utils.gerenateNumerServiceOrder();
                    Get.to(() => PageMakeServiceOrder(
                          numberServiceOrder: numberServiceOrder,
                        ));
                  }),
                  nameButtom: 'Criar Ordem de Serviço',
                ),
                ButtomHomePageWidget(
                  func: (() {
                    Get.to(() => PageMyServiceOrders());
                  }),
                  nameButtom: 'Minhas Ordens de Serviço',
                ),
                ButtomHomePageWidget(
                  func: (() {}),
                  nameButtom: 'Orçamentos',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
