# Overview
This project is intended to provide a way to rapidly begin Splunk app development using Vagrant.

This project is meant for use with Vagrant, a tool for building and managing virtual machines. The project is not provider specific but has been tested primarily with Virtualbox and VMware Workstation/Fusion. 

By default the project leverages a base box running Ubuntu 18 with Splunk installed but not configured. Provisioning scripts provide the initial configuration that Splunk needs to start. Other base boxes can be leveraged, but a developer must ensure that they install Splunk to the box before running any of the included automations

## Requirements
Usage of this project requires:
- Virtual machine provider (Virtualbox, VMware, Hyper-V, etc.)
- Vagrant binary
- Vagrant plugins:
  - vagrant-hosts
  - vagrant-hostsupdater
  
## Usage
This project is intended to be used in one of two methods:
- Direct clone and copy, or
- GitHub Template

### Cloning
Clone this repository like any other git repo and copy the portions of the project you need for your Splunk app project. For the project to work as intended, maintain the directory structure of:
```
src/
  app1/
  app2/
  ...
vagrant/
  scripts/
  architecture1/
  architecture2/
  ...
```

### GitHub Template
The preferred method of use for this project is to use the GitHub template repository feature. The GitHub mirror of the Vagabond project is set as a template repository. Therefore, a user can do a limited version of forking. Unlike a truly forked repo, the new repository will not include the git history. The nature of this project precludes any value in setting an upstream therefore it is not recommended unless you're willing to de-conflict merges on every update.

## Syncing Apps
The actual Splunk apps to be developed should be placed in the `src/` directory. These apps can then be added to the virtual machines through Vagrant synced folders. See the Vagrant documentation for specifics on how to configure synced folders.

## Supported Architectures
This project currently supports the following Splunk architectures:
- Single Server (`single-server`)
- Single Search Head with a single Indexer search peer (`search-indexer`)
- 3-node Search Head Cluster with single Indexer search peer (`shc-indexer`)

There will be upcoming support for:
- Single Search Head with 2-node Indexer Cluster
- 3-node Search Head Cluster with 2-node Indexer Cluster
- Deployment Server and a configurable number of forwarders
- Single Search Head with single Indexer search peer and a Universal Forwarder

### Management Servers
Any architecture that requires the use of a Splunk management server (Deployer, Cluster Master, Deployment Server) will include that management server.

From the list of currently supported architectures this currently only includes the deployer for the `shc-indexer` architecture.