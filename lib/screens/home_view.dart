import 'package:blinkit/common_widgets/blinkit_common_svg.dart';
import 'package:blinkit/models/product_model.dart';
import 'package:blinkit/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/categories_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/titles_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(
        () => controller.isBottomNavVisible.value ? const BlinkitBottomNav() : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.mainScrollController,
          physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: Obx(
                () => Container(
                  color: controller.headerColor,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: _headerText(),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchCategoriesDelegate(controller),
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => Container(
                  color: controller.sectionBgColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const PinkTilesGrid(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final title = controller.categories[index];
                  final items = controller.productsFor(index);

                  return Obx(
                    () => Container(
                      color: controller.sectionBgColor,
                      key: controller.contentKeys[index],
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Most Popular",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _productCard(items),
                        ],
                      ),
                    ),
                  );
                },
                childCount: controller.categories.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  static Widget _productCard(List<ProductModel> items) {
    return SizedBox(
      height: 340,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) => SizedBox(
          width: 160,
          child: ProductCard(item: items[index]),
        ),
      ),
    );
  }

  static Widget _headerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "8 minutes",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 4),
            Text(
              "HOME - Call me, Srinivasa mens pg",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        Row(
          children: [
            _iconBox(AppImages.blinkitWallet),
            const SizedBox(width: 8),
            _iconBox(AppImages.blinkitPerson),
          ],
        ),
      ],
    );
  }

  static Widget _iconBox(String svgPath) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlinkitCommonSVGIcon(
        image: svgPath,
        width: 24,
        height: 24,
      ),
    );
  }
}

class _SearchCategoriesDelegate extends SliverPersistentHeaderDelegate {
  final HomeController ctrl;
  static const double size = 113;

  _SearchCategoriesDelegate(this.ctrl);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(
      () => Container(
        color: ctrl.headerColor,
        child: Column(
          children: [
            Container(
              height: 54,
              color: ctrl.headerColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: const BlinkitSearchBar(
                hint: 'Search "flower jewellery"',
                showMic: true,
              ),
            ),
            SizedBox(
              height: 58,
              child: ListView.separated(
                controller: ctrl.categoryController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                itemCount: ctrl.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return Obx(
                    () => Container(
                      key: ctrl.categoryKeys[index],
                      child: BlinkitCategoryTab(
                        label: ctrl.categories[index],
                        icon: SvgPicture.asset(
                          CategoriesData.categoryIcons[index],
                          height: 22,
                          width: 22,
                          color: Colors.black87,
                        ),
                        selected: ctrl.selectedCategoryIndex.value == index,
                        onTap: () => ctrl.selectCategory(index),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(height: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(_) => false;
}
