-- setup vars
-- print("loading jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home_dir = vim.env.HOME .. '\\'
local workspace_dir = home_dir .. 'workspaces\\' .. project_name

local jdtls_home = os.getenv("JDTLS_HOME")
if (jdtls_home == nil or jdtls_home == '') then
    local vscode_dir = home_dir .. '.vscode\\extensions\\'
    jdtls_home = vim.fn.glob(vscode_dir .. "redhat.java-*", false, true)[1]
end

if (jdtls_home == nil or jdtls_home == '') then
    print("could not find jdtls home")
    do return end
end

local jdtls_jar = vim.fs.find(function(name)
    return name:match('org.eclipse.equinox.launcher_.*%.jar')
end, { path = jdtls_home, type = 'file' })[1]

local config = os.getenv("JDTLS_CONFIG_HOME")
if (config == nil or config == '') then
    config = vim.fs.find(function(name)
        return name:match('config_win')
    end, { path = jdtls_home, type = 'directory' })[1]
end

local lombok_jar = os.getenv("LOMBOK_JAR")
if (lombok_jar == nil or lombok_jar == '') then
    lombok_jar = vim.fs.find(function(name)
        return name:match('lombok.*%.jar')
    end, { path = jdtls_home, type = 'file' })[1]
end

local java = vim.fs.find(function(name)
    return name:match('java.exe')
end, { path = jdtls_home, type = 'file' })[1]

print(java)
if (java == nil or java == '') then
    print("java was not found")
    local java_home = os.getenv("JAVA_HOME_23")
    if (java_home == nil or java_home == '') then
        java_home = os.getenv("JAVA_HOME")
    end
    java = java_home .. '/bin/java'
end

-- vim.lsp.log.set_level(vim.log.levels.TRACE)

local capabilities = {
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
}

capabilities = LSP_CAPABILITIES

--print(lombok_jar)
--print(jdtls_jar)
--print(config)
--print(java)
--print(workspace_dir)
-- setup jdtls server
local jdtls_config = {
    on_attach = function(client, bufnr)
        require("lsp_signature").on_attach({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        }, bufnr)
    end,
    cmd = {
        java,
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok_jar,
        '-jar', jdtls_jar,
        '-configuration', config,
        '-data', workspace_dir,
    },

    root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.gitignore', 'settings.gradle' }, { upward = true })[1]),

    capabilities = capabilities,

    init_options = {
        settings = {
            java = {
                import = {
                    gradle = {
                        enabled = true,
                        wrapper = {
                            enabled = false,
                        },
                        home = "C:/Users/themar/.toolbox/apps/Gradle/gradle-8.13/",
                    }
                }
            }
        }
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            format = {
                enabled = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },

            completion = {
                favoriteStaticMembers = {
                    "org.assertj.core.api.Assertions.assertThat",
                    "org.junit.jupiter.api.Assertions.assertThrows",
                    "org.mockito.Mockito.verify",
                    "org.mockito.Mockito.when",
                },
                guessMethodArguments = true,
            },

            jdt = {
                ls = {
                    lombokSupport = {
                        enabled = true,
                    }
                }
            },
        }
    }
}

--print("jdtls setup done.")
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require("jdtls").start_or_attach(jdtls_config)
    end,
})
