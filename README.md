# Symmetrical Octo Tribble

Wireguard VPN creation on an EC2 instance using Terraform. Generates the server keys and the client keys and then these are used to connect once the Terraform has run to create the EC2 instance. Based on https://www.wireguard.com/quickstart/

Requires Terraform https://learn.hashicorp.com/tutorials/terraform/install-cli and git

```
$ sudo apt-get install git
$ git clone "git@github.com:tommybobbins/symmetrical-octo-tribble.git"
```

# Usage

```
$ cd symmtrical-octo-tribble
```

Edit the variables.tf and modify the region you want the EC2 instance created in. This defaults to North Virginia - us-east-1
```
$ terraform init; terraform plan; terraform apply --auto-approve
```
Wait for this to apply, then take another 2 minutes beyond the end of the below output. There is a delay as dracut needs to install the wireguard module once the new kernel is booted.

```
Outputs:

client_priv = <<EOT
6BaJxJ6iSB69aAe+hlpWCckqVViCZqPq+X6s182W0U4=

EOT
client_pub = <<EOT
4y+vodTchACZHxMUu/5XHAOBhm38Vd+ZGNHqhiKZMAc=

EOT
external_ip = "3.237.236.102"
project_name = "wg-2"
server_priv = <<EOT
UO0HQjXI0k81NWivnUFpXWTL8tqaM/zJz5VF/gICvH8=

EOT
server_pub = <<EOT
diV+2mazpboChvt4hfdETvZGCXpLogLD0uVTSY+t4Ag=
```

To connect from a Raspberry Pi:
```
$ ./connect_pi.sh
```
To connect from a Linux machine which has an interface eno1
```
$ ./connect.sh
```

```
# curl -4 icanhazip.com
3.237.236.102
# wg
interface: wg0
  public key: 4y+vodTchACZHxMUu/5XHAOBhm38Vd+ZGNHqhiKZMAc=
  private key: (hidden)
  listening port: 54321

peer: diV+2mazpboChvt4hfdETvZGCXpLogLD0uVTSY+t4Ag=
  endpoint: 3.237.236.102:54321
  allowed ips: 0.0.0.0/0
  latest handshake: 1 minute, 58 seconds ago
  transfer: 20.93 KiB received, 30.53 KiB sent
```

To destroy the VPN:

```
$ terraform destroy --auto-approve
```

To teardown the connection from the client:

```
$ sudo ip link del wg0
```
