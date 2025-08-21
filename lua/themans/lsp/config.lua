-- setup vars
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home_dir = vim.env.HOME .. '/'
local workspace_dir = home_dir .. 'projects/' .. project_name

-- find jdtls home
local jdtls_home = os.getenv("JDTLS_HOME")
if (jdtls_home == nil or jdtls_home == '') then
    local vscode_dir = home_dir .. '.vscode-server/extensions/'
    local home_handle = io.popen("find " .. vscode_dir .. " -type d -name 'redhat.java-*' -printf '%f\\n' | sort -r ")
    local result = home_handle:read("*l")
    if (result ~= nil) then
        jdtls_home = vscode_dir .. home_handle:read("*l") .."/"
    end
    home_handle:close()
end

if (jdtls_home == nil or jdtls_home == '') then
    print("could not find jdtls home")
    do return end
end

local handle = io.popen("find " .. jdtls_home .. " -type f -name 'org.eclipse.equinox.launcher_*.jar'")
local jdtls_jar = handle:read("*l")
handle:close()

local config_linux = os.getenv("JDTLS_CONFIG_HOME")
if (config_linux == nil or config_linux == '') then
    local config_handle = io.popen("find " .. jdtls_home .. " -type d -name 'config_linux'")
    config_linux = config_handle:read("*l")
    config_handle:close()
end

local lombok_jar = os.getenv("LOMBOK_JAR")
if (lombok_jar == nil or lombok_jar == '' ) then
local lombok_handle = io.popen("find " .. jdtls_home .. " -type f -name 'lombok*.jar'")
lombok_jar = lombok_handle:read("*l")
lombok_handle:close()
end

local java_home = os.getenv("JAVA_HOME_23")
if (java_home == nil or java_home == '') then
    java_home = os.getenv("JAVA_HOME")
end

local java = java_home .. 'bin/java'
-- vim.lsp.log.set_level(vim.log.levels.TRACE)

local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

-- setup jdtls server
jdtls_config = {
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
		'-configuration', config_linux,
		'-data', workspace_dir,
	},

	root_dir = vim.fs.dirname(vim.fs.find({'.git', '.gitignore', '.envrc'}, { upward = true })[1]),

	capabilities = capabilities,

    settings = {
        java = {
            signatureHelp = { enabled = true },

            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17",
                        default = true
                    },
                    {
                        name = "JavaSE-1.8",
                        path = "/usr/lib/jvm/java-1.8.0"
                    }
                }
            },

            format = {
                enabled = true,
                settings = {
                    url = home_dir .. 'projects/formatter.xml',
                },
            },

            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                },
            },

            completion = {
                favoriteStaticMembers = {
                    "org.assertj.core.api.Assertions.assertThat",
                    "org.junit.jupiter.api.Assertions.assertThrows",
                    "org.mockito.Mockito.verify",
                    "org.mockito.Mockito.when",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.CONSUMER_KEY",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.CONSUMER_RANK_KEY",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.CONTACT_DETAILS_KEY",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.DOCUMENT",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.LANGUAGE_KEY",
                    "be.buyway.hydra.businessprocess.edirect.adapter.primary.web.flow.SessionAttributes.REF_KEY",
                    "org.springframework.http.HttpStatus.EXPECTATION_FAILED",
                    "org.springframework.http.HttpStatus.SERVICE_UNAVAILABLE",
                },
                guessMethodArguments = true,
                importOrder = { 
                    "jakarta", 
                    "java",
                    "javax",
                    "org",
                    "com",
                    "be.buyway"
                },
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
