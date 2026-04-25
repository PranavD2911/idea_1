import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/view_3d_bloc.dart';
import '../widgets/universal_3d_viewer.dart';

class View3DPage extends StatelessWidget {
  const View3DPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => View3DBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('View 3D Model'),
        ),
        body: BlocBuilder<View3DBloc, View3DState>(
          builder: (context, state) {
            if (state is View3DInitial) {
              return _buildEmptyState(context);
            } else if (state is View3DLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is View3DLoaded) {
              return _buildLoadedState(context, state.filePath);
            } else if (state is View3DError) {
              return _buildErrorState(context, state.errorMessage);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.view_in_ar,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No 3D Model Selected',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<View3DBloc>().add(PickModelEvent());
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload 3D Model'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, String filePath) {
    debugPrint('Rendering 3D model from: $filePath');
    return Column(
      children: [
        SizedBox(
          height: 500,
          width: double.infinity,
          child: Universal3DViewer(src: filePath),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<View3DBloc>().add(PickModelEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Choose Another Model'),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<View3DBloc>().add(PickModelEvent());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
