resource "aws_launch_configuration" "moonshot-launchconfig-web" {
  name_prefix          = "moonshot-launchconfig-web"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  security_groups      = ["${aws_security_group.allow-ssh.id}"]
}

resource "aws_launch_configuration" "moonshot-launchconfig-app" {
  name_prefix          = "moonshot-launchconfig-app"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t2.micro"
  key_name             = "${aws_key_pair.mykey.key_name}"
  security_groups      = ["${aws_security_group.allow-ssh.id}"]
}

resource "aws_autoscaling_group" "moonshot-autoscaling-web" {
  name                 = "moonshot-autoscaling-web"
  vpc_zone_identifier  = ["${aws_subnet.moonshot-private-web.id}"]
  launch_configuration = "${aws_launch_configuration.moonshot-launchconfig-web.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "Name"
      value = "web_server"
      propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "moonshot-autoscaling-app" {
  name                 = "moonshot-autoscaling-app"
  vpc_zone_identifier  = ["${aws_subnet.moonshot-private-web.id}"]
  launch_configuration = "${aws_launch_configuration.moonshot-launchconfig-app.name}"
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "Name"
      value = "app_server"
      propagate_at_launch = true
  }
}
