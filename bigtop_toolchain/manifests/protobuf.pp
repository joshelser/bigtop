# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class bigtop_toolchain::protobuf {

  include bigtop_toolchain::deps

  case $operatingsystem{
    Ubuntu: {
      exec {'/usr/bin/dpkg -i protobuf-compiler_2.5.0-9ubuntu1_amd64.deb':
        unless  => "/usr/bin/test -f /usr/bin/protoc",
        cwd     => "/usr/src",
        require => [ EXEC["/usr/bin/dpkg -i libprotoc8_2.5.0-9ubuntu1_amd64.deb"],EXEC["/usr/bin/wget https://launchpad.net/ubuntu/+archive/primary/+files/protobuf-compiler_2.5.0-9ubuntu1_amd64.deb"] ]
      }

      exec {'/usr/bin/dpkg -i libprotoc8_2.5.0-9ubuntu1_amd64.deb':
        unless  => "/usr/bin/test -f /usr/bin/protoc",
        cwd     => "/usr/src",
        require => [ EXEC["/usr/bin/dpkg -i libprotobuf8_2.5.0-9ubuntu1_amd64.deb"],EXEC["/usr/bin/wget https://launchpad.net/ubuntu/+archive/primary/+files/libprotoc8_2.5.0-9ubuntu1_amd64.deb"] ]
      }

      exec {'/usr/bin/dpkg -i libprotobuf8_2.5.0-9ubuntu1_amd64.deb':
        unless  => "/usr/bin/test -f /usr/bin/protoc",
        cwd     => "/usr/src",
        require => EXEC["/usr/bin/wget https://launchpad.net/ubuntu/+archive/primary/+files/libprotobuf8_2.5.0-9ubuntu1_amd64.deb"],
      }

    }
    default:{
      file { '/etc/yum.repos.d/mrdocs-protobuf-rpm.repo':
        source => 'puppet:///modules/bigtop_toolchain/mrdocs-protobuf-rpm.repo',
        ensure => present,
        owner  => root,
        group  => root,
        mode   => 755,
      }
  
      package { 'protobuf-devel':
        ensure => present,
        require => File['/etc/yum.repos.d/mrdocs-protobuf-rpm.repo'],
      }
    }
  }
}
