import 'package:form_without_connection/app/app_preferences.dart';
import 'package:form_without_connection/data/network/apis/app_api.dart';
import 'package:form_without_connection/data/network/dio_factory.dart';
import 'package:form_without_connection/data/network/network_info/network_info.dart';
import 'package:form_without_connection/data/remote_data_source/remote_data_source.dart';
import 'package:form_without_connection/data/remote_data_source/remote_data_source_impl.dart';
import 'package:form_without_connection/data/repository/repository.dart';
import 'package:form_without_connection/data/repository/repository_impl.dart';
import 'package:form_without_connection/domain/use_cases/register_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Register your dependencies here
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared preferences instance
  instance.registerLazySingleton(() => sharedPrefs);

  // App preferences
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  // dio factory
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );

  // App service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppApi>(
    () => AppApi(dio),
  );

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance()),
  );

  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance(),
      instance(),
    ),
  );

  // register use case
  instance.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(instance()),
  );

  instance.registerLazySingleton<ImagePicker>(
    () => ImagePicker(),
  );
}

Future<void> resetAllModules() async {
  instance.reset(dispose: false);
  await initAppModule();
}
