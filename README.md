[![Massdriver][logo]][website]

# gcp-cloud-sql-mysql

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

GCP Cloud SQL MySQL Database.

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS GCP](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=CIS+GCP+V1.1) | Center for Internet Security, GCP Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/gcp-cloud-sql-mysql/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fgcp-cloud-sql-mysql&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`database_configuration`** *(object)*: High availability, backups, other database settings can be configured here.
  - **`high_availability_enabled`** *(boolean)*: If set to true, GCP will manage a hot standby primary node for you. It will automatically fail over to the hot stanby in the event of a zonal or node failure drastically minimizing downtime. Default: `True`.
  - **`query_insights_enabled`** *(boolean)*: Enables query insights for your instance. Default: `False`.
  - **`retained_backup_count`** *(integer)*: The number of backups to keep. If another backup is made, the oldest one is deleted. Minimum: `0`. Maximum: `20`. Default: `0`.
- **`deletion_protection`** *(boolean)*: If the DB instance should have deletion protection enabled. Default: `True`.
- **`engine_version`** *(string)*: The major version of MySQL to use for your database. GCP manages minor version upgrades. Default: `MYSQL_8_0`.
  - **One of**
    - 8.x
    - 5.7
- **`instance_configuration`** *(object)*: Instance type, disk size, configure properties for your primary instance.
  - **`disk_size`** *(integer)*: The size of the primary database instance in GB. Minimum: `20`. Maximum: `3054`.
  - **`disk_type`** *(string)*: Solid State has better performance for mixtures of reads and writes. Use Hard Disks for continuous read workloads or for cheaper storage. Default: `PD_SSD`.
    - **One of**
      - Solid State
      - Hard Disk
  - **`tier`** *(string)*: The type of compute used for the master instance.
    - **One of**
      - Shared-core: 1 vCPU 600MB Memory
      - Shared-core: 1 vCPU 1.7GB Memory
      - General: 1 vCPU 3.8GB Memory
      - General: 2 vCPUs 3.8GB Memory
      - General: 4 vCPUs 15GB Memory
      - General: 8 vCPUs 40GB Memory
      - General: 16 vCPUs 61GB Memory
      - General: 32 vCPUs 122GB Memory
      - General: 64 vCPUs 245GB Memory
      - General: 96 vCPUs 368GB Memory
      - High Memory: 2 vCPUs 13GB Memory
      - High Memory: 4 vCPUs 26GB Memory
      - High Memory: 8 vCPUs 53GB Memory
      - High Memory: 16 vCPUs 106GB Memory
      - High Memory: 32 vCPUs 212GB Memory
      - High Memory: 64 vCPUs 425GB Memory
      - High Memory: 96 vCPUs 638GB Memory
- **`transaction_log_retention_days`** *(integer)*: The number of days to keep the transaction logs before deleting them. Minimum: `1`. Maximum: `7`. Default: `5`.
- **`username`** *(string)*: Primary DB username. Default: `root`.
## Examples

  ```json
  {
      "__name": "Development",
      "database_configuration": {
          "high_availability": false
      },
      "deletion_protection": false,
      "instance_configuration": {
          "disk_size": 20,
          "disk_type": "PD_HDD",
          "tier": "db-g1-small"
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`gcp_authentication`** *(object)*: GCP Service Account. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`auth_provider_x509_cert_url`** *(string)*: Auth Provider x509 Certificate URL. Default: `https://www.googleapis.com/oauth2/v1/certs`.

      Examples:
      ```json
      "https://example.com/some/path"
      ```

      ```json
      "https://massdriver.cloud"
      ```

    - **`auth_uri`** *(string)*: Auth URI. Default: `https://accounts.google.com/o/oauth2/auth`.

      Examples:
      ```json
      "https://example.com/some/path"
      ```

      ```json
      "https://massdriver.cloud"
      ```

    - **`client_email`** *(string)*: Service Account Email.

      Examples:
      ```json
      "jimmy@massdriver.cloud"
      ```

      ```json
      "service-account-y@gmail.com"
      ```

    - **`client_id`** *(string)*: .
    - **`client_x509_cert_url`** *(string)*: Client x509 Certificate URL.

      Examples:
      ```json
      "https://example.com/some/path"
      ```

      ```json
      "https://massdriver.cloud"
      ```

    - **`private_key`** *(string)*: .
    - **`private_key_id`** *(string)*: .
    - **`project_id`** *(string)*: .
    - **`token_uri`** *(string)*: Token URI. Default: `https://oauth2.googleapis.com/token`.

      Examples:
      ```json
      "https://example.com/some/path"
      ```

      ```json
      "https://massdriver.cloud"
      ```

    - **`type`** *(string)*: . Default: `service_account`.
  - **`specs`** *(object)*
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: GCP region. Must be one of: `['us-east1', 'us-east4', 'us-west1', 'us-west2', 'us-west3', 'us-west4', 'us-central1']`.

        Examples:
        ```json
        "us-west2"
        ```

- **`gcp_subnetwork`** *(object)*: A region-bound network for deploying GCP resources. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`gcp_global_network_grn`** *(string)*: GCP Resource Name (GRN).

        Examples:
        ```json
        "projects/my-project/global/networks/my-global-network"
        ```

        ```json
        "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
        ```

        ```json
        "projects/my-project/topics/my-pubsub-topic"
        ```

        ```json
        "projects/my-project/subscriptions/my-pubsub-subscription"
        ```

        ```json
        "projects/my-project/locations/us-west2/instances/my-redis-instance"
        ```

        ```json
        "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
        ```

      - **`grn`** *(string)*: GCP Resource Name (GRN).

        Examples:
        ```json
        "projects/my-project/global/networks/my-global-network"
        ```

        ```json
        "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
        ```

        ```json
        "projects/my-project/topics/my-pubsub-topic"
        ```

        ```json
        "projects/my-project/subscriptions/my-pubsub-subscription"
        ```

        ```json
        "projects/my-project/locations/us-west2/instances/my-redis-instance"
        ```

        ```json
        "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
        ```

      - **`vpc_access_connector`** *(string)*: GCP Resource Name (GRN).

        Examples:
        ```json
        "projects/my-project/global/networks/my-global-network"
        ```

        ```json
        "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
        ```

        ```json
        "projects/my-project/topics/my-pubsub-topic"
        ```

        ```json
        "projects/my-project/subscriptions/my-pubsub-subscription"
        ```

        ```json
        "projects/my-project/locations/us-west2/instances/my-redis-instance"
        ```

        ```json
        "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
        ```

  - **`specs`** *(object)*
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: GCP region. Must be one of: `['us-east1', 'us-east4', 'us-west1', 'us-west2', 'us-west3', 'us-west4', 'us-central1']`.

        Examples:
        ```json
        "us-west2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`authentication`** *(object)*: Authentication parameters for a MySQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific MySQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z/-]+$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=linkedin

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/issues
[release_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/gcp-cloud-sql-mysql.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/gcp-cloud-sql-mysql/blob/main/LICENSE

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2

[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=gcp-cloud-sql-mysql&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
