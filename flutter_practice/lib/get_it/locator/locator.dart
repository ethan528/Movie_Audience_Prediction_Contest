import 'package:flutter_practice/get_it/service/album_service.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<AlbumService>(() => AlbumServiceImplementation());
}
