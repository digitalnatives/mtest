MTest
=====

Multiplatform / Browser testing via node.js servers to communicate over http and open browser sequentially.

### Installation

```npm install mtest -g```

In some Linux distrubutions sudo maybe neccessery for the **-g** flag.

### Configuration
MTest uses `mtest.json` for configuration:

```json
{
  "page": "http://{{ip/hostname}}:{{port}}",
	"ip": "{{ip of the machine runnig the runner}}",
	"port": 4001,
	"cluster": {
		"{{remote ip}}": ["{{browser}}","{{browser}}",...]
	}
}
```

### Executables
MTest comes with two executables:
  * `mtest-runner` this is responsible for calling remote machines. This process will exit with 0 for sucess or 1 for failure.
  * `mtest-server` this is the executable to be run on the servers

# Example
```json
{
  "page": "http://192.168.0.1:3000",
  "ip": "192.168.0.1",
  "port": 4001,
  "cluster": {
    "REMOTE1-ip": ["firefox","chrome","safari"],
    "REMOTE2-ip": ["firefox","chrome","ie"]
  }
}
```
  * Start mtest-server on REMOTE 1
  * Start mtest-server on REMOTE 2
  * Start mtest-runner on 192.168.0.1
  * REMOTE 1 opens firefox with url... sends results to localhost:4000
  * REMOTE 1 opens chrome with url ... sends results to localhost:4000
  * REMOTE 1 opens safari with url ... sends results to localhost:4000
  * REMOTE 1 sends results to 19.168.0.1:4001
  * REMOTE 2 opens firefox with url ... sends results to localhost:4000
  * REMOTE 2 opens chrome with url ... sends results to localhost:4000
  * REMOTE 2 opens ie with url ... sends results to localhost:4000
  * REMOTE 2 sends results to 19.168.0.1:4001
  * mtest-runner exits on 192.168.0.1
