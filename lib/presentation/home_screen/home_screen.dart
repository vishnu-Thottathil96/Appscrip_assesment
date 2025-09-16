import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/application/search_query_provider.dart';
import 'package:flutter_template/application/show_search_provider.dart';
import 'package:flutter_template/application/users_provider.dart';
import 'package:flutter_template/core/config/routes_onfig/app_screens.dart';
import 'package:flutter_template/core/constants/app_colors/app_colors.dart';
import 'package:flutter_template/core/util/responsive_util.dart';
import 'package:flutter_template/presentation/home_screen/widgets/home_shimmer.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSearch = ref.watch(showSearchProvider);
    final usersAsync = ref.watch(usersProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    void toggleSearch() {
      ref.read(showSearchProvider.notifier).update((state) => !state);
      ref.read(searchQueryProvider.notifier).state = "";
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.gradientStart,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Users",
          style: TextStyle(color: AppColors.surface, fontSize: 20.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(
              showSearch ? Icons.close : Icons.search,
              color: AppColors.surface,
            ),
            onPressed: toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          if (showSearch)
            Container(
              height: ResponsiveHelper.scaleHeight(context, 50),
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white20,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white30, width: 1.2),
              ),
              child: TextField(
                onChanged:
                    (value) =>
                        ref.read(searchQueryProvider.notifier).state = value,
                style: const TextStyle(fontSize: 16, color: AppColors.surface),
                decoration: const InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                ),
              ),
            ),
          Expanded(
            child: usersAsync.when(
              loading:
                  () => ListView.builder(
                    itemBuilder: (context, index) => const HomeShimmer(),
                    itemCount: 10,
                  ),
              error:
                  (_, __) => const Center(child: Text("Failed to load users")),
              data: (users) {
                final filteredUsers =
                    users.where((u) {
                      final query = searchQuery.toLowerCase();
                      return (u.name != null
                          ? u.name!.toLowerCase().contains(query) ||
                              u.email!.toLowerCase().contains(query)
                          : false);
                    }).toList();

                if (filteredUsers.isEmpty) {
                  return Center(
                    child: GestureDetector(
                      onTap: () async {
                        ref.invalidate(usersProvider);
                      },
                      child: Text(
                        "No users found Retry",
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.gradientStart,
                  backgroundColor: AppColors.background,
                  onRefresh: () async {
                    ref.invalidate(usersProvider);
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return Padding(
                        padding: ResponsiveHelper.scalePadding(
                          context,
                          vertical: 14,
                          horizontal: 10,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: GestureDetector(
                              onTap: () {
                                context.push(
                                  AppScreens.UserDetailsPage.path,
                                  extra: user,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.white20,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.white30,
                                    width: 1.2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: AppColors.gradientStart,
                                      child: Text(
                                        user.name != null
                                            ? user.name![0].toUpperCase()
                                            : "?",
                                        style: const TextStyle(
                                          color: AppColors.surface,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.name ?? "Unknown",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.surface,
                                            ),
                                          ),
                                          Text(
                                            user.email ?? "No email",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
