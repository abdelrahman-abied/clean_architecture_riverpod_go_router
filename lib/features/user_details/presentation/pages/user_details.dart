import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../../features/user_details/presentation/provider/user_details.dart';
import '../../../../features/users/presentation/provider/user_provider.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../core/utils/hex_color.dart';
import '../../../users/data/models/user_model.dart';

class UserDetails extends ConsumerStatefulWidget {
  static const String route = "user_details";
  final Users user;
  const UserDetails({required this.user, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserDetailsState();
}

class _UserDetailsState extends ConsumerState<UserDetails> {
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final detailsRef = ref.watch(userDetailsProvider);
    return detailsRef.editMode
        ? editDetailsView(detailsRef)
        : detailsView(detailsRef);
  }

  Scaffold editDetailsView(UserDetailsProvider detailsRef) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userDetailsProvider).changeEditMode(false);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Align(
        alignment: const Alignment(0, -.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Stack(
                    children: [
                      Hero(
                        tag: widget.user.id,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            width: 110,
                            height: 105,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              widget.user.name?.substring(0, 2) ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: constraint.maxWidth - 40,
                        top: constraint.maxHeight - 40,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              widget.user.gender == Gender.male.toString()
                                  ? Icons.male_rounded
                                  : Icons.female_rounded,
                              size: 16,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     ref.read(userDetailsProvider).changeEditMode(true);
                  //   },
                  //   child: Text(
                  //     widget.user.name ?? "",
                  //   ),
                  // ),
                  SizedBox(
                    child: TextFormField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      validator: (String? s) {},
                      // hintText: widget.user.name,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.user.name,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(0),
                        hintStyle: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.user.gender ?? "",
                    style: TextStyle(
                      fontSize: 17,
                      color: HexColor("#A7A7A7"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#2E22F7"),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    ref.read(userDetailsProvider)
                      ..changeEditMode(false)
                      ..changeCurrentUser(
                        widget.user.copyWith(name: _nameController.text),
                      );

                    ref.read(usersProvider).updateUser(
                          widget.user.copyWith(name: _nameController.text),
                        );
                  } else {
                    ref.read(userDetailsProvider).changeEditMode(false);
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold detailsView(UserDetailsProvider detailsRef) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Align(
        alignment: const Alignment(0, -.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Stack(
                    children: [
                      Hero(
                        tag: widget.user.id,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            width: 110,
                            height: 105,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              widget.user.name?.substring(0, 2) ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: constraint.maxWidth - 40,
                        top: constraint.maxHeight - 40,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.male_rounded,
                              size: 16,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Column(
              // mainAxisAlignment: MainAxisAlignment.,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(userDetailsProvider).changeEditMode(true);
                  },
                  child: AutoSizeText(
                    ref.watch(userDetailsProvider).currentUser?.name ??
                        widget.user.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.user.gender ?? "",
                  style: TextStyle(
                    color: HexColor("#A7A7A7"),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            if (!detailsRef.editMode)
              SvgPicture.asset(
                Assets.vector,
                height: 120,
                width: 350,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero,
        () => ref.read(userDetailsProvider).changeEditMode(false));

    super.dispose();
  }
}
