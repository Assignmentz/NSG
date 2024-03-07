resource "aws_internet_gateway" "igateway" {
    vpc_id               = aws_vpc.vnet.id
    tags                 = {
        Name             = "IGW"
    }
    depends_on           = [ aws_vpc.vnet, aws_subnet.pub_subnets ]
}

resource "aws_security_group" "Web-SG" {
    vpc_id               = aws_vpc.vnet.id
    description          = local.default_desc

    ingress {
        from_port        = local.ssh_port
        to_port          = local.ssh_port
        protocol         = local.protocol
        cidr_blocks      = [local.any_where]
    }
    ingress {
        from_port        = local.http_port
        to_port          = local.http_port
        protocol         = local.protocol
        cidr_blocks      = [local.any_where]
    }
    egress {
        from_port        = local.all_ports
        to_port          = local.all_ports
        protocol         = local.any_protocol
        cidr_blocks      = [local.any_where]
        ipv6_cidr_blocks = [local.any_where_ipv6]
    }
    tags                 = {
        Name             = "Web-Security"
    }
    depends_on           = [ aws_vpc.vnet ]
}
