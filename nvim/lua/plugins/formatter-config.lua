require "format".setup {
  go = {
    {
      cmd = { "gofmt -w", "goimports -w" },
      tempfile_postfix = ".tmp"
    }
  }
}
