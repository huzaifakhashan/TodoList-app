import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Screens/trash_page.dart';
import 'package:to_do_list/providers/task_providers.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProviders>();

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "قائمتي",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),

          SwitchListTile(
            title: Text("الوضع الليلي"),
            value: provider.isDarkMode,
            onChanged: (value) {
              provider.toggleTheme();
            },
            secondary: Icon(Icons.dark_mode),
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text("سلة المحذوفات"),
            trailing:
                provider.trash.isEmpty ? null : Text("${provider.trash.length}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TrashPage()),
              );
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text("حذف جميع المهام"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("تأكيد"),
                  content: Text("سيتم نقل كل المهام إلى سلة المحذوفات. هل تريد المتابعة؟"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("إلغاء"),
                    ),
                    TextButton(
                      onPressed: () {
                        provider.clearAllTasks();
                        Navigator.pop(context);
                      },
                      child: Text("حذف"),
                    ),
                  ],
                ),
              );
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("حول التطبيق"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "تطبيق ادارة المهام",
                applicationVersion: "1.0.0",
                children: [Text("تطبيق بسيط لإدارة المهام باستخدام Flutter.")],
              );
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.people),
            title: Text("من نحن"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("من نحن"),
                    content: Text(
                      "أنا مطور فلاتر وأقوم بتصميم تطبيقات الهواتف \n"
                      "رابط صفحتي على غيت هاب \n"
                      "https://github.com/huzaifakhashan",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("إغلاق"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("تواصل معنا"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("تواصل معنا"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("يمكنك التواصل معنا عبر:"),
                        SizedBox(height: 10),
                        Text(":📧 البريد الإلكتروني "),
                        Text("Huzaifa.Khashan@gmail.com"),
                        Text(":📱 الهاتف "),
                        Text("+963981787496")
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("إغلاق"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
