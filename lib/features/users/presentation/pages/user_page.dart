import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import ' .. /../../../../../../core/constants/key_helper.dart';
import '../provider/user_provider.dart';
import '../widgets/user_item.dart';

class UserPage extends ConsumerStatefulWidget {
  static const String route = "user";
  const UserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(usersProvider).getUsers();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero, () {
          ref.read(usersProvider).getUsers();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: NestedScrollView(
          key: userListKey,
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                title: const Text("Users"),
                expandedHeight: size.height / 2 - 40,
                automaticallyImplyLeading: true,
                primary: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Image.asset(
                        "assets/background.png",
                        height: size.height / 2,
                        fit: BoxFit.cover,
                        width: size.width,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final activeUsers = ref.watch(usersProvider).activeUsers;

                      return activeUsers.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Active",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: activeUsers.length,
                                  itemBuilder: (context, index) {
                                    final user = activeUsers[index];
                                    return UserItem(
                                      key: ValueKey(user.id),
                                      user: user,
                                      isFirst: index == 0,
                                      isLast: index == activeUsers.length - 1,
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 5),
                  Consumer(
                    builder: (context, ref, child) {
                      final inActiveUsers =
                          ref.watch(usersProvider).inActiveUser;
                      return inActiveUsers.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Inactive",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: inActiveUsers.length,
                                  itemBuilder: (context, index) {
                                    final user = inActiveUsers[index];
                                    return UserItem(
                                      key: ValueKey(user.id),
                                      user: user,
                                      isFirst: index == 0,
                                      isLast: index == inActiveUsers.length - 1,
                                    );
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(usersProvider).isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
