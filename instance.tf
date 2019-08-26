resource "aws_instance" "jump" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  
  # the VPC subnet
  subnet_id = "${aws_subnet.moonshot-public.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykey.key_name}"
  
    tag {
      key = "Name"
      value = "Jump"
      propagate_at_launch = true
  }
}

resource "aws_instance" "dbmaster" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  
  # the VPC subnet
  subnet_id = "${aws_subnet.moonshot-private-dbmaster.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykey.key_name}"
  
    tag {
      key = "Name"
      value = "DB_Master"
      propagate_at_launch = true
  }
}

resource "aws_instance" "dbslave" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  
  # the VPC subnet
  subnet_id = "${aws_subnet.moonshot-private-dbslave.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykey.key_name}"
  
    tag {
      key = "Name"
      value = "DB_Slave"
      propagate_at_launch = true
  }
}
