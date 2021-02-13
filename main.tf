terraform {
  required_providers {
    intersight = {
      source = "ciscodevnet/intersight"
    }
  }
}

provider "intersight" {
  apikey    = var.api_key
  secretkey = var.secretkey
  endpoint = "https://intersight.com"
}