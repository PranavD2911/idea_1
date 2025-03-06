import 'dart:async';
import 'package:flutter/material.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_request_model.dart';
import 'package:idea_1/modules/gemini/presentation/bloc/gemini_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'conversation_provider.dart';

class GeminiChatWidget extends StatelessWidget {
  GeminiChatWidget({Key? key}) : super(key: key);

  final GeminiBloc geminiBloc = GeminiBloc();

  // @override
  void sendMessage(ConversationProvider provider) {
    if (geminiBloc.chatController.text.isNotEmpty) {
      provider.addUserMessage(geminiBloc.chatController.text);
      geminiBloc.add(
        GeminiRequestEvent(
          geminiRequestModel: GeminiRequestModel(
            contents: [
              Content(parts: [Part(text: geminiBloc.chatController.text)]),
            ],
          ),
        ),
      );
      geminiBloc.chatController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    // Post-frame callback ensures that the scroll occurs after the widget rebuilds.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (geminiBloc.scrollController.hasClients) {
        geminiBloc.scrollController.animateTo(
          geminiBloc.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chat Widget'),
        actions: [
          InkWell(
            onTap: () {
              Provider.of<ConversationProvider>(context, listen: false)
                  .clearConversation();
            },
            child: const Icon(
              Icons.delete_outline_rounded,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Chat history container.
            Expanded(
              child: Consumer<ConversationProvider>(
                builder: (context, conversationProvider, child) {
                  return BlocListener<GeminiBloc, GeminiState>(
                    bloc: geminiBloc,
                    listener: (context, state) {
                      if (state is GeminiSuccessState) {
                        conversationProvider.addGeminiMessage(
                          state.geminiAttributeModel.candidates?[0].content
                                  ?.parts?[0].text ??
                              "",
                        );
                        _scrollToBottom();
                      }
                    },
                    child: BlocBuilder<GeminiBloc, GeminiState>(
                      bloc: geminiBloc,
                      builder: (context, state) {
                        final isLoading = state is GeminiLoadingState;
                        final totalItems =
                            conversationProvider.conversation.length +
                                (isLoading ? 1 : 0);
                        return ListView.builder(
                          controller: geminiBloc.scrollController,
                          itemCount: totalItems,
                          itemBuilder: (context, index) {
                            if (index <
                                conversationProvider.conversation.length) {
                              final messageMap =
                                  conversationProvider.conversation[index];
                              final isUser = messageMap.containsKey("user");
                              final message = isUser
                                  ? messageMap["user"]!
                                  : messageMap["gemini"]!;
                              return Align(
                                alignment: isUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: isUser ? Colors.blue : Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(5),
                                      topRight: const Radius.circular(5),
                                      bottomLeft: isUser
                                          ? const Radius.circular(5)
                                          : Radius.zero,
                                      bottomRight: isUser
                                          ? Radius.zero
                                          : const Radius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    message,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              // Show typing indicator if loading.
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: const TypingIndicator(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Input field and send button.
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: geminiBloc.chatFormKey,
                    child: TextFormField(
                      controller: geminiBloc.chatController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Enter your question.',
                        label: Text('Message'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a question!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (geminiBloc.chatFormKey.currentState!.validate()) {
                          final provider = Provider.of<ConversationProvider>(
                              context,
                              listen: false);
                          sendMessage(provider);
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (geminiBloc.chatFormKey.currentState!.validate()) {
                      final provider = Provider.of<ConversationProvider>(
                          context,
                          listen: false);
                      sendMessage(provider);
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple TypingIndicator widget that displays animated three dots.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  String dots = "";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        if (dots.length >= 3) {
          dots = "";
        } else {
          dots += ".";
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      dots,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
