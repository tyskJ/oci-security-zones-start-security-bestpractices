/************************************************************
Region List
************************************************************/
locals {
  region_map = {
    for r in data.oci_identity_regions.regions.regions :
    r.key => r.name
  }
}

/************************************************************
Security Zones Maximum recipe
************************************************************/
locals {
  oracle_recipe_id = distinct([
    for r in data.oci_cloud_guard_security_recipes.maximum.security_recipe_collection[0].items : r.id
    if r.owner == "ORACLE"
  ])[0]
}

/************************************************************
Security Zones Maximum recipe policy excluded
************************************************************/
locals {
  exclude_display_names = [
    "deny public_buckets",
    "deny buckets_without_vault_key"
  ]

  oracle_policy_ids = distinct([
    for p in data.oci_cloud_guard_security_policies.maximum.security_policy_collection[0].items : p.id
    if p.owner == "ORACLE" && !contains(local.exclude_display_names, p.display_name)
  ])
}