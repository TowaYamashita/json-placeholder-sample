import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_placeholder_sample/shared/exception/recoverable_exception.dart';
import 'package:json_placeholder_sample/users/provider/users_provider.dart';
import 'package:json_placeholder_sample/users/widget/user_card.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(usersProvider, (previous, next) {
      if (!next.hasError) {
        return;
      }

      final error = next.asError!.error;
      showDialog(
        context: context,
        builder: (_) {
          if (error is RecoverableException) {
            return AlertDialog(
              title: const Text('通信に失敗しました'),
              content: Text(error.message),
              actions: [
                TextButton(
                  child: const Text('閉じる'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }

          return AlertDialog(
              title: const Text('不明なエラーが発生しました'),
              content: const Text('お手数をおかけして申し訳ありません。開発者へ連絡してください。'),
              actions: [
                TextButton(
                  child: const Text('閉じる'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
        },
      );
    });

    const padding = EdgeInsets.all(8.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('users'),
      ),
      body: Padding(
        padding: padding,
        child: ref.watch(usersProvider).when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
          error: (_, __) {
            return const SizedBox.shrink();
          },
          data: (data) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (ctx, index) {
                    final d = data.elementAt(index);
                    return UserCard(data: d);
                  },
                  itemCount: data.length,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
