// Mock module for Node-RED object
module.exports =  {
    nodes: {
        registerType: jest.fn()
    },
    hooks: {
        add: jest.fn()
    }
}