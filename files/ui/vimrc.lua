registerLsps {
    lsps = { 'angularls' },
    commands = {
        angularls = { 'ngserver', '--tsProbeLocations=.' },
    },
    root_dirs = {
        angularls = require("lspconfig").util.root_pattern("apps/hr-angular/project.json")
    }
}
