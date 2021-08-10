
resource "oci_core_virtual_network" "CompleteVCN_TF" {
  cidr_block = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "CompleteVCN_TF"
}

resource "oci_core_internet_gateway" "CompleteIG_TF" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "CompleteIG_TF"
    vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
}

resource "oci_core_route_table" "RouteForComplete_TF" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
    display_name = "RouteTableForComplete"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.CompleteIG_TF.id}"
    }
}

resource "oci_core_security_list" "WebSubnet_TF" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Public"
    vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 80
            "min" = 80
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "6"
	source = "${var.VPC-CIDR}"
    },
	{
	tcp_options {
	    "max" = 22
	    "min" = 22
	}
	protocol = "6"
	source = "0.0.0.0/0"
    }]
}

resource "oci_core_security_list" "PrivateSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Private"
    vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
    egress_security_rules = [{
	protocol = "6"
	destination = "${var.VPC-CIDR}"
#	protocol = "6"
#	destination = "0.0.0.0/0"
    }]
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.VPC-CIDR}"
    }]
}

resource "oci_core_subnet" "WebSubnet_AD1_TF" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "172.16.1.0/24"
  display_name = "WebSubnet_AD1_TF"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete_TF.id}"
  security_list_ids = ["${oci_core_security_list.WebSubnet_TF.id}"]
}


resource "oci_core_subnet" "PrivateSubnetAD1_TF" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "172.16.4.0/24"
  display_name = "PrivateSubnetAD1_TF"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN_TF.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete_TF.id}"
  security_list_ids = ["${oci_core_security_list.PrivateSubnet.id}"]
}

resource "oci_core_instance" "TF_webserver" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TF_webserver"
  image = "${var.Oracle-Linux-7_3}"
  shape = "VM.Standard1.1"
  subnet_id = "${oci_core_subnet.WebSubnet_AD1_TF.id}"
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }
}

resource "oci_core_instance" "TF_dbserver" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "a_TF_managed_dbserver"
  image = "${var.Oracle-Linux-7_3}"
  shape = "VM.Standard1.1"
  subnet_id = "${oci_core_subnet.PrivateSubnetAD1_TF.id}"
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }
}

