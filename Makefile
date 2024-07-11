# Makefile for generating certificate signing requests (CSRs)

# shell to use
SHELL				:= bash
# openssl binary
OPENSSL				:= /usr/bin/openssl

# distiguished name defaults
export DN_C			?= DE
export DN_ST		?= Nordrhein-Westfalen
export DN_L			?= Düsseldorf
export DN_O			?= Beispiel Organisation
export DN_OU		?= $(DN_O) PKI

################################################################################
# Key and hash algorithm settings
################################################################################

# default RSA bit length in cnf files
export DEFAULT_BITS	?= 4096

# default settings for hash in cnf files
export DEFAULT_MD	?= sha3-256

# Certificate Private Keys
# param for openssl genpkey -algorithm $(CPK_ALG)
# NOTE: ED25519 p12 client certificates still fail to import in Browsers
#CPK_ALG					?= ED25519
CPK_ALG				?= RSA -pkeyopt rsa_keygen_bits:$(DEFAULT_BITS)

# find etc/*.cnf files for dynamic targets
CONFIGS				:= $(shell find etc -type f -name "*.cnf" -execdir basename {} .cnf ';')

# keep these files
.PRECIOUS: \
	dist/%.csr \
	dist/%.key \
	dist/%.txt \
	etc/%.cnf

# ******************************************************************************
# make targets start here
# ******************************************************************************

.PHONY: help
help:
	echo "Usage: make [target]"
	echo "       make all      Create all CSRs for cnf files in etc/"
	echo "       make <fqdn>   Create CSR for <fqdn> from etc/<fqdn>.cnf in dist/<fqdn>.{key,csr}"
	echo "Static conf is provided by etc/<fqdn>.cnf"

# delete CSRs in dist/
.PHONY: clean
clean:
	@rm dist/*.csr

--dist/:
	@mkdir -p dist/

# delete dist/
.PHONY: distclean
distclean:
	@rm -r dist/

# create Private KEY
dist/%.key: | --dist/
	@$(OPENSSL) genpkey -out $@ -algorithm $(CPK_ALG)

# create CSR, config is selected by calling target
dist/%.csr: | dist/%.key
	@$(OPENSSL) req -batch -new -config etc/$*.cnf -key dist/$*.key -out $@ -outform PEM

# export CSR in txt format
dist/%.txt: dist/%.csr
	@$(OPENSSL) req -text -noout -in $< > $@

# dynamic target for etc/*.cnf files
.PHONY: $(CONFIGS)
$(CONFIGS): %: dist/%.txt
	@echo $*

# create all CSRs
.PHONY: all
all: $(CONFIGS)
