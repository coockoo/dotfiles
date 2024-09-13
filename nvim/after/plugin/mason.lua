local mason = require('mason')
mason.setup({
  PATH = 'prepend', -- "skip" seems to cause the spawning error
})
