terraform {
  required_providers {
    intersight = {
      source = "ciscodevnet/intersight"
      #version = "0.1.0"
    }
  }
}

provider "intersight" {
  apikey    = var.api_key
  secretkeyfile = "/Users/baelen/OneDrive - Cisco/Keys/SecretKey_Intersight.txt"
  endpoint = "https://intersight.com"
}



