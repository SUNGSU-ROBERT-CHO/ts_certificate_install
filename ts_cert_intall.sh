#!/bin/bash

ROOTCA_CERT="./cert/OISTE WISeKey Global Root GB CA.pem"

ROOTCA_ALIAS1=oiste_wisekey_global_root_gb_ca
ROOTCA_ALIAS2=oistewisekeyglobalrootgbca
CACERTS_PASSWORD=changeit

# Check Root Certificate
function IsExistRootCA()
{
    EXIST_ROOT=`keytool -list -cacerts -storepass $CACERTS_PASSWORD |grep $ROOTCA_ALIAS1`
    if [[ -z "$EXIST_ROOT" ]];then
        EXIST_ROOT=`keytool -list -cacerts -storepass $CACERTS_PASSWORD |grep $ROOTCA_ALIAS2`
        if [[ -z "$EXIST_ROOT" ]];then
            return 0;
        fi
    fi
    echo Already Included RootCA : $EXIST_ROOT
    return 1;
}

# Import RootCA Certificate
function ImportRootCACertificate()
{
    keytool -import -cacerts -noprompt -file "$ROOTCA_CERT" -alias $ROOTCA_ALIAS1 -storepass $CACERTS_PASSWORD
    echo Import RootCA : $ROOTCA_ALIAS1
}

IsExistRootCA

if [ $? -eq 0 ]; then
    ImportRootCACertificate
fi

