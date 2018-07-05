# Upsource

Many, if not all, actions described within this guide will only be available to Tech Leads. If you need a new project created, please contact your Tech Lead.

At many points password manager card `Upsource/Bitbucket/Jenkins Setup` is reference within these docs.

* [Upsource Project](CREATE_PROJECT.md)
* [Jenkins](JENKINS.md)
* [JIRA](JIRA.md)

## Linking BitBucket repo to Upsource project

### Access Key
Add an Access Key for Upsource to the project settings. Key can be found in password manager under `Upsource/Bitbucket/Jenkins Setup`.

### Webhook on commit

Each project should have a webhook: `https://[UPSOURCE URL]/~vcs/<project-id-from-upsource>`

## .idea files to ignore

Copy to your root .gitignore to allow Upsource to provide code intelligence.

```.gitignore
.idea
!.idea/inspectionProfiles/Project_Default.xml
!.idea/vcs.xml
!.idea/modules.xml
!.idea/Core.iml
!.idea/codeStyleSettings.xml
```

This is [referenced](https://upsource-support.jetbrains.com/hc/en-us/community/posts/206756749-question-about-php-support?page=1#community_comment_207738889) from a JetBrains employee
