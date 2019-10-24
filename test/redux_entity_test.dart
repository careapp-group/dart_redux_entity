import './src/unsorted_entity_state_adapter_test.dart'
    as unsorted_entity_state_adapter_tests;

import './src/remote_entity_reducer_test.dart' as remote_entity_reducer_tests;

import './src/remote_entity_facade_test.dart' as remote_entity_facade_tests;

void main() {
  unsorted_entity_state_adapter_tests.main();
  remote_entity_reducer_tests.main();
  remote_entity_facade_tests.main();
}
