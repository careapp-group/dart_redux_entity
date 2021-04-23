# redux_entity

[![Build Status](https://travis-ci.org/careapp-inc/dart_redux_entity.svg?branch=master)](https://travis-ci.org/careapp-inc/dart_redux_entity)
[![Coverage Status](https://coveralls.io/repos/github/careapp-inc/dart_redux_entity/badge.svg?branch=master)](https://coveralls.io/github/careapp-inc/dart_redux_entity?branch=master)

Tools for maintaining collections of objects in Redux stores. Aiming to be a close match to Angular's excellent [@ngrx/entity](https://github.com/ngrx/platform/tree/master/modules/entity), with changes made mostly around the differences between Typescript and Dart.

## Testing Utilities

If you are creating your own reducers based on RemoteEntityReducer, it can be a lot of work to get good test coverage. You not only need to test the reducer against your own actions, but also ensure the existing functionality continues to work.

To make things easier, I suggest copying [Remote Entity Reducer Tester](test/src/remote_entity_reducer_tester.dart) into your test suite. Use the tester to test that the existing functionality continues to work as you add your custom actions.

## Contributing

Contributions are welcome! However,

- This project aims to be production-ready. PRs without accompanying tests will not be merged
- We want to promote a healthy, friendly, and inclusive development community. As such, have a read and agree to abide by the [Code of Conduct](https://github.com/MichaelMarner/redux_entity/blob/master/CODE_OF_CONDUCT.md)
