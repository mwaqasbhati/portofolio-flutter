import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';
import 'di/register_module.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

