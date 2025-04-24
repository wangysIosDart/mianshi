import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleFutureProvider = FutureProvider.autoDispose((ref) async =>
    await Dio()
        .get('https://www.wanandroid.com/article/list/0/json')
        .then((res) => res.data));

final articleStreamProvider = StreamProvider.autoDispose((ref) async* {
  final response =
      await Dio().get('https://www.wanandroid.com/article/list/0/json');
  yield response.data;
});

class RiverPodPage extends StatelessWidget {
  const RiverPodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Demo')),
        body: const Row(
          children: [
            Expanded(child: FutureProviderExample()),
            Expanded(child: StreamProviderExample()),
          ],
        ),
      ),
    );
  }
}

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsyncValue = ref.watch(articleFutureProvider);

    return Center(
        child: SingleChildScrollView(
            child: responseAsyncValue.when(
      data: (data) => Text('Data: $data'),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    )));
  }
}

class StreamProviderExample extends ConsumerWidget {
  const StreamProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseStream = ref.watch(articleStreamProvider);
    return Center(
        child: SingleChildScrollView(
            child: responseStream.when(
      data: (data) => Text('Data: $data'),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    )));
  }
}
