import 'package:clock_loader/clock_loader.dart';
import 'package:flutter/material.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_request_model.dart';
import 'package:idea_1/modules/gemini/presentation/bloc/gemini_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiChatWidget extends StatelessWidget {
  GeminiChatWidget({super.key});
  final geminiBloc = GeminiBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Chat Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 160,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: BlocProvider(
                  create: (context) => geminiBloc,
                  child: BlocConsumer<GeminiBloc, GeminiState>(
                    listener: (context, state) {
                      if (state is GeminiSuccessState) {
                        geminiBloc.chatController.clear();
                      }
                    },
                    builder: (context, state) {
                      if (state is GeminiLoadingState) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 160,
                          child: ClockLoader(
                            clockLoaderModel: ClockLoaderModel(
                              shapeOfParticles: ShapeOfParticlesEnum.circle,
                              mainHandleColor: Colors.white,
                              particlesColor: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is GeminiSuccessState) {
                        if (state.geminiAttributeModel.candidates?.isEmpty ??
                            true) {
                          return const Text('No responses available');
                        }

                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 160,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                state.geminiAttributeModel.candidates?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              final candidate =
                                  state.geminiAttributeModel.candidates?[index];
                              final contentParts = candidate?.content?.parts;

                              if (contentParts == null ||
                                  contentParts.isEmpty) {
                                return const Text('No content available');
                              }

                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  contentParts[0].text ?? "",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is GeminiFailureState) {
                        return const Text('Failed to fetch data');
                      } else {
                        return const Text('Start asking questions');
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                geminiBloc.add(GeminiRequestEvent(
                    geminiRequestModel: GeminiRequestModel(contents: [
                  Content(parts: [Part(text: geminiBloc.chatController.text)])
                ])));
              },
              controller: geminiBloc.chatController,
              decoration: InputDecoration(
                hintText: 'Enter your message',
                label: const Text('Message'),
                suffixIcon: InkWell(
                    onTap: () {
                      geminiBloc.add(GeminiRequestEvent(
                          geminiRequestModel: GeminiRequestModel(contents: [
                        Content(
                            parts: [Part(text: geminiBloc.chatController.text)])
                      ])));
                    },
                    child: const Icon(Icons.send)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
