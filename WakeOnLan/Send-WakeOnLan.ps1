#SI(LOADPROXYFILE)
#   CHARGER LE FICHIER

## 
###

# Envoie un packet de mise en éveil
Send-WOLPacket #PARAM Sous-réseau, MAC

# Charger la configuration des proxy pour le fonctionnement inter-vlans
Load-WolProxyConfiguration
    