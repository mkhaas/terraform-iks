terraform {
  required_providers {
    intersight = {
      source = "ciscodevnet/intersight"
    }
  }
}

provider "intersight" {
  apikey    = var.api_key
  secretkeyfile = var.secretkeyfile
  endpoint = "https://intersight.com"
}