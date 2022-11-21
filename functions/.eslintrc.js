module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["tsconfig.json", "tsconfig.dev.json"],
    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*", // Ignore built files.
  ],
  plugins: ["@typescript-eslint", "import"],
  rules: {
    // severity level: 0 = off, 1 = warn, 2 = error
    "max-len": [0, { code: 80, ignorePattern: "^import\\W.*" }],
    "quotes": [0, "double", { avoidEscape: true }],
    "require-jsdoc": 0,
    "eol-last": 1,
    // "@typescript-eslint/no-unused-vars": 0,
    "no-trailing-spaces": 0,
    "indent": "off",
    "operator-linebreak": 0,
    "object-curly-spacing": 0,
    "import/no-unresolved": 0,
    "@typescript-eslint/no-unused-vars": 0,
  },
};
