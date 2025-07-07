-- setup vars
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home_dir = vim.env.HOME .. '/'
local workspace_dir = home_dir .. 'projects/' .. project_name

local vscode_dir = home_dir .. '.vscode-server/extensions/'

local home_handle = io.popen("find " .. vscode_dir .. " -type d -name 'redhat.java-*' -printf '%f\\n' | sort -r ")
local jdtls_home = vscode_dir .. home_handle:read("*l") .."/"
home_handle:close()

local handle = io.popen("find " .. jdtls_home .. " -type f -name 'org.eclipse.equinox.launcher_*.jar'")
local jdtls_jar = handle:read("*l")
handle:close()

local lombok_handle = io.popen("find " .. jdtls_home .. " -type f -name 'lombok*.jar'")
local lombok_jar = lombok_handle:read("*l")
lombok_handle:close()

local java =  "/usr/lib/jvm/java-23/bin/java"

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
		'-configuration', jdtls_home .. 'server/config_linux',
		'-data', workspace_dir,
	},

	root_dir = vim.fs.dirname(vim.fs.find({'Jenkinsfile', '.git', '.gitignore', '.envrc'}, { upward = true })[1]),

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
