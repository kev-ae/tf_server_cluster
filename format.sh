#!/bin/bash

terraform fmt global/s3/
terraform fmt modules/data-stores/mysql/
terraform fmt modules/services/webserver-cluster/
terraform fmt prod/data-stores/mysql/
terraform fmt prod/services/webserver-cluster/
terraform fmt stage/data-stores/mysql/
terraform fmt stage/services/webserver-cluster/
