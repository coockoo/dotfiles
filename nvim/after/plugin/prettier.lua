local prettier = require('prettier')

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'tsx',
    'typescript',
    'typescriptreact',
    'yaml',
  },
}
