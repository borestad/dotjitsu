// ========================================================================
//  Eslint Configuration (@starterkit)
//  Now supports TypeScript!
//
//  🔗 https://babeljs.io/docs/en/config-files
//  🔗 https://new.babeljs.io/docs/en/next/babelconfigjs.html
//
//  The philosophy behind these rules is that 99% should be autofix'able.
//
// ======================================================================== */

const js = ['.js', '.jsx', '*.mjs']
const ts = ['.ts', '.tsx', '*.mjs']
const extensions = { ts, all: [...js, ...ts] }
const OFF = 'off'

/**
 *  Helpers
 * ----------------------------------------------------
 */
const paddingWildcard = (blankLine = 'always', rules = []) => {
  return [
    { blankLine, prev: rules, next: '*' }, //
    { blankLine, prev: '*', next: rules },
  ]
}

const conf = {
  config() {
    // Uncomment for debugging / live editing rules
    delete require.cache[require.resolve(__filename)]

    // parser: '@typescript-eslint/parser',
    const config = {}
    config.parserOptions = {
      ecmaVersion: 2022, // Allows for the parsing of modern ECMAScript features
      sourceType: 'module', // Allows for the use of imports
      project: ["tsconfig.json"],

      // This setting is required if you want to use rules which require type information.
      // Slows down linting a bit
      // project: require('path').resolve(__dirname, './tsconfig.json'),
      // tsconfigRootDir: __dirname,
    }

    config.settings = {
      'import/extensions': extensions.all,
      'import/parsers': {
        '@typescript-eslint/parser': extensions.all,
      },
      'import/resolver': {
        node: { extensions: extensions.all },
      },
    }

    config.plugins = ['unicorn', 'sonarjs']

    config.extends = [
      // Uses the recommended rules from the @typescript-eslint/eslint-plugin
      'plugin:@typescript-eslint/recommended',

      // May be slow on large code bases
      // "plugin:@typescript-eslint/recommended-requiring-type-checking",

      // https://github.com/SonarSource/eslint-plugin-sonarjs
      'plugin:sonarjs/recommended',

      // https://github.com/standard/eslint-config-standard/blob/master/eslintrc.json
      'standard',

      // https://github.com/benmosher/eslint-plugin-import
      'plugin:import/errors',

      // Uses eslint-config-prettier to disable ESLint rules from
      // @typescript-eslint/eslint-plugin that would conflict with prettier
      // 'prettier/@typescript-eslint',
      // 'eslint-config-prettier',

      // Turns off all rules that are unnecessary or might conflict with Prettier.
      // https://github.com/prettier/eslint-config-prettier/blob/master/standard.js
      'prettier',

      // Enables eslint-plugin-prettier and eslint-config-prettier.
      // This will display prettier errors as ESLint errors.
      // Make sure this is always the last configuration in the extends array.
      'plugin:prettier/recommended',
    ]

    config.env = {
      browser: true,
      es6: true,
      node: true,
      jest: true,
    }

    // Allow globals to exist without throwing an error.
    // i.e: Sys, Environment, jQuery
    config.globals = {
      Atomics: 'readonly',
      SharedArrayBuffer: 'readonly',
      __DEV__: true,
      __DEBUG__: true,
      __TEST__: true,
      __PROD__: true,
      __BUILD_DATE__: true,
      __VERSION__: true,
      __GITHASH__: true,
    }

    // Overrides
    config.overrides = [
      // Rules specifically for TypeScript files
      {
        files: ['*.ts', '*.tsx'],
        rules: {
          '@typescript-eslint/explicit-module-boundary-types': ['error'],
        },
      },
      // Rules specifically for Javascript files
      {
        files: ['*.js', '*.jsx', '*.mjs'],
        rules: {
          '@typescript-eslint/explicit-module-boundary-types': ['error'],
        },
      },
      // Rules specifically for Test files
      {
        files: ['*.spec.*', '*.test.*', '*.e2e.*', 'test.*'],
        rules: {
          // Keep tests simple & clean
          'padding-line-between-statements': [
            'error',
            ...paddingWildcard('always', ['multiline-expression']),
          ],
          'sonarjs/cognitive-complexity': ['error', 10],
          'complexity': ['error', 5],
        },
      },
    ]

    /**
       Built-in Eslint Rules: https://eslint.org/docs/rules/
      ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
    */
    config.rules = {
      "require-await": "off",
      "@typescript-eslint/require-await": "error",
      // 'max-len': ['error', { code: 80 }],
      'complexity': ['error', 20],
      'camelcase': OFF,
      'no-multi-spaces': [
        1,
        {
          exceptions: {
            VariableDeclarator: true,
            ObjectExpression: true,
          },
        },
      ],
      // indent: ['error', 4],

      'indent': ['error', 2, { VariableDeclarator: { var: 2, let: 2, const: 3 } }],
      'no-unused-expressions': OFF,
      'no-unused-vars': OFF,
      // 'one-var': ['error', 'always'],
      'global-require': OFF,
      'no-var': 'error',
      // 'one-var': ['error', { var: 'never', let: 'consecutive', const: 'consecutive' }],
      'prefer-const': 'error',
      'prefer-template': 'error',
      'object-shorthand': [
        'error',
        'always',
        {
          ignoreConstructors: true,
        },
      ],
      'lines-between-class-members': ['error', 'always', { exceptAfterSingleLine: true }],
      // 'comma-dangle': ['error', 'always-multiline'],

      /**
       * Sonar rules
       */
      'sonarjs/prefer-immediate-return': 'error',
      'sonarjs/no-duplicate-string': OFF,
      'sonarjs/no-identical-functions': OFF,
      // Tweak cognitive complexity to your liking
      'sonarjs/cognitive-complexity': ['error', 10],

      /**
       *  Linebreak / Codestyle
       *  https://eslint.org/docs/rules/padding-line-between-statements
       *  Warning: Don't mess with these unless you know what you'e doing since
       *  they can interfere with prettier
       */
      'padding-line-between-statements': [
        'error',
        ...(() => {
          // Common base rules to be used for line breaks
          const alwaysUseLineBreak = [
            'block-like',
            'block',
            'cjs-export',
            'class',
            'directive',
            'for',
            'function',
            'if',
            'throw',
            'try',
          ]

          return [
            // 2. Enforces const,let to always create a block of code
            { blankLine: 'always', prev: ['const', 'let'], next: '*' },

            // 3. Enforces exports to always create a block of code
            // Allows const & export const to be grouped
            { blankLine: 'always', prev: '*', next: 'export' },
            ...paddingWildcard('any', ['const', 'let', 'export']),

            // 4. Avoid unreadable multiline commands
            { blankLine: 'always', prev: 'multiline-expression', next: '*' },

            // 5. Experimental
            { blankLine: 'always', prev: alwaysUseLineBreak, next: ['export'] },

            // 1. Common rules to create linebreaks
            ...paddingWildcard('always', alwaysUseLineBreak),
          ]
        })(),
      ],

      /**
       * Typescript-Eslint Rules
       * https://www.npmjs.com/package/@typescript-eslint/eslint-plugin
       * ----------------------------------------------------
       */
      '@typescript-eslint/ban-types': OFF,
      // '@typescript-eslint/no-floating-promises': OFF, // TODO: https://github.com/typescript-eslint/typescript-eslint/issues/464
      "@typescript-eslint/no-floating-promises": "error",
      // '@typescript-eslint/camelcase': ['error', { properties: 'never' }],
      '@typescript-eslint/no-non-null-assertion': OFF,
      '@typescript-eslint/no-use-before-define': ['error', { functions: false, variables: false }],
      '@typescript-eslint/explicit-function-return-type': OFF,
      '@typescript-eslint/explicit-member-accessibility': ['error', { accessibility: 'no-public' }],
      '@typescript-eslint/no-var-requires': OFF,
      '@typescript-eslint/no-parameter-properties': OFF,
      '@typescript-eslint/no-explicit-any': OFF,
      '@typescript-eslint/consistent-type-assertions': 'error',
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          vars: 'all',
          varsIgnorePattern: '^[_$]|[_$]$',
          args: 'after-used',
          caughtErrors: 'none',
          ignoreRestSiblings: true,
          argsIgnorePattern: '^[_$]',
        },
      ],

      /**
       * Import Plugin Rules
       * ----------------------------------------------------
       */
      'import/no-unresolved': OFF,
      'import/no-useless-path-segments': ['error'],
      'import/named': 'error',
      'import/namespace': 'error',
      'import/default': 'error',
      'import/export': 'error',
      'import/extensions': ['error', 'never'],
      'import/newline-after-import': 'error',
      'import/no-extraneous-dependencies': 'error',
      'import/order': [
        'error',
        {
          groups: ['builtin', 'external', 'internal', 'parent', 'sibling', 'index'],
        },
      ],

      /**
       * Unicorn rules
       * https://github.com/sindresorhus/eslint-plugin-unicorn
       * ----------------------------------------------------
       */
      'unicorn/catch-error-name': 'error',
      'unicorn/custom-error-definition': OFF,
      'unicorn/error-message': 'error',
      // DISABLED due to not practical in global settings
      // 'unicorn/filename-case': [
      //   'error',
      //   {
      //     // https://github.com/sindresorhus/eslint-plugin-unicorn/blob/master/docs/rules/filename-case.md
      //     cases: {
      //       kebabCase: true,
      //       camelCase: true,
      //       pascalCase: true,
      //       snakeCase: false
      //     }
      //   }
      // ],
      'unicorn/import-index': 'error',
      'unicorn/new-for-builtins': OFF,
      'unicorn/no-abusive-eslint-disable': 'error',
      'unicorn/no-array-instanceof': 'error',
      'unicorn/no-console-spaces': 'error',
      'unicorn/no-for-loop': OFF,
      'unicorn/no-process-exit': 'error',
      'unicorn/no-unreadable-array-destructuring': 'error',
      'unicorn/no-unused-properties': 'error',
      'unicorn/no-zero-fractions': 'error',
      'unicorn/prefer-exponentiation-operator': 'error',
      'unicorn/prefer-includes': 'error',
      'unicorn/prefer-type-error': 'error',
      'unicorn/regex-shorthand': 'error',
    }

    return config
  },
}

module.exports = conf.config()
