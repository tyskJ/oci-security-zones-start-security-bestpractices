/************************************************************
Compartment - workload
************************************************************/
resource "oci_identity_compartment" "parent" {
  compartment_id = var.tenancy_ocid
  name           = "Parent"
  description    = "Parent For oci-security-zones-preventive-controls"
  enable_delete  = true
}

resource "oci_identity_compartment" "child" {
  compartment_id = oci_identity_compartment.parent.id
  name           = "Child"
  description    = "Child For oci-security-zones-preventive-controls"
  enable_delete  = true
  defined_tags   = local.common_defined_tags
}