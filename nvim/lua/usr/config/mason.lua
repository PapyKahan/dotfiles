local loaded, mason = pcall(require, "mason")
if not loaded then
   return
end

mason.setup {
    providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
    }
}
