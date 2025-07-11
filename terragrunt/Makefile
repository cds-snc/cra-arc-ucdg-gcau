.PHONY: fmt checkov plan validate

fmt:
	terraform fmt -recursive aws &&\
	terragrunt hclfmt

checkov:
	checkov --directory=aws

plan:
	terragrunt run-all plan

validate:
	terragrunt run-all validate
