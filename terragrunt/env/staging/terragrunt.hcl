terraform {
  source = "../..//aws"
}

include {
  path = find_in_parent_folders("root.hcl")
}