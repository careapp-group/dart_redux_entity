## [1.1.0]

- Adds new Request actions for Create / Update that allows you to specify a request payload type that is different to the entity. This is useful for APIs where, for example, the payload required to create an object is a subset of the entity that is created. For example:

  ```dart
  class RequestCreatePayload {
    String name;
  }
  class Entity {
    String id;
    String name;
  }

  final action = RequestCreateOneWith<Entity, RequestCreatePayload>(RequestCreatePayload()..name = 'Michael');
  ```

  The way to read this is _Request Create One_ `Entity` _with_ `RequestCreatePayload`

## [1.0.5]

- Fixes pubspec to have test in dev dependencies

## [1.0.4]

- Changes FailCreateOne.entity to be optional

## [1.0.3]

- Fixes a type bug where RemoteEntityState.fromJson() would fail.

## [1.0.2]

- Further reduce version requirement for `test` package to 1.16.0, the first null-safe version

## [1.0.1]

- Reduce version requirement for `test` package

## [1.0.0]

- Sound null safety

- ## [0.2.0]

- Implement LocalEntityReducer

## [0.1.1]

- Relax type for Deserializer, makes possible to store list entities

## [0.1.0]

- Add caching support for the RetrieveAll actions

## [0.0.1] - Initial Release

- Initial Release!
