import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../user_details/presentation/pages/user_details.dart';
import '../../../user_details/presentation/provider/user_details.dart';
import '../../data/models/user_model.dart';

class UserItem extends ConsumerWidget {
  final Users user;
  final bool isFirst;
  final bool isLast;
  const UserItem({
    super.key,
    required this.user,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(userDetailsProvider).changeCurrentUser(user);
        GoRouter.of(context).pushNamed(UserDetails.route, extra: user);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 2, top: 2),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: isFirst
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : isLast
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  : null,
        ),
        child: Row(
          children: [
            Hero(
              tag: user.id,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: Text(user.name!.substring(0, 1)),
                ),
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.status ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      user.gender ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
