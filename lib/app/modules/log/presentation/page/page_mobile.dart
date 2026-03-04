import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_circular_progress_indicator.dart';
import 'package:appweb/app/modules/log/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/log/presentation/bloc/event.dart';
import 'package:appweb/app/modules/log/presentation/bloc/state.dart';
import 'package:appweb/app/modules/log/presentation/content/content_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PageMobile extends StatefulWidget {
  const PageMobile({super.key});

  @override
  State<PageMobile> createState() => _PageMobileState();
}

class _PageMobileState extends State<PageMobile> {
  late final LogBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = Modular.get<LogBloc>();
    bloc.add(GetLogEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogBloc, LogState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is ErrorState) {
          CustomToast.showToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is LoadedState) {
          return ContentLog(listLog: state.list);
        }
        return const ContentLog(listLog: []);
      },
    );
  }
}
