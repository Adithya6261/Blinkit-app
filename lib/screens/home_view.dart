import 'package:blinkit/common_widgets/blinkit_common_svg.dart';
import 'package:blinkit/models/product_model.dart';
import 'package:blinkit/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/categories_data.dart';
import '../themes/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/titles_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_tab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BlinkitBottomNav(),
      body: SafeArea(
        child: _slivers(controller),
      ),
    );
  }

  Widget _slivers(HomeController controller) {
    return CustomScrollView(
      controller: controller.mainScrollController,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: AppTheme.headerPink,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: _headerText(),
          ),
        ),

        SliverPersistentHeader(
          pinned: true,
          delegate: _SearchCategoriesDelegate(controller),
        ),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PinkTilesGrid(),
          ),
        ),

        // PRODUCT SECTIONS
        _productsList(controller),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _productsList(HomeController controller) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final title = controller.categories[index];
          final items = controller.productsFor(index);

          return Container(
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
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _productCard(items),
              ],
            ),
          );
        },
        childCount: controller.categories.length,
      ),
    );
  }

  Widget _productCard(List<ProductModel> items) {
    return SizedBox(
      height: 320,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        addRepaintBoundaries: true,
        addAutomaticKeepAlives: true,
        addSemanticIndexes: false,
        separatorBuilder: (context,index) => const SizedBox(width: 15),
        itemBuilder: (context, index) => SizedBox(
          width: 160,
          child: RepaintBoundary(
            child: ProductCard(item: items[index]),
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
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
        )
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
  static const double size = 120;

  _SearchCategoriesDelegate(this.ctrl);

  @override
  Widget build(BuildContext context, double shrink, bool overlap) {
    return GetX<HomeController>(
      builder: (ctrl) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              // SEARCH BAR
              _searchbar(),

              // CATEGORY TABS
              _categoryTab(ctrl),

              Container(height: 1, color: Colors.grey.shade300),
            ],
          ),
        );
      },
    );
  }

  Widget _searchbar() {
    return Container(
      height: 54,
      color: AppTheme.headerPink,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: const BlinkitSearchBar(
        hint: 'Search "flower jewellery"',
        showMic: true,
      ),
    );
  }

  Widget _categoryTab(HomeController ctrl) {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        controller: ctrl.categoryController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: ctrl.categories.length,
        separatorBuilder: (context,index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
         return Obx(() {
          return BlinkitCategoryTab(
            label: ctrl.categories[index],
            icon: SvgPicture.asset(
              CategoriesData.categoryIcons[index],
              height: 22,
              width: 22,
              color: Colors.black87,
            ),
            selected: ctrl.selectedCategoryIndex.value == index,
            onTap: () => ctrl.selectCategory(index),
          );
        });
        }
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(oldDelegate) => true;
}
