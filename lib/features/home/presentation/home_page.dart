import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/features/home/presentation/pages/single_product.dart';

import 'bloc/product_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(FetchProducts());
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FakeStore'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is ProductLoaded) {
            final list = state.products;

            return GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(FetchProducts());
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) =>
                                SingleProductPage(
                                  product: list[index],
                                )));
                      },
                      child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: double.maxFinite,
                                height: 80,
                                child: Image.network(list[index].image),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                list[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                list[index].description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'price : \$${list[index].price.toStringAsFixed(
                                    2)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                      )
                  );
                }
            );
          } else if (state is ProductError) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
  @override
  void dispose() {
    productBloc.close();
    super.dispose();
  }
}
