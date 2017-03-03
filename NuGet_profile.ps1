function Clear-WebOptimization() {
    # Map current packages to string array
    $allPackages = Get-Package | Foreach-Object { "$($_.Id)" }

    $undesiredPackages = @(
        "Antlr",
        "bootstrap",
        "jQuery",
        "jQuery.Validation",
        "Microsoft.AspNet.Web.Optimization",
        "Microsoft.jQuery.Unobtrusive.Validation",
        "Modernizr",
        "Respond",
        "WebGrease"
    )

    foreach ($package in $undesiredPackages) {
        if ($allPackages -contains $package) {
            Uninstall-Package $package -Force
        }
    }
}