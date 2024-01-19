import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/core/utils/pick_image.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/user_profile/controller/user_profile_controller.dart';
import 'package:food_app/features/user_profile/widget/custom_textfiled.dart';

class EditUserProfile extends ConsumerStatefulWidget {
  final String uid;
  const EditUserProfile({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserProfleState();
}

class _EditUserProfleState extends ConsumerState<EditUserProfile> {
  File? profilefile;
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
    numberController =
        TextEditingController(text: ref.read(userProvider)!.phoneNo);
    addressController =
        TextEditingController(text: ref.read(userProvider)!.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void selecteProfileImage() async {
    final result = await pickImage();
    if (result != null) {
      setState(() {
        profilefile = File(result.files.first.path!);
      });
    }
  }

  void update() {
    ref.read(userProfileControllerProvider.notifier).editProfile(
          profileFile: profilefile,
          name: nameController.text.trim(),
          phoneNumber: numberController.text.trim(),
          address: addressController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProfileControllerProvider);
    return ref.watch(getUserProvider(widget.uid)).when(
          data: (user) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Edit Profile",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => update(),
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                    ),
                  )
                ],
              ),
              body: isLoading == true
                  ? const Loader()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => selecteProfileImage(),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: profilefile != null
                                  ? Image.file(profilefile!)
                                  : user!.profilePic == null
                                      ? const Center(
                                          child:
                                              Icon(Icons.camera_alt_outlined),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 80,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: user.profilePic!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(child: CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                            ),
                          ),
                          CustomTextField(
                              controller: nameController, labelText: 'Name'),
                          CustomTextField(
                              controller: numberController,
                              labelText: 'Number'),
                          CustomTextField(
                              controller: addressController,
                              labelText: "Address"),
                        ],
                      ),
                    ),
            );
          },
          error: (error, errorStack) {
            return ErrorText(text: error.toString());
          },
          loading: () => const Loader(),
        );
  }
}
