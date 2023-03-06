# Real_Mqtt

This is an android app with mqtt capabilities.

## Getting Started:
  When the application starts, enter the following values:
  - Alias: whatever you want the server to be called
  - Server: test.mosquitto.org
  - UniqueID: a large random string
  - Port: 1883

## Add a device:
  When connected you can add a device with the '+' Button. The attributes are:
  - Name: Whatever you want it to ba called
  - Type: Whatever you want the type to be
  - Add action: You can add separate action by completing for each one the following values
    - Name: The name of the action
    - Topic: The topin in witch the value value will be published
    - Value: The value to be sent
 
## Sent the commands:
  When in the davice page, you will see all the actions you bound with the device as buttons. Press to send the value specified.
  
## Misc:
  Good debugging tool: https://mqttx.app/
