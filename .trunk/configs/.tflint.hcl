plugin "terraform" {
  enabled = true
  preset  = "all"
}

config {
  format = "compact"
  call_module_type = "local"
  force = false
  disabled_by_default = false
}

# Installing tflint rulesets from Github requires setting a GITHUB_TOKEN
# environment variable. Without it, you'll get an error like this:
#   $ tflint --init
#   Installing "aws" plugin...
#   Failed to install a plugin; Failed to fetch GitHub releases: GET https://api.github.com/repos/terraform-linters/tflint-ruleset-aws/releases/tags/v0.39.0: 401 Bad credentials []
#
# The solution is to provide a github PAT via a GITHUB_TOKEN env var,
# export GITHUB_TOKEN=github_pat_120abc123def456ghi789jkl123mno456pqr789stu123vwx456yz789
#
# See docs for more info: https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/plugins.md#avoiding-rate-limiting
plugin "aws" {
  enabled = true
  version = "0.39.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  deep_check = false
}


rule "terraform_comment_syntax" {
    # Disallow `//` comments in favor of `#`
    enabled = true
}
rule "terraform_deprecated_index" {
    # Disallow legacy dot index syntax
    enabled = true
}
rule "terraform_documented_outputs" {
    # Disallow output declarations without description
    enabled = true
}
rule "terraform_documented_variables" {
    # Disallow variable declarations without description
    enabled = true
}
rule "terraform_naming_convention" {
    # Enforces naming conventions for resources, data sources, etc
    enabled = true
}
rule "terraform_required_providers" {
    # Require that all providers have version constraints through required_providers
    enabled = true
}
rule "terraform_required_version" {
    # Disallow terraform declarations without require_version
    enabled = true
}

# Allow variables to exist in more files than ONLY variables.tf
# Example use cases where we prefer for variables to exist in context,
# - context.tf (applicable to the null-label module)
# - providers.tf (when passing in secret keys from SOPs - example, github provider)
# https://github.com/terraform-linters/tflint-ruleset-terraform/blob/main/docs/rules/terraform_standard_module_structure.md
rule "terraform_standard_module_structure" {
  enabled = false
}

rule "terraform_typed_variables" {
    # Disallow variable declarations without type
    enabled = true
}
rule "terraform_unused_declarations" {
    # Disallow variables, data sources, and locals that are declared but never used
    enabled = true
}
rule "terraform_unused_required_providers" {
    # Check that all required_providers are used in the module
    enabled = true
}