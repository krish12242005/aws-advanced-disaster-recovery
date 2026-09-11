import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CONFIG_FILE = ROOT / "config" / "dr-config.json"


def load_config():
    with open(CONFIG_FILE, "r", encoding="utf-8") as file:
        return json.load(file)


def test_project_configuration():
    config = load_config()

    assert config["project"] == "aws-advanced-disaster-recovery"
    assert config["region"] == "ap-south-1"


def test_multi_az_architecture():
    config = load_config()

    assert config["architecture"]["availability_zones"] == 2
    assert config["architecture"]["database"] == "RDS PostgreSQL Multi-AZ"
    assert config["scalability"]["multi_az"] is True


def test_backup_configuration():
    config = load_config()

    assert config["architecture"]["backup"] == "AWS Backup"
    assert config["recovery"]["backup_retention_days"] == 35
    assert config["recovery"]["rds_backup_retention_days"] == 7


def test_s3_resilience():
    config = load_config()

    assert config["recovery"]["s3_versioning"] is True
    assert config["recovery"]["s3_encryption"] == "AES256"
    assert config["security"]["public_access_block"] is True


def test_security_configuration():
    config = load_config()

    assert config["security"]["public_database"] is False
    assert config["security"]["private_application_subnets"] is True
    assert config["security"]["iam_least_privilege"] is True


def test_required_terraform_modules():
    modules = [
        "vpc",
        "alb",
        "ec2",
        "rds",
        "s3",
        "backup",
        "iam",
        "route53",
    ]

    for module in modules:
        module_path = ROOT / "terraform" / "modules" / module
        assert module_path.exists(), f"Missing Terraform module: {module}"

        assert (module_path / "main.tf").exists()
        assert (module_path / "variables.tf").exists()
        assert (module_path / "outputs.tf").exists()


if __name__ == "__main__":
    tests = [
        test_project_configuration,
        test_multi_az_architecture,
        test_backup_configuration,
        test_s3_resilience,
        test_security_configuration,
        test_required_terraform_modules,
    ]

    for test in tests:
        test()
        print(f"PASS: {test.__name__}")

    print("\nAll disaster recovery tests passed.")
