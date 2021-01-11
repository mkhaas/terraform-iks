resource "intersight_ntp_policy" "defaultNTP" {
  name    = "defaultNTP"
  enabled = true
  ntp_servers = [ "ntp.esl.cisco.com" ]
  timezone = "Europe/Amsterdam"

  tags { 
      key = "Managed_By"
      value = "Terraform"
  }
  organization {
      object_type = "organization.Organization"
      moid = var.organization
  }
}