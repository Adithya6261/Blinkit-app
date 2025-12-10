import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/categories_data.dart';
import '../data/products_data.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final categories = CategoriesData.categories.obs;
  final selectedCategoryIndex = 0.obs;

  final ScrollController categoryController = ScrollController();
  final ScrollController mainScrollController = ScrollController();

  final List<GlobalKey> contentKeys = [];

  final RxMap<int, List<ProductModel>> products = <int, List<ProductModel>>{}.obs;

  
  final selectedTabIndex = 0.obs;
  final isBottomNavVisible = true.obs;

  double _lastOffset = 0;
  final isLoading = true.obs;

  
  @override
  void onInit() {
    super.onInit();
    
    
    for (int i = 0; i < categories.length; i++) {
      contentKeys.add(GlobalKey());
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

  
  // HIDE/SHOW BOTTOM NAV
  
  void _onMainScroll() {
    final offset = mainScrollController.offset;

    if (offset > _lastOffset + 4) {
      if (isBottomNavVisible.value) isBottomNavVisible.value = false;
    } else if (offset < _lastOffset - 4) {
      if (!isBottomNavVisible.value) isBottomNavVisible.value = true;
    }

    _lastOffset = offset;
  }

  
  // CATEGORY SELECTION + SCROLL
  
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;

    const double itemWidth = 70;
    const double spacing = 10;

    double itemTotalWidth = itemWidth + spacing;
    final screenWidth = Get.width;

    
    double targetOffset = index * itemTotalWidth - (screenWidth - itemWidth) / 2;

    
    if (categoryController.hasClients) {
      final maxScroll = categoryController.position.maxScrollExtent;
      targetOffset = targetOffset.clamp(0.0, maxScroll);

      categoryController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
      );
    }

    // Scroll main content
    jumpToContent(index);
  }



  
  // SCROLL TO PRODUCT SECTION
 
  void jumpToContent(int index) {
    if (!mainScrollController.hasClients) return;

    final key = contentKeys[index];
    final context = key.currentContext;
    if (context == null) return;

    
    final box = context.findRenderObject() as RenderBox;

    
    final position = box.localToGlobal(Offset.zero).dy;

    // Height of pinned header (search + categories)
    const double pinnedHeight = 120;

    // Current scroll  
    final currentOffset = mainScrollController.offset;

    // Calculate final target 
    final targetOffset = currentOffset + position - pinnedHeight;

    
    mainScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }




  List<ProductModel> productsFor(int index) => products[index] ?? [];


  void selectTab(int index) => selectedTabIndex.value = index;
}
