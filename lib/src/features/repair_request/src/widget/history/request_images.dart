import 'package:ui_kit/ui.dart';
import '../../../../../app/model/application_config.dart';
import '../../model/problem.dart';

class RequestImages extends StatelessWidget {
  const RequestImages({super.key, required this.problems});

  final List<FullProblem> problems;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const .only(top: 32.0),
      sliver: SliverToBoxAdapter(
        child: UiCarousel(
          itemCount: problems.length,
          itemBuilder: (context, index) {
            final problem = problems[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: Theme.of(context).appStyle.borderRadius,
                image: DecorationImage(
                  image: NetworkImage(
                    '${Config.storageBaseUrl}${Config.problemsBucket}${problem.photoPath}',
                  ),
                  fit: .cover,
                ),
              ),
            );
          },
          constraints: const BoxConstraints(maxHeight: 220.0),
        ),
      ),
    );
  }
}
