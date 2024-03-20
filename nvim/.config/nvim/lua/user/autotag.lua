local status_ok, ntags = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

ntags.setup {
  autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
  }
}
