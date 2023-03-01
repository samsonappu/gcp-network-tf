#main VPC
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
   name = "main"
   auto_create_subnetworks = false
}

#Public subnet
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork 

resource "google_compute_subnetwork" "public" {
  name = "public"
  ip_cidr_range = "10.0.0.0/24"
  region = "us-west2"
  network = google_compute_network.main.id
}

#private subnet
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork 
resource "google_compute_subnetwork" "private1" {
  name = "private1"
  ip_cidr_range = "10.0.1.0/24"
  region = "us-west2"
  network = google_compute_network.main.id
}

#private subnet
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork 

resource "google_compute_subnetwork" "private2" {
  name = "private2"
  ip_cidr_range = "10.0.2.0/24"
  region = "us-west2"
  network = google_compute_network.main.id
}

#cloud router
#https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_router 

resource "google_network_router" "router" {
  name = "router"
  network = google_compute_network.main.id
  bgp {
       asn  = 64514
       advertise_mode = "CUSTOM"
  }
}

#NAT Gateway

resource "google_compute_router_nat" "nat" {
  name = "nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = "private1"
     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}




