import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../cubit/chat/chat_cubit.dart';
import '../cubit/chat/chat_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  bool showLoading = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          centerTitle: true,
          title: SizedBox(
            width: 250,
            height: 80,
            child: Image.asset('assets/images/appTitle.png'),
          )),
      backgroundColor: const Color(0xffE2BFB3),
      body: BlocBuilder<ChatCubit, ChatSuccessState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: state.messages.isEmpty
                      ? Center(
                          child: Lottie.network(
                          "https://lottie.host/41ff6819-d84c-49cf-996a-488ad8c8e121/mAAhEtu5Ms.json",
                          height: MediaQuery.of(context).size.height * 0.50,
                        ))
                      : ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          controller: _scrollController,
                          itemCount: state.messages.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.transparent,
                          ),
                          itemBuilder: (context, index) {
                            final message = state.messages[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment: message.role == 'user'
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (message.role == 'model')
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(153, 188, 133, 1),
                                      child: Icon(
                                        Icons.android,
                                        color: Colors.white,
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: message.role == 'user'
                                            ? Colors.blue.shade50
                                            : Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message.parts.first.text,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: message.role == 'user'
                                                  ? Colors.black
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (message.role == 'user')
                                    const CircleAvatar(
                                      backgroundColor: Color(0xffA87676),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
              if (state.isLoading)
                Lottie.network(
                  "https://lottie.host/0b0194ea-1e78-47c5-9c2c-c030a8151ec0/Pg10F4qMTI.json",
                  height: 100,
                  width: 100,
                ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _controller,
                          autofocus: false,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Your Question write here",
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            suffixIcon: CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  const Color.fromRGBO(225, 240, 218, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: InkWell(
                                  onTap: () {
                                    if (_controller.text.isNotEmpty) {
                                      final text = _controller.text;
                                      _controller.text = '';
                                      BlocProvider.of<ChatCubit>(context)
                                          .getAnswer(text);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          showCloseIcon: true,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          content: const Text(
                                              'Please Write Your Question in this filed'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xffA87676),
                                    child: Icon(
                                      Icons.search_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
