# SKParse

A description of this package.

## Usage
Wherever you want to use it remember to `import SKParse`

### Initialize (suggested inAppDelegate):

```
let configuration = ParseClientConfiguration {
    $0.applicationId = "Your-Application-id“
    $0.clientKey = "Your-Client-Key“
    $0.server = "Your-server-URL“
}   
Parse.initialize(withConfiguration: configuration)
```

### Make a Call
```
Parse.client.login(withUsername: "myUsername", password: "strongPassword") { (user, error) in
    ....
}
        
Parse.client.signup(withUsername: "kstefanou", password: "oscoekc", otherData: [:]) { (newUser, error) in
    ....
}
        
Parse.client.cloudFunction(withName: "getName", andParameters: [:]) { (user: APIParseUser?, error) in
    ....
}
```
