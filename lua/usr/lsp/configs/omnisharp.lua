local loaded, omnisharp_extended = pcall(require, 'omnisharp_extended')
if not loaded then
    return {}
end
        --→ csharp.format.enable                                                      default: true
        --→ csharp.inlayHints.parameters.enabled                                      default: false
        --→ csharp.inlayHints.parameters.forIndexerParameters                         default: false
        --→ csharp.inlayHints.parameters.forLiteralParameters                         default: false
        --→ csharp.inlayHints.parameters.forObjectCreationParameters                  default: false
        --→ csharp.inlayHints.parameters.forOtherParameters                           default: false
        --→ csharp.inlayHints.parameters.suppressForParametersThatDifferOnlyBySuffix  default: false
        --→ csharp.inlayHints.parameters.suppressForParametersThatMatchArgumentName   default: false
        --→ csharp.inlayHints.parameters.suppressForParametersThatMatchMethodIntent   default: false
        --→ csharp.inlayHints.types.enabled                                           default: false
        --→ csharp.inlayHints.types.forImplicitObjectCreation                         default: false
        --→ csharp.inlayHints.types.forImplicitVariableTypes                          default: false
        --→ csharp.inlayHints.types.forLambdaParameterTypes                           default: false
        --→ csharp.maxProjectFileCountForDiagnosticAnalysis                           default: 1000
        --→ csharp.referencesCodeLens.enabled                                         default: true
        --→ csharp.referencesCodeLens.filteredSymbols                                 default: []
        --→ csharp.semanticHighlighting.enabled                                       default: true
        --→ csharp.showOmnisharpLogOnError                                            default: true
        --→ csharp.suppressBuildAssetsNotification                                    default: false
        --→ csharp.suppressDotnetInstallWarning                                       default: false
        --→ csharp.suppressDotnetRestoreNotification                                  default: false
        --→ csharp.suppressHiddenDiagnostics                                          default: true
        --→ csharp.suppressProjectJsonWarning                                         default: false
        --→ csharp.testsCodeLens.enabled                                              default: true
        --→ csharp.unitTestDebuggingOptions
        --→ omnisharp.analyzeOpenDocumentsOnly                                        default: false
        --→ omnisharp.autoStart                                                       default: true
        --→ omnisharp.defaultLaunchSolution                                          
        --→ omnisharp.disableMSBuildDiagnosticWarning                                 default: false
        --→ omnisharp.dotnetPath                                                     
        --→ omnisharp.enableAsyncCompletion                                           default: false
        --→ omnisharp.enableDecompilationSupport                                      default: false
        --→ omnisharp.enableEditorConfigSupport                                       default: true
        --→ omnisharp.enableImportCompletion                                          default: false
        --→ omnisharp.enableMsBuildLoadProjectsOnDemand                               default: false
        --→ omnisharp.enableRoslynAnalyzers                                           default: false
        --→ omnisharp.loggingLevel                                                    default: "information"
        --→ omnisharp.maxFindSymbolsItems                                             default: 1000
        --→ omnisharp.maxProjectResults                                               default: 250
        --→ omnisharp.minFindSymbolsFilterLength                                      default: 0
        --→ omnisharp.monoPath                                                       
        --→ omnisharp.organizeImportsOnFormat                                         default: false
        --→ omnisharp.path                                                           
        --→ omnisharp.projectLoadTimeout                                              default: 60
        --→ omnisharp.sdkIncludePrereleases                                           default: true
        --→ omnisharp.sdkPath                                                        
        --→ omnisharp.sdkVersion                                                     
        --→ omnisharp.testRunSettings                                                
        --→ omnisharp.useEditorFormattingSettings                                     default: true
        --→ omnisharp.useModernNet                                                    default: true
        --→ omnisharp.waitForDebugger                                                 default: false
        --→ razor.devmode                                                             default: false
        --→ razor.disabled                                                            default: false
        --→ razor.format.enable                                                       default: true
        --→ razor.languageServer.debug                                                default: false
        --→ razor.languageServer.directory                                           
        --→ razor.plugin.path                                                        
        --→ razor.trace                                                               default: "Off"

return {
    cmd = { "omnisharp.cmd" },
    handlers = {
        ["textDocument/definition"] = omnisharp_extended.handler,
    },
    settings = {

    }
}
