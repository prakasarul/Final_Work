resource "aws_efs_file_system" "webdata_efs" {
   vpc_id = "${aws_vpc.moonshot.id}"
   creation_token = "webdata_efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "Web_Data_EFS"
   }
 }
 
 resource "aws_efs_mount_target" "webdata_efs_1" {
   vpc_id = "${aws_vpc.moonshot.id}"
   file_system_id  = "${aws_efs_file_system.webdata_efs.id}"
   subnet_id = "${aws_subnet.moonshot-private-web.id}"
   security_groups = ["${aws_security_group.allow-ssh.id}"]
 }
 
resource "aws_efs_file_system" "appdata_efs" {
   vpc_id = "${aws_vpc.moonshot.id}"
   creation_token = "appdata_efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "APP_Data_EFS"
   }
 }
 
 resource "aws_efs_mount_target" "appdata_efs_1" {
   vpc_id = "${aws_vpc.moonshot.id}"
   file_system_id  = "${aws_efs_file_system.appdata_efs.id}"
   subnet_id = "${aws_subnet.moonshot-private-app.id}"
   security_groups = ["${aws_security_group.allow-ssh.id}"]
 }
