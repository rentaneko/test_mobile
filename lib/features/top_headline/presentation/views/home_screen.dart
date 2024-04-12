import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietravel/features/search/views/search_screen.dart';
import '../../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(InitialHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is ErrorHomeState) {
            return Center(
              child: Text('${state.errorMsg}'),
            );
          }
          if (state is LoadingHomeState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is LoadedHomeState) {
            if (state.countries == []) {
              return const Center(child: Text('Empty'));
            }
            return Center(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CachedNetworkImage(
                                imageUrl: '${state.countries![index].imgUrl}',
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.hourglass_empty_outlined),
                                height: 120,
                                width: 300,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                state.countries![index].createdDate!
                                    .substring(0, 10),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${state.countries![index].title}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          '${state.countries![index].description}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: state.countries!.length,
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(SearchScreen.route()),
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
