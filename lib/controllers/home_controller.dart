import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../data/categories_data.dart';
import '../data/products_data.dart';
import '../models/product_model.dart';
import '../themes/app_theme.dart';

enum HomeTab { home, orderAgain, categories, print }

class HomeController extends GetxController {
  final categories = CategoriesData.categories.obs;
  final selectedCategoryIndex = 0.obs;

  final ScrollController categoryController = ScrollController();
  final ScrollController mainScrollController = ScrollController();

  final List<GlobalKey> contentKeys = [];
  final List<GlobalKey> categoryKeys = [];

  final RxMap<int, List<ProductModel>> products = <int, List<ProductModel>>{}.obs;

  final selectedTabIndex = 0.obs;
  final currentTab = HomeTab.home.obs;
  final isBottomNavVisible = true.obs;

  double _lastOffset = 0;

  @override
  void onInit() {
    super.onInit();

    for (int i = 0; i < categories.length; i++) {
      contentKeys.add(GlobalKey());
      categoryKeys.add(GlobalKey());
      products[i] = ProductsData.productsForCategory(i);
    }

    mainScrollController.addListener(_onMainScroll);
  }

  @override
  void onClose() {
    mainScrollController.dispose();
    categoryController.dispose();
    super.onClose();
  }

  void _onMainScroll() {
    final offset = mainScrollController.offset;

    if (offset > _lastOffset + 4) {
      if (isBottomNavVisible.value) {
        isBottomNavVisible.value = false;
      }
    } else if (offset < _lastOffset - 4) {
      if (!isBottomNavVisible.value) {
        isBottomNavVisible.value = true;
      }
    }

    _lastOffset = offset;
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;

    if (!categoryController.hasClients) return;

    final ctx = categoryKeys[index].currentContext;
    if (ctx == null) return;

    final RenderBox itemBox = ctx.findRenderObject() as RenderBox;
    final RenderBox listBox = categoryController.position.context.storageContext.findRenderObject() as RenderBox;

    final Offset itemPos = itemBox.localToGlobal(Offset.zero, ancestor: listBox);

    final double itemCenter = itemPos.dx + itemBox.size.width / 2;
    final double viewportCenter = listBox.size.width / 2;

    double targetOffset = categoryController.offset + itemCenter - viewportCenter;

    final max = categoryController.position.maxScrollExtent;
    final min = categoryController.position.minScrollExtent;

    targetOffset = targetOffset.clamp(min, max);

    categoryController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );

    jumpToContent(index);
  }

 void jumpToContent(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = contentKeys[index].currentContext;

      if (context == null) {
        // Force approximate scroll first so Flutter builds the item
        final estimatedOffset = index * 380.0; // avg section height
        mainScrollController.jumpTo(
          estimatedOffset.clamp(
            mainScrollController.position.minScrollExtent,
            mainScrollController.position.maxScrollExtent,
          ),
        );

        // Retry after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final retryContext = contentKeys[index].currentContext;
          if (retryContext != null) {
            Scrollable.ensureVisible(
              retryContext,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              alignment: 0.0,
            );
          }
        });

        return;
      }

      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        alignment: 0.0,
      );
    });
  }

  List<ProductModel> productsFor(int index) => products[index] ?? [];

  void selectTab(int index) {
    selectedTabIndex.value = index;
    currentTab.value = HomeTab.values[index];
  }

  Color get headerColor {
    switch (currentTab.value) {
      case HomeTab.orderAgain:
        return const Color(0xFFFFE8ED);
      case HomeTab.categories:
        return const Color(0xFFE3F2FD);
      case HomeTab.print:
        return const Color(0xFFE8F5E9);
      case HomeTab.home:
      default:
        return AppTheme.blinkitYellow;
    }
  }

  Color get sectionBgColor {
    switch (currentTab.value) {
      case HomeTab.orderAgain:
        return const Color(0xFFFFF1F5);
      case HomeTab.categories:
        return const Color(0xFFF5FAFF);
      case HomeTab.print:
        return const Color(0xFFF1FFF4);
      case HomeTab.home:
      default:
        return Colors.white;
    }
  }
}
