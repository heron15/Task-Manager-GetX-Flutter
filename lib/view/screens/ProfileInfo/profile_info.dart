import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_route.dart';
import 'package:task_manager/utils/asset_paths.dart';
import 'package:task_manager/view/controllers/auth_controller.dart';
import 'package:task_manager/view/screens/ProfileInfo/inner/details_view_widget.dart';
import 'package:task_manager/view/widgets/background_widget.dart';
import 'package:task_manager/view/widgets/network_cached_image.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Info'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.updateProfileScreen);
            },
            icon: const Padding(
              padding: EdgeInsets.only(
                right: 15,
              ),
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: NetworkCachedImage(
                      url: 'url',
                      errorIconRadius: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AuthController.userData?.fullName ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 15),
                  detailsViewWidget(
                    header: 'Email:',
                    info: AuthController.userData?.email ?? '',
                  ),
                  const SizedBox(height: 7),
                  detailsViewWidget(
                    header: 'Number:',
                    info: AuthController.userData?.mobile ?? '',
                  ),
                  const SizedBox(height: 7),
                  const detailsViewWidget(
                    header: 'Password:',
                    info: '**********',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
