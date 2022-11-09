from brownie import Contract, accounts

def main():
    admin= accounts[0]
    ss= Contract.deploy(100, {
        "from": admin
    })
    print(ss)

    
