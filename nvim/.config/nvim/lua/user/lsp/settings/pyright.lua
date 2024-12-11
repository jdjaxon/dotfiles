local function get_python_site_packages()
    local python_path = vim.g.python3_host_prog or vim.fn.exepath("python3")
    local site_packages = vim.fn.systemlist(python_path .. " -c 'import site; print(site.getsitepackages()[0])'")[1]
    return site_packages
end

return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        usLibraryCodeForTypes = true,
        typeCheckingMode = "off",
        extraPaths = { get_python_site_packages() }
      },
    },
  },
}
