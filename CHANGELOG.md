# CHANGELOG

## [1.1.0] - 2023-09-04

[1.1.0]: https://github.com/mpowr-it/node-red-sentry-node/compare/v1.0.0...v1.1.0

* Rename node type to `sentry-wrapper`
* Add example flow
* Set minimum node version (>=16.0.0)

## [1.0.0] - 2023-09-04

[1.0.0]: https://github.com/mpowr-it/node-red-sentry-node/tree/v1.0.0

This is an initial release, based on the [node-red-contrib-sentrynode](https://github.com/ibraheem-ghazi/node-red-contrib-sentrynode) package by Ibraheem Alnabriss.

* Add automated GitHub checks
* Add automated GitHub releases
* Add tests for hook and node registration
* Add version constraint for to Node-RED (>=3.0.0)
* Add support for adding tags via `msg.sentry.tags`
* Add documentation and license
* Add CHANGELOG