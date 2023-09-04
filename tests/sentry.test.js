const sentryNode = require('../src/sentry');
const RED = require('./RED.mock');

beforeEach(() => {
    RED.hooks.add.mockClear();
    RED.nodes.registerType.mockClear();
});

it('was a hook added to Node-RED', () => {
    sentryNode(RED);
    expect(RED.hooks.add.mock.calls).toHaveLength(1);
    expect(RED.hooks.add.mock.calls[0][0]).toBe('postReceive');

});

it('was a node registered for sentry', () => {
    sentryNode(RED);
    expect(RED.nodes.registerType.mock.calls).toHaveLength(1);
    expect(RED.nodes.registerType.mock.calls[0][0]).toBe('sentry');
});