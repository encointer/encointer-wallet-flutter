module.exports = {
    env: {
        production: {
            presets: [["@babel/env", { modules: false }]],
            plugins: [
                [
                    "@babel/plugin-transform-runtime",
                    {
                        regenerator: true,
                    },
                ],
            ],
        },
        test: {},
    },
};
