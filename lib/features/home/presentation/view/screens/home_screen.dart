import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/presentation/view/widgets/image_item_widget.dart';
import 'package:news_app/features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:news_app/features/home/presentation/view_model/home_cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => serviceLocator<HomeCubit>()..fetchNews(),
      child: Scaffold(
        backgroundColor: Color(0xff202020),
        appBar: AppBar(
          backgroundColor: Color(0xff1877F2),
          title: Text(
            'News App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state) {
              case HomeInitial():
                return SizedBox.shrink();
              case HomeLoading():
                return Center(child: CircularProgressIndicator());
              case HomeSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ImageItemWidget(
                      image: state.articles[index].urlToImage,
                      title: state.articles[index].title,
                      onTap: () {},
                    );
                  },
                  itemCount: state.articles.length,
                );
              case HomeError():
                return Center(child: Text(state.messageError));
            }
          },
        ),
      ),
    );
  }
}

const String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
