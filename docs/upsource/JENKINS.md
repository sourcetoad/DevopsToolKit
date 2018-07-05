# Jenkins Integration

### Upsource

Under the integration tab, fill out the `Authentication token` field with the correct token which can be found in password manager under `Upsource/Bitbucket/Jenkins Setup`.

Make sure you grab your project id before heading over to Jenkins.

### Jenkins

Copy the following to the `Groovy Postbuild` section in a `Post-build Actions` section of the project config.
Remember to substitute `xxxxxx` in the following block with your project id.

```
// Project id from Upsource, ensure authorization token is set in upsource project config to appropriate user:password
def upsource_project = "xxxxxx"

/* Do not edit below this line */
def result = manager.build.result
def env = manager.build.getEnvironment(manager.listener)
def build_url = env['BUILD_URL']
def build_commit = env['GIT_COMMIT']
def build_number = env['BUILD_NUMBER']
def job_name = env['JOB_NAME']
def cmd = ["/home/jenkins/upsource_notify.sh", "-s", result, "-j", job_name, "-n", build_number, "-u", build_url, "-c", build_commit, "-p", upsource_project ]
cmd.execute()
```

*Note*: Groovy Scripts must also be approved by a Jenkins admin or the script will fail, if you run into this issue please contact your Tech Lead.
