
# terraform integrating with packer_jenkins_sample


========================================
#!/bin/bash
packer validate --var-file packer-vars.json packer.json
echo ${aws_access_key}
if [ $? -eq 0 ]
then 
echo "validation sucessfull"
packer build --var-file packer-vars.json  packer.json 2>&1 | tee output.txt
tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > ami.txt
AMIID=$(cat ami.txt)
echo "variable imagename { default = \"$AMIID\" }" >> variables.tf 
terraform init
terraform apply --var-file test.tfvars --auto-approve
else
echo "validation is not sucessfull" 
exit 1
fi
==========================================


