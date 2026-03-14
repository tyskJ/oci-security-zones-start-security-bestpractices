/************************************************************
Zones - root compartment target
************************************************************/
resource "oci_cloud_guard_security_zone" "root" {
  depends_on = [
    oci_cloud_guard_cloud_guard_configuration.this
  ]
  compartment_id          = var.tenancy_ocid
  display_name            = "root-maximum"
  description             = "Target Root Compartment attached maximum security recipe"
  security_zone_recipe_id = local.oracle_recipe_id
}

/************************************************************
Custom Security recipes
************************************************************/
resource "oci_cloud_guard_security_recipe" "this" {
  depends_on = [
    oci_cloud_guard_cloud_guard_configuration.this
  ]
  compartment_id    = var.tenancy_ocid
  display_name      = "custom-recipe"
  description       = "Custom security recipe for other security zones"
  security_policies = local.oracle_policy_ids
}

/************************************************************
Zones - child compartment target
************************************************************/
resource "oci_cloud_guard_security_zone" "child" {
  depends_on = [
    oci_cloud_guard_cloud_guard_configuration.this
  ]
  compartment_id          = oci_identity_compartment.workload.id
  display_name            = "child-custom"
  description             = "Target Child Compartment attached custom security recipe"
  security_zone_recipe_id = oci_cloud_guard_security_recipe.this.id
}