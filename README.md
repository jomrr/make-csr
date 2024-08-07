# make-csr

![GitHub License](https://img.shields.io/github/license/jomrr/make-csr?style=for-the-badge&color=blue&link=https%3A%2F%2Fgithub.com%2Fjomrr%2Fmake-csr%2Fblob%2Fmain%2FLICENSE) ![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/jomrr/make-csr?style=for-the-badge&color=blue&link=https%3A%2F%2Fgithub.com%2Fjomrr%2Fmake-csr%2Fissues)

Makefile for creating Certificate Signing Requests (CSRs) to be signed by an external CA.

## Getting started

The `make-csr` project is a Makefile-based tool for creating CSRs.
It provides a simple and automated way to generate and manage Certificate Signing Requests.

OpenSSL configuration files (\*.cnf) for the CSRs to create, are located in `etc/`.

The resulting private keys (\*.key) in PEM format, 
the certificate signing requests (\*.csr ) in PEM format and in txt format (*.txt)
for easy readability are generated in the subfolder `dist/`.

The directory structure is simplified for a centralized use case as follows.

### Directory Structure

| level 0 | level 1 | level 2 | description |
| ------- | ------- | ------- | ----------- |
| **make-csr** | | | base dir |
| | dist  | | issued certificate signing requests and keys |
| | etc | | openssl configuration files for CAs |
| | | server.example.com.cnf | example openssl configuration for csr  |

## Installation

To install `make-csr`, follow these steps:

1. Clone the repository: `cd ~ && git clone https://github.com/jomrr/make-csr.git ~/make-csr`
2. Change into the project directory: `cd ~/make-csr`
3. Customize DN settings in `$EDITOR ~/make-csr/Makefile`
4. Create `~/make-csr/etc/server/*.cnf` configuration files for the CSRs you want

## Usage Examples

Here are a few examples how to use `make-csr`.

Create private key and CSR for server.example.com.
```shell
$EDITOR etc/server.example.com.cnf
make server.example.com
```

Create keys and CSRs for all configs in etc/
```shell
make all
```

Cleanup all CSRs
```shell
make clean
```

Cleanup all keys, CSRs and txt files
```shell
make distclean
```

## License

This project is licensed under the [MIT License](https://github.com/jomrr/make-csr/blob/main/LICENSE).

## Author(s)

- @jomrr (2024)
