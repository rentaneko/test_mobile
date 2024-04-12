import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const named = '/search';
  static route() => MaterialPageRoute(builder: (_) => const SearchScreen());

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchBloc = SearchBloc();
  TextEditingController keyword = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    keyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: keyword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            hintText: 'Vietravel, Apple, Bitcoin',
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            suffixIcon: const Icon(Icons.search),
          ),
          onEditingComplete: () {
            if (keyword.text.isEmpty) {
              return;
            } else {
              searchBloc.add(SearchByNameEvent(name: keyword.text));
            }
            print('COMPLTEEEEEEEEEE');
          },
          onFieldSubmitted: (value) {
            if (keyword.text.isEmpty) {
              return;
            } else {
              searchBloc.add(SearchByNameEvent(name: keyword.text));
            }
            print('SUBMITTTTTTTTTTTT');
          },
          onSaved: (value) {
            if (keyword.text.isEmpty) {
              return;
            } else {
              searchBloc.add(SearchByNameEvent(name: keyword.text));
            }
            print('SAVEEEEEEEEEEE');
          },
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: searchBloc,
        buildWhen: (previous, current) => current is! SearchEvent,
        listenWhen: (previous, current) => current is SearchEventAction,
        listener: (context, state) {
          if (state is SearchButtonClickedEvent) {
            searchBloc.add(SearchByNameEvent(name: keyword.text));
          }
        },
        builder: (context, state) {
          if (state is LoadingSearchState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is ErrorSearchState) {
            return Center(child: Text(state.errorMsg));
          }
          if (state is SuccesSearchState) {
            return ListView.separated(
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
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.countries!.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
