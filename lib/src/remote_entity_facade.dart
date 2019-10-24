import 'package:redux/redux.dart';
import './remote_entity_actions.dart';

class RemoteEntityFacade<T> {
  RemoteEntityFacade(this.store);

  // create
  createOne(T entity) {
    store.dispatch(RequestCreateOne<T>(entity));
  }

  createMany(List<T> entities) {
    store.dispatch(RequestCreateMany<T>(entities));
  }

  // retrieve
  requestOne(String id) {
    store.dispatch(RequestRetrieveOne<T>(id));
  }

  requestMany(List<String> ids) {
    store.dispatch(RequestRetrieveMany<T>(ids));
  }

  requestAll() {
    store.dispatch(RequestRetrieveAll<T>());
  }

  // update
  updateOne(T updates) {
    store.dispatch(RequestUpdateOne<T>(updates));
  }

  updateMany(List<T> updates) {
    store.dispatch(RequestUpdateMany<T>(updates));
  }

  // delete
  deleteOne(String id) {
    store.dispatch(RequestDeleteOne<T>(id));
  }

  deleteMany(List<String> ids) {
    store.dispatch(RequestDeleteMany<T>(ids));
  }

  final Store store;
}
