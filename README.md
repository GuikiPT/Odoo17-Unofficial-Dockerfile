# Odoo 17 Unofficial Dockerfile
An Unnoficial Dockerfile for Odoo 17 created meanwhile Odoo not create the official one.


### Content
```
.
└── Content
    ├── Purpose of the repository
    └── How can I run Odoo 17?
        ├── DockerFile
        └── Docker Compose
```


### Purpose of the Repository
This repository was created be my, for self-usage of Odoo 17.
First off all I was testing the Odoo 17 be running from Odoo source, but for better organization, every project I had run into Docker Containers.
But Odoo not created an official DockerFile of Odoo17 yet (11/07/2023, the date of these post) so I created one by myself.

### How can I run Odoo 17?
The installation is pretty similar to Odoo Releases.
#### DockerFile
You can build an Dockerfile using mine be cloning these repo and executing something similar than:
```
docker build -t guikipt/odoo17
```

Or simply pull it from Github
```
docker pull ghcr.io/guikipt/odoo17-unofficial-dockerfile:main
```
#### Docker-Compose
After building or pulling it, you can use the Docker-Compose file inside `example` folder.
https://github.com/GuikiPT/Odoo17-Unofficial-Dockerfile/tree/main/example
