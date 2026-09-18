import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/task_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Task survives a json round trip', () {
    final task =
        Task(id: "1", title: "مهمة", description: "وصف", completed: true);
    final copy = Task.fromJson(task.toJson());

    expect(copy.id, task.id);
    expect(copy.title, task.title);
    expect(copy.description, "وصف");
    expect(copy.completed, true);
  });

  test('Old saved tasks without a description still load', () {
    final task = Task.fromJson({'id': '1', 'title': 'قديمة', 'completed': false});
    expect(task.description, '');
  });

  test('Deleted tasks go to the trash and can be restored', () {
    final provider = TaskProviders();
    final task = provider.tasks.first;

    provider.removeTask(task);
    expect(provider.tasks.contains(task), false);
    expect(provider.trash.contains(task), true);

    provider.restoreTask(task);
    expect(provider.tasks.contains(task), true);
    expect(provider.trash.isEmpty, true);
  });

  test('Editing a task updates title and description', () {
    final provider = TaskProviders();
    final task = provider.tasks.first;

    provider.updateTask(task, "جديد", "تفاصيل");
    expect(task.title, "جديد");
    expect(task.description, "تفاصيل");
  });
}
