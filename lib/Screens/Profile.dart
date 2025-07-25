import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/login_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'profile.title'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: Text(
                      user?.email?.substring(0, 1).toUpperCase() ?? 'N',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // User Email
                  Text(
                    user?.email ?? 'Not signed in',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Options
            _buildSection(
              title: 'profile.account'.tr(),
              children: [
                _buildOption(
                  icon: Icons.person,
                  title: 'profile.account'.tr(),
                  onTap: () {},
                ),
                _buildOption(
                  icon: Icons.settings,
                  title: 'profile.settings'.tr(),
                  onTap: () {},
                ),
                _buildOption(
                  icon: Icons.help,
                  title: 'profile.help'.tr(),
                  onTap: () {},
                ),
              ],
            ),

            _buildSection(
              title: 'profile.settings'.tr(),
              children: [
                _buildOption(
                  icon: Icons.language,
                  title: 'profile.language'.tr(),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.black,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'profile.language'.tr(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              title: const Text('English', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('en') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('en'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('हिंदी', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('hi') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('hi'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('தமிழ்', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('ta') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('ta'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('తెలుగు', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('te') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('te'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('ಕನ್ನಡ', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('kn') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('kn'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('മലയാളം', style: TextStyle(color: Colors.white)),
                              trailing: context.locale == const Locale('ml') ? const Icon(Icons.check, color: Colors.red) : null,
                              onTap: () {
                                context.setLocale(const Locale('ml'));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                _buildOption(
                  icon: Icons.notifications,
                  title: 'profile.notifications'.tr(),
                  onTap: () {},
                ),
                _buildOption(
                  icon: Icons.download,
                  title: 'profile.downloads'.tr(),
                  onTap: () {},
                ),
              ],
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    context.read<LoginCubit>().logout();
                    context.go('/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'profile.sign_out'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
    );
  }
} 