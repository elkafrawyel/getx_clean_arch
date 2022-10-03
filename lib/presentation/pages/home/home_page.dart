import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/domain/entities/compound_model.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_controller.dart';
import 'package:getx_clean_arch/presentation/widgets/pagination_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {
        homeController.fetchData();
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: PaginationView(
            showLoadMoreWidget: homeController.isLoadMore,
            showLoadMoreEndWidget: homeController.isLoadMoreEnd,
            loadMoreData: () => homeController.loadMore(),
            child: ListView.builder(
              itemCount: homeController.compounds.length,
              itemBuilder: (context, index) {
                final CompoundModel compound = homeController.compounds[index];
                return SizedBox(
                  width: Get.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        compound.name ?? ' No Name',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
