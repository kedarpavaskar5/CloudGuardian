#!/bin/bash
echo "Running Steampipe baseline queries..."

steampipe query "select instance_id, instance_type, instance_state, vpc_id, subnet_id, key_name, launch_time from aws_ec2_instance;" --output csv > baseline_ec2_config.csv

steampipe query "select name, user_id, arn, create_date from aws_iam_user;" --output csv > baseline_iam_config.csv

steampipe query "select name, assume_role_policy_std from aws_iam_role where name = 'cloudguardian-web-role';" --output csv > baseline_iam_role.csv

steampipe query "select db_instance_identifier, engine, class, multi_az, publicly_accessible, storage_encrypted from aws_rds_db_instance;" --output csv > baseline_rds_config.csv

steampipe query "select name, region, creation_date, versioning_enabled from aws_s3_bucket;" --output csv > baseline_s3_config.csv

steampipe query "select name, server_side_encryption_configuration, block_public_acls, block_public_policy from aws_s3_bucket;" --output csv > baseline_s3_security.csv

steampipe query "select group_id, group_name, description, vpc_id from aws_vpc_security_group;" --output csv > baseline_sg_config.csv

steampipe query "select group_name, ip_permissions, ip_permissions_egress from aws_vpc_security_group;" --output csv > baseline_sg_rules.csv

steampipe query "select subnet_id, vpc_id, cidr_block, availability_zone, map_public_ip_on_launch from aws_vpc_subnet;" --output csv > baseline_subnet_config.csv

steampipe query "select vpc_id, cidr_block, is_default, state, instance_tenancy from aws_vpc;" --output csv > baseline_vpc_config.csv

echo "Done! All 10 baseline CSVs generated."
