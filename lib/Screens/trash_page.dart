import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/task_providers.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  void _confirm(
    BuildContext context, {
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("تأكيد"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(dialogContext);
            },
            child: const Text("تأكيد"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProviders>();
    final trash = provider.trash;

    return Scaffold(
      appBar: AppBar(
        title: const Text("سلة المحذوفات"),
        backgroundColor: Colors.blue,
        actions: [
          if (trash.isNotEmpty) ...[
            IconButton(
              tooltip: "استعادة جميع المهام",
              icon: const Icon(Icons.restore_from_trash),
              onPressed: () => _confirm(
                context,
                message: "هل تريد استعادة جميع المهام؟",
                onConfirm: provider.restoreAll,
              ),
            ),
            IconButton(
              tooltip: "إفراغ السلة",
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _confirm(
                context,
                message: "سيتم حذف كل المهام نهائياً. هل أنت متأكد؟",
                onConfirm: provider.emptyTrash,
              ),
            ),
          ],
        ],
      ),
      body: trash.isEmpty
          ? const Center(child: Text("السلة فارغة"))
          : ListView.builder(
              itemCount: trash.length,
              itemBuilder: (context, index) {
                final task = trash[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle:
                      task.description.isEmpty ? null : Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: "استرجاع",
                        icon: const Icon(Icons.restore, color: Colors.green),
                        onPressed: () => provider.restoreTask(task),
                      ),
                      IconButton(
                        tooltip: "حذف نهائي",
                        icon: const Icon(Icons.delete_forever,
                            color: Colors.red),
                        onPressed: () => provider.deleteForever(task),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
