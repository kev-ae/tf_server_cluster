#!/bin/bash

terraform fmt global/s3/
terraform fmt prod/data-stores/mysql/
terraform fmt prod/services/webserver-cluster/
terraform fmt stage/data-stores/mysql/
terraform fmt stage/services/webserver-cluster/
